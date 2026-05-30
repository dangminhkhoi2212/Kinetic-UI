# kinetic_ui — Project Specification

> Flutter UI component library theo phong cách Shadcn/UI.  
> Copy-paste source code thay vì pub dependency. CLI-driven. Full ownership.

---

## Triết lý thiết kế

- **Không phải pub package runtime** — CLI copy source code thẳng vào `/lib/ui/` của project
- **Full ownership** — user sở hữu và tự chỉnh sửa mọi component
- **Chỉ 1 pub package duy nhất** — `kinetic_ui_tokens` (design tokens)
- **Registry-based** — mọi component lưu trên GitHub raw, CLI fetch về

---

## Tên chính thức

| Item | Giá trị |
|---|---|
| Thư viện | `kinetic_ui` |
| CLI command | `kinetic` |
| Tokens package | `kinetic_ui_tokens` |
| Registry base URL | `https://raw.githubusercontent.com/dangminhkhoi2212/Kinetic-UI/master/registry` |
| Install | `dart pub global activate kinetic_ui` |

---

## Cấu trúc repository

```
kinetic_ui/
├── cli/                          # CLI tool (Dart, ship as pub global)
│   ├── bin/
│   │   └── kinetic.dart          # entry point
│   ├── lib/
│   │   ├── commands/
│   │   │   ├── init.dart
│   │   │   ├── add.dart
│   │   │   ├── list.dart
│   │   │   └── diff.dart
│   │   ├── registry.dart         # HTTP client cho GitHub raw
│   │   └── installer.dart        # file copy + pubspec patch
│   └── pubspec.yaml
│
├── registry/                     # Deploy tĩnh trên GitHub
│   ├── registry.json             # Index toàn bộ components
│   └── components/
│       ├── button/
│       │   ├── meta.json
│       │   └── button.dart
│       ├── card/
│       │   ├── meta.json
│       │   └── card.dart
│       └── ...
│
├── packages/
│   └── kinetic_ui_tokens/        # Pub package duy nhất
│       ├── lib/
│       │   ├── kinetic_ui_tokens.dart
│       │   ├── colors.dart
│       │   ├── typography.dart
│       │   └── spacing.dart
│       └── pubspec.yaml
│
└── docs/                         # Next.js + MDX docs site
```

---

## CLI commands

```bash
kinetic init                      # khởi tạo /lib/ui/ + copy theme base
kinetic add button                # thêm 1 component
kinetic add button card dialog    # thêm nhiều component cùng lúc
kinetic list                      # xem tất cả components
kinetic list --tag=form           # lọc theo tag
kinetic diff button               # so sánh local vs registry
kinetic update button             # update (hỏi trước khi overwrite)
```

---

## Cấu trúc project của user sau khi init

```
my_flutter_app/
└── lib/
    └── ui/
        ├── components/           # Components được copy vào đây
        │   ├── button.dart
        │   ├── card.dart
        │   └── ...
        ├── theme/
        │   ├── app_theme.dart
        │   ├── colors.dart
        │   ├── typography.dart
        │   └── spacing.dart
        └── hooks/
            ├── use_theme.dart
            └── use_toast.dart
```

---

## pubspec.yaml của CLI

```yaml
name: kinetic_ui
description: Flutter UI component CLI — inspired by shadcn/ui
version: 1.0.0

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  args: ^2.4.0
  http: ^1.2.0
  path: ^1.9.0
  yaml: ^3.1.0
  yaml_edit: ^2.2.0

dev_dependencies:
  lints: ^3.0.0
  test: ^1.25.0
```

---

## Registry format

### `registry.json` (index)

```json
{
  "version": "1.0.0",
  "components": [
    { "name": "button",   "description": "Accessible button với multiple variants", "tags": ["form", "action"] },
    { "name": "card",     "description": "Container surface với padding chuẩn",     "tags": ["layout"] },
    { "name": "dialog",   "description": "Modal dialog accessible",                 "tags": ["overlay"] },
    { "name": "input",    "description": "Text input field",                        "tags": ["form"] },
    { "name": "badge",    "description": "Status/label badge",                      "tags": ["display"] },
    { "name": "skeleton", "description": "Loading placeholder",                     "tags": ["feedback"] },
    { "name": "toast",    "description": "Notification toast",                      "tags": ["feedback", "overlay"] }
  ]
}
```

### `components/<name>/meta.json`

```json
{
  "name": "button",
  "description": "Accessible button với multiple variants",
  "version": "1.0.0",
  "files": ["button.dart"],
  "dependencies": {
    "pub": ["kinetic_ui_tokens"],
    "components": []
  },
  "variants": ["solid", "outline", "ghost", "destructive"],
  "tags": ["form", "action"]
}
```

---

## Source files đã được thiết kế

### `cli/lib/registry.dart`

```dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const _registryBase =
    'https://raw.githubusercontent.com/dangminhkhoi2212/Kinetic-UI/master/registry';

class RegistryClient {
  final http.Client _http;

  RegistryClient({http.Client? client}) : _http = client ?? http.Client();

  Future<Map<String, dynamic>> fetchIndex() async {
    final uri = Uri.parse('$_registryBase/registry.json');
    final res = await _http.get(uri).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw RegistryException('Registry timeout. Kiểm tra mạng.'),
    );

    if (res.statusCode != 200) {
      throw RegistryException('Không fetch được registry (HTTP ${res.statusCode})');
    }

    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<ComponentMeta> fetchMeta(String name) async {
    final uri = Uri.parse('$_registryBase/components/$name/meta.json');
    final res = await _http.get(uri);

    if (res.statusCode == 404) {
      throw RegistryException('Component "$name" không tồn tại trong registry.');
    }
    if (res.statusCode != 200) {
      throw RegistryException('Lỗi fetch meta "$name" (HTTP ${res.statusCode})');
    }

    return ComponentMeta.fromJson(jsonDecode(res.body));
  }

  Future<String> fetchFileContent(String relativePath) async {
    final uri = Uri.parse('$_registryBase/$relativePath');
    final res = await _http.get(uri);

    if (res.statusCode != 200) {
      throw RegistryException('Không fetch được file: $relativePath');
    }

    return res.body;
  }

  void dispose() => _http.close();
}

class ComponentMeta {
  final String name;
  final String description;
  final String version;
  final List<String> files;
  final List<String> pubDeps;
  final List<String> componentDeps;

  const ComponentMeta({
    required this.name,
    required this.description,
    required this.version,
    required this.files,
    required this.pubDeps,
    required this.componentDeps,
  });

  factory ComponentMeta.fromJson(Map<String, dynamic> json) => ComponentMeta(
    name: json['name'] as String,
    description: json['description'] as String,
    version: json['version'] as String,
    files: List<String>.from(json['files'] as List),
    pubDeps: List<String>.from((json['dependencies']?['pub'] as List?) ?? []),
    componentDeps: List<String>.from(
      (json['dependencies']?['components'] as List?) ?? [],
    ),
  );
}

class RegistryException implements Exception {
  final String message;
  const RegistryException(this.message);

  @override
  String toString() => message;
}
```

### `cli/lib/installer.dart`

```dart
import 'dart:io';
import 'package:path/path.dart' as p;
import 'registry.dart';

class Installer {
  final RegistryClient registry;
  final String projectRoot;

  Installer({required this.registry, required this.projectRoot});

  Future<void> install(String name, {bool force = false}) async {
    final meta = await registry.fetchMeta(name);

    // 1. Resolve component dependencies đệ quy
    await _resolveDeps(meta.componentDeps, force: force);

    // 2. Copy từng file về project
    for (final relativePath in meta.files) {
      await _copyFile(
        registryPath: 'components/$name/$relativePath',
        destPath: p.join(projectRoot, 'lib', 'ui', 'components', relativePath),
        force: force,
      );
    }

    // 3. Add pub dependencies
    if (meta.pubDeps.isNotEmpty) {
      await _addPubDependencies(meta.pubDeps);
    }

    _success('Installed: ${meta.name} v${meta.version}');
  }

  Future<void> installThemeBase() async {
    const themeFiles = [
      'theme/app_theme.dart',
      'theme/colors.dart',
      'theme/typography.dart',
      'theme/spacing.dart',
    ];

    for (final file in themeFiles) {
      await _copyFile(
        registryPath: 'base/$file',
        destPath: p.join(projectRoot, 'lib', 'ui', file),
        force: false,
      );
    }
  }

  Future<void> _resolveDeps(List<String> deps, {required bool force}) async {
    for (final dep in deps) {
      final destFile = File(
        p.join(projectRoot, 'lib', 'ui', 'components', '$dep.dart'),
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
  }) async {
    final destFile = File(destPath);

    if (destFile.existsSync() && !force) {
      final overwrite = _prompt('⚠️  $destPath đã tồn tại. Overwrite? (y/N): ');
      if (overwrite.toLowerCase() != 'y') {
        _warn('Skipped: $destPath');
        return;
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
    );

    if (result.exitCode != 0) {
      _warn('flutter pub add failed. Thêm thủ công:\n'
            '  flutter pub add ${packages.join(' ')}');
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
  void _warn(String msg)    => print('\x1B[33m$msg\x1B[0m');
  void _info(String msg)    => print('\x1B[36m$msg\x1B[0m');
}
```

### `cli/lib/commands/init.dart`

```dart
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

    print('\x1B[36mFetching theme base from registry...\x1B[0m');
    try {
      await installer.installThemeBase();
    } on RegistryException catch (e) {
      print('\x1B[31mRegistry error: $e\x1B[0m');
      exit(1);
    } finally {
      registry.dispose();
    }

    await _patchPubspec(projectRoot);
    _printNextSteps();
  }

  void _assertFlutterProject(String root) {
    final pubspec = File(p.join(root, 'pubspec.yaml'));
    if (!pubspec.existsSync()) {
      print('❌  Không tìm thấy pubspec.yaml.');
      exit(1);
    }
    if (!pubspec.readAsStringSync().contains('flutter:')) {
      print('❌  pubspec.yaml không phải Flutter project.');
      exit(1);
    }
  }

  void _createDirectories(String root) {
    for (final dir in ['lib/ui/components', 'lib/ui/theme', 'lib/ui/hooks']) {
      final d = Directory(p.join(root, dir));
      if (!d.existsSync()) {
        d.createSync(recursive: true);
        print('\x1B[32m  ✔ Created $dir/\x1B[0m');
      }
    }
  }

  Future<void> _patchPubspec(String root) async {
    final pubspec = File(p.join(root, 'pubspec.yaml'));
    var content = pubspec.readAsStringSync();
    if (content.contains('kinetic_ui_tokens')) return;

    content = content.replaceFirst(
      RegExp(r'(dependencies:\s*\n)'),
      '\$1  kinetic_ui_tokens: ^1.0.0\n',
    );
    await pubspec.writeAsString(content);
    print('\x1B[32m  ✔ Added kinetic_ui_tokens to pubspec.yaml\x1B[0m');
  }

  void _printNextSteps() {
    print('''

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

     \x1B[36mkinetic add button\x1B[0m
     \x1B[36mkinetic add card dialog\x1B[0m

  3. Xem tất cả components:

     \x1B[36mkinetic list\x1B[0m
''');
  }
}
```

### `cli/bin/kinetic.dart`

```dart
import 'package:args/command_runner.dart';
import '../lib/commands/init.dart';
import '../lib/commands/add.dart';
import '../lib/commands/list.dart';

void main(List<String> arguments) async {
  final runner = CommandRunner<void>('kinetic', 'kinetic_ui — Flutter UI component CLI')
    ..addCommand(_InitCmd())
    ..addCommand(_AddCmd())
    ..addCommand(_ListCmd());

  try {
    await runner.run(arguments);
  } on UsageException catch (e) {
    print(e);
    exit(1);
  }
}

class _InitCmd extends Command<void> {
  @override String get name => 'init';
  @override String get description => 'Khởi tạo kinetic_ui trong project hiện tại';

  @override
  Future<void> run() => InitCommand().run();
}

class _AddCmd extends Command<void> {
  @override String get name => 'add';
  @override String get description => 'Thêm component vào project';

  _AddCmd() {
    argParser.addFlag('force', abbr: 'f', help: 'Overwrite nếu đã tồn tại');
  }

  @override
  Future<void> run() async {
    final names = argResults!.rest;
    if (names.isEmpty) {
      print('Usage: kinetic add <component> [component...]');
      exit(1);
    }
    await AddCommand().run(names, force: argResults!['force'] as bool);
  }
}
```

---

## Design Token system (`kinetic_ui_tokens`)

### `KineticTokens` class

```dart
@immutable
class KineticTokens extends ThemeExtension<KineticTokens> {
  const KineticTokens({
    required this.primary,
    required this.onPrimary,
    required this.destructive,
    required this.onDestructive,
    required this.muted,
    required this.border,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
  });

  final Color primary;
  final Color onPrimary;
  final Color destructive;
  final Color onDestructive;
  final Color muted;
  final Color border;
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;

  static const light = KineticTokens(
    primary:       Color(0xFF09090B),
    onPrimary:     Color(0xFFFFFFFF),
    destructive:   Color(0xFFEF4444),
    onDestructive: Color(0xFFFFFFFF),
    muted:         Color(0xFFF4F4F5),
    border:        Color(0xFFE4E4E7),
    radiusSm: 6, radiusMd: 8, radiusLg: 12,
  );

  static const dark = KineticTokens(
    primary:       Color(0xFFFAFAFA),
    onPrimary:     Color(0xFF09090B),
    destructive:   Color(0xFF7F1D1D),
    onDestructive: Color(0xFFFEF2F2),
    muted:         Color(0xFF27272A),
    border:        Color(0xFF27272A),
    radiusSm: 6, radiusMd: 8, radiusLg: 12,
  );

  @override
  KineticTokens copyWith({ /* tất cả fields nullable */ }) => KineticTokens(/* ... */);

  @override
  KineticTokens lerp(KineticTokens other, double t) => KineticTokens(/* lerp từng field */);
}
```

### Dùng trong app

```dart
MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: [KineticTokens.light],
  ),
  darkTheme: ThemeData.dark().copyWith(
    extensions: [KineticTokens.dark],
  ),
)

// Đọc token trong widget
final tokens = Theme.of(context).extension<KineticTokens>()!;
```

---

## Component example: `button.dart`

```dart
// lib/ui/components/button.dart
// Generated by kinetic_ui — free to modify

import 'package:flutter/material.dart';
import 'package:kinetic_ui_tokens/kinetic_ui_tokens.dart';

enum ButtonVariant { solid, outline, ghost, destructive }
enum ButtonSize    { sm, md, lg }

class KButton extends StatelessWidget {
  const KButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant   = ButtonVariant.solid,
    this.size      = ButtonSize.md,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.fullWidth = false,
  });

  final Widget          child;
  final VoidCallback?   onPressed;
  final ButtonVariant   variant;
  final ButtonSize      size;
  final Widget?         leading;
  final Widget?         trailing;
  final bool            isLoading;
  final bool            fullWidth;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;

    final (bgColor, fgColor, borderColor) = switch (variant) {
      ButtonVariant.solid       => (tokens.primary,       tokens.onPrimary,     Colors.transparent),
      ButtonVariant.outline     => (Colors.transparent,   tokens.primary,       tokens.primary),
      ButtonVariant.ghost       => (Colors.transparent,   tokens.primary,       Colors.transparent),
      ButtonVariant.destructive => (tokens.destructive,   tokens.onDestructive, Colors.transparent),
    };

    final (height, hPad, fontSize) = switch (size) {
      ButtonSize.sm => (32.0, 12.0, 13.0),
      ButtonSize.md => (40.0, 16.0, 14.0),
      ButtonSize.lg => (48.0, 20.0, 16.0),
    };

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor:   bgColor,
          foregroundColor:   fgColor,
          padding:           EdgeInsets.symmetric(horizontal: hPad),
          side:              BorderSide(color: borderColor, width: 1),
          shape:             RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(tokens.radiusMd),
                             ),
          textStyle:         TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
        ),
        child: isLoading
          ? SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: fgColor),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                if (leading  != null) leading!,
                child,
                if (trailing != null) trailing!,
              ],
            ),
      ),
    );
  }
}
```

---

## Naming conventions

| Loại | Convention | Ví dụ |
|---|---|---|
| Widget class | `K` prefix + PascalCase | `KButton`, `KCard`, `KDialog` |
| Enum variants | camelCase | `ButtonVariant.solid` |
| Token class | `KineticTokens` | — |
| File names | snake_case | `button.dart`, `app_theme.dart` |
| CLI command | `kinetic` | `kinetic add button` |

---

## Component roadmap

### Phase 1 — Core (ưu tiên build trước)
`button` · `input` · `label` · `badge` · `card` · `separator` · `skeleton`

### Phase 2 — Overlay
`dialog` · `sheet` (bottom/side) · `toast` · `tooltip` · `popover`

### Phase 3 — Form
`checkbox` · `radio` · `switch` · `select` · `slider` · `date_picker`

### Phase 4 — Navigation
`tabs` · `accordion` · `command` (spotlight search) · `navigation_menu`

---

## Tech stack tổng thể

| Layer | Công nghệ |
|---|---|
| CLI | Dart 3 (`args`, `http`, `path`, `yaml_edit`) |
| Registry hosting | GitHub raw files (free, zero-infra) |
| Tokens package | Pub.dev (`kinetic_ui_tokens`) |
| Component format | Plain `.dart` files, không codegen |
| Docs site | Next.js + MDX (Flutter Web iframe preview) |
| Minimum Flutter | 3.10+ (Dart 3, Records, Pattern matching) |

---

## Quyết định kỹ thuật quan trọng

1. **GitHub raw làm registry** — deploy miễn phí, không cần server, URL format ổn định
2. **Dart CLI thay vì Node.js** — ship `dart pub global activate kinetic_ui`, consistent với Flutter ecosystem  
3. **ThemeExtension thay vì InheritedWidget custom** — tích hợp native với `Theme.of(context)`, hot reload không mất state
4. **Copy source thay vì package** — user có thể sửa trực tiếp, không bị breaking change của upstream
5. **Records + Pattern matching** — yêu cầu Dart 3+, code sạch hơn nhiều cho variant/size switching
6. **Idempotent operations** — `init` có thể chạy lại nhiều lần không phá vỡ project
7. **Recursive dependency resolution** — `add dialog` tự động install `overlay` nếu chưa có

---

## Các file cần implement tiếp

- [ ] `cli/lib/commands/add.dart` — install với progress indicator
- [ ] `cli/lib/commands/list.dart` — hiển thị bảng components
- [ ] `cli/lib/commands/diff.dart` — so sánh local vs registry (checksum/version)
- [ ] `packages/kinetic_ui_tokens/lib/kinetic_ui_tokens.dart` — full token file
- [ ] `registry/components/button/button.dart` — production-ready button
- [ ] `registry/components/card/card.dart`
- [ ] `registry/base/theme/app_theme.dart`
- [ ] Test suite cho CLI commands
