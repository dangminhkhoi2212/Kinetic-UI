import 'dart:io';
import '../registry.dart';
import '../installer.dart';

class AddCommand {
  Future<void> run(List<String> names, {bool force = false}) async {
    final projectRoot = Directory.current.path;
    final registry = RegistryClient();
    final installer = Installer(registry: registry, projectRoot: projectRoot);

    try {
      for (final name in names) {
        stdout.writeln('\x1B[36m→ Installing $name...\x1B[0m');
        try {
          await installer.install(name, force: force);
        } on RegistryException catch (e) {
          stderr.writeln('\x1B[31m✗ $name: $e\x1B[0m');
        }
      }
    } finally {
      registry.dispose();
    }
  }

  Future<void> runAll({bool force = false}) async {
    final projectRoot = Directory.current.path;
    final registry = RegistryClient();
    final installer = Installer(registry: registry, projectRoot: projectRoot);

    try {
      final index = await registry.fetchIndex();
      final components = (index['components'] as List)
          .cast<Map<String, dynamic>>();
      final names = components.map((c) => c['name'] as String).toList();

      stdout.writeln(
        '\x1B[36m→ Installing all components (${names.length})...\x1B[0m',
      );

      for (final name in names) {
        stdout.writeln('\x1B[36m→ Installing $name...\x1B[0m');
        try {
          await installer.install(name, force: force);
        } on RegistryException catch (e) {
          stderr.writeln('\x1B[31m✗ $name: $e\x1B[0m');
        }
      }
    } finally {
      registry.dispose();
    }
  }
}
