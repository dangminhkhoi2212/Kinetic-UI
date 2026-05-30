import 'dart:io';
import 'package:path/path.dart' as p;
import '../registry.dart';
import '../installer.dart';

class InitCommand {
  Future<void> run() async {
    final projectRoot = Directory.current.path;

    _assertFlutterProject(projectRoot);
    _createDirectories(projectRoot);

    final registry = RegistryClient();
    final installer = Installer(registry: registry, projectRoot: projectRoot);

    stdout.writeln('\x1B[36mFetching theme base from registry...\x1B[0m');
    try {
      await installer.installThemeBase();
    } on RegistryException catch (e) {
      stderr.writeln('\x1B[31mRegistry error: $e\x1B[0m');
      exit(1);
    } finally {
      registry.dispose();
    }

    await _patchPubspec(projectRoot);
    await _runPubGet(projectRoot);
    _printNextSteps();
  }

  void _assertFlutterProject(String root) {
    final pubspec = File(p.join(root, 'pubspec.yaml'));
    if (!pubspec.existsSync()) {
      stderr.writeln('❌  Không tìm thấy pubspec.yaml.');
      exit(1);
    }
    if (!pubspec.readAsStringSync().contains('flutter:')) {
      stderr.writeln('❌  pubspec.yaml không phải Flutter project.');
      exit(1);
    }
  }

  void _createDirectories(String root) {
    for (final dir in ['lib/ui/components', 'lib/ui/theme', 'lib/ui/hooks']) {
      final d = Directory(p.join(root, dir));
      if (!d.existsSync()) {
        d.createSync(recursive: true);
        stdout.writeln('\x1B[32m  ✔ Created $dir/\x1B[0m');
      }
    }
  }

  Future<void> _patchPubspec(String root) async {
    final pubspec = File(p.join(root, 'pubspec.yaml'));
    var content = pubspec.readAsStringSync();
    if (content.contains('kinetic_ui_tokens')) return;

    // Detect indent level from existing dependencies (2-space or 4-space)
    final indentMatch = RegExp(r'dependencies:\s*\n(\s+)\S').firstMatch(content);
    final i1 = indentMatch?.group(1) ?? '  ';
    final i2 = '$i1  ';

    final lines = content.split('\n');
    final depIdx = lines.indexWhere((l) => RegExp(r'^dependencies:\s*$').hasMatch(l));
    if (depIdx == -1) {
      stderr.writeln('\x1B[33mKhông tìm thấy "dependencies:" trong pubspec.yaml\x1B[0m');
      return;
    }

    lines.insertAll(depIdx + 1, [
      '${i1}kinetic_ui_tokens:',
      '${i2}git:',
      '${i2}  url: https://github.com/dangminhkhoi2212/Kinetic-UI.git',
      '${i2}  path: packages/kinetic_ui_tokens',
    ]);

    await pubspec.writeAsString(lines.join('\n'));
    stdout.writeln('\x1B[32m  ✔ Added kinetic_ui_tokens to pubspec.yaml\x1B[0m');
  }

  Future<void> _runPubGet(String root) async {
    stdout.writeln('\x1B[36mRunning flutter pub get...\x1B[0m');
    final result = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: root,
    );
    if (result.exitCode != 0) {
      stderr.writeln('\x1B[33mflutter pub get failed. Chạy thủ công:\n  flutter pub get\x1B[0m');
    } else {
      stdout.writeln('\x1B[32m  ✔ flutter pub get\x1B[0m');
    }
  }

  void _printNextSteps() {
    stdout.writeln('''

\x1B[1m🎉  kinetic_ui initialized!\x1B[0m

Next steps:
  1. Wrap MaterialApp với KineticTokens:

     MaterialApp(
       theme: ThemeData.light().copyWith(
         extensions: [KineticTokens.light],
       ),
       darkTheme: ThemeData.dark().copyWith(
         extensions: [KineticTokens.dark],
       ),
     )

  2. Thêm components:

     \x1B[36mdart run kinetic_ui:kinetic add button\x1B[0m
     \x1B[36mdart run kinetic_ui:kinetic add card dialog\x1B[0m

  3. Xem tất cả components:

     \x1B[36mdart run kinetic_ui:kinetic list\x1B[0m
''');
  }
}
