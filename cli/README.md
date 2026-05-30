# kinetic_ui

Flutter UI component CLI inspired by [shadcn/ui](https://ui.shadcn.com/).  
Copy-paste source code directly into your project — full ownership, no runtime dependency.

---

## Installation

Add to your Flutter project's `pubspec.yaml`:

```yaml
dev_dependencies:
  kinetic_ui:
    git:
      url: https://github.com/dangminhkhoi2212/Kinetic-UI.git
      path: cli
```

```bash
flutter pub get
```

## Usage

```bash
# Initialize — creates lib/widgets/ui/ and lib/core/theme/
dart run kinetic_ui:kinetic init

# Add widgets
dart run kinetic_ui:kinetic add button
dart run kinetic_ui:kinetic add card dialog input

# List all available widgets
dart run kinetic_ui:kinetic list
dart run kinetic_ui:kinetic list --tag=form

# Compare local file vs registry
dart run kinetic_ui:kinetic diff button
```

## What `kinetic init` does

1. Creates `lib/widgets/ui/` and `lib/core/theme/`
2. Copies `kinetic_tokens.dart` — colors, spacing, typography, `KineticTokens` ThemeExtension
3. Copies `app_theme.dart`, `colors.dart`, `typography.dart`, `spacing.dart`

All files are yours to modify freely.

## Wrap your MaterialApp

```dart
import 'core/theme/kinetic_tokens.dart';

MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: const [KineticTokens.light],
  ),
  darkTheme: ThemeData.dark().copyWith(
    extensions: const [KineticTokens.dark],
  ),
)
```

## Use a widget

```dart
import 'widgets/ui/button.dart';

KButton(
  onPressed: () {},
  child: const Text('Click me'),
)

KButton(
  variant: ButtonVariant.destructive,
  onPressed: () {},
  child: const Text('Delete'),
)
```

## Customize tokens

Edit `lib/core/theme/kinetic_tokens.dart` directly:

```dart
static const light = KineticTokens(
  primary:   Color(0xFF6366F1),  // change to indigo
  radiusMd:  12,                 // rounder corners
  // ...
);
```

## Available widgets

| Widget | Class | Tags |
|---|---|---|
| button | `KButton` | form, action |
| card | `KCard`, `KCardHeader` | layout |
| input | `KInput` | form |
| badge | `KBadge` | display |
| skeleton | `KSkeleton` | feedback |
| separator | `KSeparator` | layout |
| label | `KLabel` | form |
| dialog | `KDialog`, `showKDialog()` | overlay |
| toast | `KToast` | feedback, overlay |

## Project structure after init

```
lib/
├── widgets/
│   └── ui/
│       ├── button.dart
│       └── ...
└── core/
    └── theme/
        ├── kinetic_tokens.dart   ← edit to customize
        ├── app_theme.dart
        ├── colors.dart
        ├── typography.dart
        └── spacing.dart
```

## Requirements

- Dart **3.0+**
- Flutter **3.10+**

## License

MIT
