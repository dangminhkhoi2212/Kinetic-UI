import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:kinetic_ui/registry.dart';

void main() {
  group('RegistryClient index parsing', () {
    test('all 9 registry components parse correctly', () async {
      final components = [
        'button', 'card', 'input', 'badge', 'skeleton',
        'separator', 'label', 'dialog', 'toast',
      ];

      final payload = jsonEncode({
        'version': '1.0.0',
        'components': components
            .map((n) => {'name': n, 'description': '$n component', 'tags': []})
            .toList(),
      });

      final client = RegistryClient(
        client: MockClient((_) async => http.Response(payload, 200)),
      );

      final index = await client.fetchIndex();
      final names = (index['components'] as List)
          .cast<Map<String, dynamic>>()
          .map((c) => c['name'] as String)
          .toList();

      expect(names, containsAll(components));
      client.dispose();
    });
  });

  group('ComponentMeta', () {
    test('fromJson parses all fields', () {
      final json = {
        'name':        'dialog',
        'description': 'Modal dialog',
        'version':     '2.1.0',
        'files':       ['dialog.dart'],
        'dependencies': {
          'pub':        ['kinetic_ui_tokens'],
          'components': ['button'],
        },
        'tags': ['overlay'],
      };

      final meta = ComponentMeta.fromJson(json);
      expect(meta.name,          'dialog');
      expect(meta.version,       '2.1.0');
      expect(meta.files,         ['dialog.dart']);
      expect(meta.pubDeps,       ['kinetic_ui_tokens']);
      expect(meta.componentDeps, ['button']);
    });

    test('toString on RegistryException includes message', () {
      const e = RegistryException('test error');
      expect(e.toString(), 'test error');
    });
  });
}
