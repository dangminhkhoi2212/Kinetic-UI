import 'dart:io';
import 'package:path/path.dart' as p;
import 'registry.dart';

class Installer {
  final RegistryClient registry;
  final String projectRoot;

  Installer({required this.registry, required this.projectRoot});

  Future<void> install(String name, {bool force = false}) async {
    final meta = await registry.fetchMeta(name);

    await _resolveDeps(meta.componentDeps, force: force);

    for (final relativePath in meta.files) {
      await _copyFile(
        registryPath: 'components/$name/$relativePath',
        destPath: p.join(projectRoot, 'lib', 'widgets', 'ui', relativePath),
        force: force,
      );
    }

    if (meta.pubDeps.isNotEmpty) {
      await _addPubDependencies(meta.pubDeps);
    }

    _success('Installed: ${meta.name} v${meta.version}');
  }

  Future<void> installThemeBase() async {
    const themeFiles = ['theme/kinetic_tokens.dart', 'theme/app_theme.dart'];

    for (final file in themeFiles) {
      await _copyFile(
        registryPath: 'base/$file',
        destPath: p.join(projectRoot, 'lib', 'core', file),
        force: false,
        skipIfExists: true,
      );
    }
  }

  Future<void> _resolveDeps(List<String> deps, {required bool force}) async {
    for (final dep in deps) {
      final destFile = File(
        p.join(projectRoot, 'lib', 'widgets', 'ui', '$dep.dart'),
      );
      if (!destFile.existsSync()) {
        _info('Installing dependency: $dep');
        await install(dep, force: force);
      }
    }
  }

  Future<void> _copyFile({
    required String registryPath,
    required String destPath,
    required bool force,
    bool skipIfExists = false,
  }) async {
    final destFile = File(destPath);

    if (destFile.existsSync()) {
      if (skipIfExists) return;
      if (!force) {
        final overwrite = _prompt(
          '⚠️  $destPath already exists. Overwrite? (y/N): ',
        );
        if (overwrite.toLowerCase() != 'y') {
          _warn('Skipped: $destPath');
          return;
        }
      }
    }

    final content = await registry.fetchFileContent(registryPath);
    await destFile.parent.create(recursive: true);
    await destFile.writeAsString(content, flush: true);
    _success('  ✔ $destPath');
  }

  Future<void> _addPubDependencies(List<String> packages) async {
    _info('\nAdding pub dependencies...');

    final result = await Process.run(
      'flutter',
      ['pub', 'add', ...packages],
      workingDirectory: projectRoot,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      _warn(
        'flutter pub add failed. Add manually:\n'
        '  flutter pub add ${packages.join(' ')}',
      );
      return;
    }

    for (final pkg in packages) {
      _success('  ✔ Added pub: $pkg');
    }
  }

  String _prompt(String message) {
    stdout.write(message);
    return stdin.readLineSync() ?? '';
  }

  void _success(String msg) => print('\x1B[32m$msg\x1B[0m');
  void _warn(String msg) => print('\x1B[33m$msg\x1B[0m');
  void _info(String msg) => print('\x1B[36m$msg\x1B[0m');
}
