import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

String patchPubspec(String content) {
  if (content.contains('kinetic_ui_tokens')) return content;

  final indentMatch = RegExp(r'dependencies:\s*\n(\s+)\S').firstMatch(content);
  final i1 = indentMatch?.group(1) ?? '  ';
  final i2 = '$i1  ';

  final lines = content.split('\n');
  final depIdx = lines.indexWhere((l) => RegExp(r'^dependencies:\s*$').hasMatch(l));
  if (depIdx == -1) return content;

  lines.insertAll(depIdx + 1, [
    '${i1}kinetic_ui_tokens:',
    '${i2}git:',
    '${i2}  url: https://github.com/dangminhkhoi2212/Kinetic-UI.git',
    '${i2}  path: packages/kinetic_ui_tokens',
  ]);

  return lines.join('\n');
}

void main() {
  group('_patchPubspec indent detection', () {
    test('2-space indent — inserts at correct level', () {
      const yaml = '''
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
''';
      final result = patchPubspec(yaml);
      expect(result, contains('  kinetic_ui_tokens:'));
      expect(result, contains('    git:'));
      expect(result, contains('      url:'));
      // flutter: still at same level (2 spaces)
      expect(result, contains('  flutter:'));
    });

    test('4-space indent — inserts at correct level', () {
      const yaml = '''
dependencies:
    flutter:
        sdk: flutter
    cupertino_icons: ^1.0.8
''';
      final result = patchPubspec(yaml);
      expect(result, contains('    kinetic_ui_tokens:'));
      expect(result, contains('      git:'));
      expect(result, contains('        url:'));
      // flutter: still at same level (4 spaces)
      expect(result, contains('    flutter:'));
    });

    test('2-space — result is valid ordering (kinetic before flutter)', () {
      const yaml = 'dependencies:\n  flutter:\n    sdk: flutter\n';
      final result = patchPubspec(yaml);
      final kinIdx     = result.indexOf('kinetic_ui_tokens');
      final flutterIdx = result.indexOf('  flutter:');
      expect(kinIdx, lessThan(flutterIdx));
    });

    test('idempotent — không patch lần 2', () {
      const yaml = 'dependencies:\n  flutter:\n    sdk: flutter\n';
      final once  = patchPubspec(yaml);
      final twice = patchPubspec(once);
      expect(once, equals(twice));
    });
  });
}
