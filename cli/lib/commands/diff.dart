import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import '../registry.dart';

class DiffCommand {
  Future<void> run(String name) async {
    final projectRoot = Directory.current.path;
    final registry = RegistryClient();

    try {
      final meta = await registry.fetchMeta(name);

      stdout.writeln('\n\x1B[1mDiff: $name v${meta.version}\x1B[0m\n');

      var anyDiff = false;
      for (final file in meta.files) {
        final localPath = p.join(projectRoot, 'lib', 'ui', 'components', file);
        final localFile = File(localPath);

        if (!localFile.existsSync()) {
          stdout.writeln('\x1B[33m  ? $file  (not installed)\x1B[0m');
          anyDiff = true;
          continue;
        }

        final localContent  = localFile.readAsStringSync();
        final remoteContent = await registry.fetchFileContent('components/$name/$file');

        final localHash  = _sha256(localContent);
        final remoteHash = _sha256(remoteContent);

        if (localHash == remoteHash) {
          stdout.writeln('\x1B[32m  ✔ $file  (up to date)\x1B[0m');
        } else {
          stdout.writeln('\x1B[33m  ≠ $file  (local differs from registry)\x1B[0m');
          _printDiffSummary(localContent, remoteContent);
          anyDiff = true;
        }
      }

      if (!anyDiff) {
        stdout.writeln('\x1B[32mAll files are up to date.\x1B[0m');
      } else {
        stdout.writeln('\n  Run \x1B[36mkinetic update $name\x1B[0m to sync from registry.');
      }
    } on RegistryException catch (e) {
      stderr.writeln('\x1B[31m$e\x1B[0m');
      exit(1);
    } finally {
      registry.dispose();
    }
  }

  String _sha256(String content) =>
      sha256.convert(utf8.encode(content)).toString();

  void _printDiffSummary(String local, String remote) {
    final localLines  = local.split('\n');
    final remoteLines = remote.split('\n');
    final added   = remoteLines.length - localLines.length;
    final sign    = added >= 0 ? '+' : '';
    stdout.writeln('       \x1B[90m${localLines.length} local lines  →  '
        '${remoteLines.length} registry lines  ($sign$added)\x1B[0m');
  }
}
