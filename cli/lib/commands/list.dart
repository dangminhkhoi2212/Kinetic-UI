import 'dart:io';
import '../registry.dart';

class ListCommand {
  Future<void> run({String? tag}) async {
    final registry = RegistryClient();
    try {
      final index = await registry.fetchIndex();
      final components = (index['components'] as List)
          .cast<Map<String, dynamic>>();

      final filtered = tag == null
          ? components
          : components.where((c) {
              final tags = (c['tags'] as List?)?.cast<String>() ?? [];
              return tags.contains(tag);
            }).toList();

      if (filtered.isEmpty) {
        stdout.writeln(
          tag != null
              ? 'No components found with tag "$tag".'
              : 'Registry is empty.',
        );
        return;
      }

      _printTable(filtered, tag: tag);
    } on RegistryException catch (e) {
      stderr.writeln('\x1B[31m$e\x1B[0m');
      exit(1);
    } finally {
      registry.dispose();
    }
  }

  void _printTable(List<Map<String, dynamic>> components, {String? tag}) {
    final header = tag != null
        ? '\x1B[1mComponents (tag: $tag)\x1B[0m'
        : '\x1B[1mAll components\x1B[0m';
    stdout.writeln('\n$header\n');

    final nameWidth = components
        .map((c) => (c['name'] as String).length)
        .fold(0, (a, b) => a > b ? a : b)
        .clamp(4, 24);

    final divider = '${'─' * (nameWidth + 2)}┼${'─' * 42}┼${'─' * 20}';
    String fmt(String n, String d, String t) =>
        ' ${n.padRight(nameWidth)} │ ${d.padRight(40)} │ $t';

    stdout.writeln(fmt(' NAME', ' DESCRIPTION', ' TAGS'));
    stdout.writeln(divider);

    for (final c in components) {
      final name = c['name'] as String;
      final desc = (c['description'] as String).length > 40
          ? '${(c['description'] as String).substring(0, 37)}...'
          : c['description'] as String;
      final tags = ((c['tags'] as List?)?.cast<String>() ?? []).join(', ');
      stdout.writeln(fmt(name, desc, tags));
    }

    stdout.writeln(
      '\n  \x1B[36mkinetic add <name>\x1B[0m  to install a component',
    );
  }
}
