import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:kinetic_ui/registry.dart';

void main() {
  group('RegistryClient', () {
    test('fetchIndex returns parsed JSON on 200', () async {
      final payload = jsonEncode({
        'version': '1.0.0',
        'components': [
          {'name': 'button', 'description': 'A button', 'tags': ['form']},
        ],
      });

      final client = RegistryClient(
        client: MockClient((_) async => http.Response(payload, 200)),
      );

      final index = await client.fetchIndex();
      expect(index['version'], '1.0.0');
      expect((index['components'] as List).length, 1);
      client.dispose();
    });

    test('fetchIndex throws RegistryException on non-200', () async {
      final client = RegistryClient(
        client: MockClient((_) async => http.Response('Not Found', 404)),
      );

      expect(
        () => client.fetchIndex(),
        throwsA(isA<RegistryException>()),
      );
      client.dispose();
    });

    test('fetchMeta returns ComponentMeta on 200', () async {
      final payload = jsonEncode({
        'name':        'button',
        'description': 'Accessible button',
        'version':     '1.0.0',
        'files':       ['button.dart'],
        'dependencies': {'pub': ['kinetic_ui_tokens'], 'components': []},
        'tags': ['form'],
      });

      final client = RegistryClient(
        client: MockClient((_) async => http.Response(payload, 200)),
      );

      final meta = await client.fetchMeta('button');
      expect(meta.name, 'button');
      expect(meta.version, '1.0.0');
      expect(meta.pubDeps, contains('kinetic_ui_tokens'));
      expect(meta.componentDeps, isEmpty);
      client.dispose();
    });

    test('fetchMeta throws RegistryException on 404', () async {
      final client = RegistryClient(
        client: MockClient((_) async => http.Response('', 404)),
      );

      expect(
        () => client.fetchMeta('nonexistent'),
        throwsA(
          isA<RegistryException>().having(
            (e) => e.message,
            'message',
            contains('nonexistent'),
          ),
        ),
      );
      client.dispose();
    });

    test('fetchFileContent returns body on 200', () async {
      const content = '// dart code here';
      final client = RegistryClient(
        client: MockClient((_) async => http.Response(content, 200)),
      );

      final result = await client.fetchFileContent('components/button/button.dart');
      expect(result, content);
      client.dispose();
    });

    test('ComponentMeta.fromJson handles missing optional deps', () {
      final json = {
        'name':        'label',
        'description': 'A label',
        'version':     '1.0.0',
        'files':       ['label.dart'],
        'dependencies': <String, dynamic>{},
      };

      final meta = ComponentMeta.fromJson(json);
      expect(meta.pubDeps,       isEmpty);
      expect(meta.componentDeps, isEmpty);
    });
  });
}
