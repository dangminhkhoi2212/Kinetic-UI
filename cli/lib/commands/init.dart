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
    for (final dir in ['lib/widgets/ui', 'lib/core/theme', 'lib/core/hooks']) {
      final d = Directory(p.join(root, dir));
      if (!d.existsSync()) {
        d.createSync(recursive: true);
        stdout.writeln('\x1B[32m  ✔ Created $dir/\x1B[0m');
      }
    }
  }

  void _printNextSteps() {
    stdout.writeln('''

\x1B[1m🎉  kinetic_ui initialized!\x1B[0m

Next steps:
  1. Wrap MaterialApp với KineticTokens:

     import 'core/theme/kinetic_tokens.dart';

     MaterialApp(
       theme: ThemeData.light().copyWith(
         extensions: [KineticTokens.light],
       ),
       darkTheme: ThemeData.dark().copyWith(
         extensions: [KineticTokens.dark],
       ),
     )

  2. Thêm widgets:

     \x1B[36mdart run kinetic_ui:kinetic add button\x1B[0m
     \x1B[36mdart run kinetic_ui:kinetic add card dialog\x1B[0m

  3. Dùng widget trong code:

     import 'widgets/ui/button.dart';

  4. Xem tất cả widgets:

     \x1B[36mdart run kinetic_ui:kinetic list\x1B[0m
''');
  }
}
