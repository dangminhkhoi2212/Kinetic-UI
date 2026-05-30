import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:kinetic_ui/registry.dart';
import 'package:kinetic_ui/installer.dart';

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('kinetic_test_');
    // Create a minimal Flutter pubspec so Installer doesn't bail
    File(p.join(tempDir.path, 'pubspec.yaml'))
        .writeAsStringSync('name: test_app\nflutter:\n');
  });

  tearDown(() => tempDir.deleteSync(recursive: true));

  test('install copies component file to lib/ui/components/', () async {
    const dartSource = '// button widget code';

    final metaJson = jsonEncode({
      'name':        'button',
      'description': 'Button',
      'version':     '1.0.0',
      'files':       ['button.dart'],
      'dependencies': {'pub': [], 'components': []},
    });

    final mockClient = MockClient((req) async {
      if (req.url.path.endsWith('meta.json')) return http.Response(metaJson, 200);
      if (req.url.path.endsWith('button.dart')) return http.Response(dartSource, 200);
      return http.Response('', 404);
    });

    final registry  = RegistryClient(client: mockClient);
    final installer = Installer(registry: registry, projectRoot: tempDir.path);

    await installer.install('button', force: true);

    final dest = File(p.join(tempDir.path, 'lib', 'ui', 'components', 'button.dart'));
    expect(dest.existsSync(), isTrue);
    expect(dest.readAsStringSync(), dartSource);
  });

  test('install resolves component dependencies recursively', () async {
    const buttonSrc  = '// button';
    const dialogSrc  = '// dialog';

    final buttonMeta = jsonEncode({
      'name': 'button', 'description': '', 'version': '1.0.0',
      'files': ['button.dart'],
      'dependencies': {'pub': [], 'components': []},
    });
    final dialogMeta = jsonEncode({
      'name': 'dialog', 'description': '', 'version': '1.0.0',
      'files': ['dialog.dart'],
      'dependencies': {'pub': [], 'components': ['button']},
    });

    final mockClient = MockClient((req) async {
      final path = req.url.path;
      if (path.contains('dialog/meta'))  return http.Response(dialogMeta, 200);
      if (path.contains('button/meta'))  return http.Response(buttonMeta, 200);
      if (path.contains('dialog.dart'))  return http.Response(dialogSrc, 200);
      if (path.contains('button.dart'))  return http.Response(buttonSrc, 200);
      return http.Response('', 404);
    });

    final registry  = RegistryClient(client: mockClient);
    final installer = Installer(registry: registry, projectRoot: tempDir.path);

    await installer.install('dialog', force: true);

    final componentsDir = p.join(tempDir.path, 'lib', 'ui', 'components');
    expect(File(p.join(componentsDir, 'button.dart')).existsSync(), isTrue);
    expect(File(p.join(componentsDir, 'dialog.dart')).existsSync(), isTrue);
  });
}
