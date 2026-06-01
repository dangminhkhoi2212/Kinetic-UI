# kinetic_ui

Flutter UI component library inspired by [shadcn/ui](https://ui.shadcn.com/) — copy source code directly into your project instead of adding a runtime dependency. CLI-driven, full ownership.

---

## Philosophy

- **Not a runtime package** — the CLI copies source code straight into your `lib/widgets/ui/` folder
- **Full ownership** — you own every component and can modify it freely
- **One pub dependency** — `kinetic_ui_tokens` (design tokens, added automatically by `kinetic init`)
- **Registry-based** — components are served from GitHub raw; the CLI fetches them on demand

---

## Installation

Add to `pubspec.yaml` of your Flutter project:

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

Note: if you installed `kinetic_ui` before, remove it first and add it again to update:

```bash
flutter pub remove kinetic_ui
flutter pub get
```

---

## Quick start

### 1. Initialize in your Flutter project

```bash
cd my_flutter_app
dart run kinetic_ui:kinetic init
```

This will:
- Create `lib/widgets/ui/`, `lib/core/theme/`, `lib/core/hooks/`
- Copy theme base files (`kinetic_tokens.dart`, `app_theme.dart`, `colors.dart`, `typography.dart`, `spacing.dart`)
- Add `kinetic_ui_tokens` to your `pubspec.yaml`

### 2. Wrap `MaterialApp` with tokens

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

### 3. Add components

```bash
dart run kinetic_ui:kinetic add button
dart run kinetic_ui:kinetic add card dialog input    # multiple at once
```

### 4. Use the component

```dart
import 'widgets/ui/button.dart';

KButton(
  onPressed: () {},
  child: const Text('Click me'),
)
```

---

## CLI commands

| Command | Description |
|---|---|
| `dart run kinetic_ui:kinetic init` | Initialize `lib/widgets/ui/` + copy theme base |
| `dart run kinetic_ui:kinetic add <name...>` | Add one or more components |
| `dart run kinetic_ui:kinetic add <name> --force` | Overwrite existing file |
| `dart run kinetic_ui:kinetic list` | List all components in the registry |
| `dart run kinetic_ui:kinetic list --tag=form` | Filter by tag |
| `dart run kinetic_ui:kinetic diff <name>` | Compare local file vs registry (checksum) |

---

## Components

| Component | Class | Tags |
|---|---|---|
| `button` | `KButton` | form, action |
| `card` | `KCard`, `KCardHeader` | layout |
| `input` | `KInput` | form |
| `badge` | `KBadge` | display |
| `chip` | `KChip` | display |
| `avatar` | `KAvatar` | display |
| `alert` | `KAlert` | feedback |
| `checkbox` | `KCheckbox` | form |
| `radio` | `KRadioGroup`, `KRadioOption` | form |
| `kswitch` | `KSwitch` | form |
| `progress` | `KProgressBar`, `KProgressCircle` | feedback |
| `spinner` | `KSpinner` | feedback |
| `tabs` | `KTabs`, `KTabItem` | navigation |
| `slider` | `KSlider` | form |
| `skeleton` | `KSkeleton` | feedback |
| `separator` | `KSeparator` | layout |
| `label` | `KLabel` | form |
| `dialog` | `KDialog`, `showKDialog()` | overlay |
| `toast` | `KToast`, `KToast.show()` | feedback, overlay |

---

## Component examples

### KButton

```dart
// Variants × Colors (orthogonal — mix freely)
KButton(variant: ButtonVariant.solid,    color: ButtonColor.primary,   onPressed: () {}, child: Text('Solid'))
KButton(variant: ButtonVariant.flat,     color: ButtonColor.secondary, onPressed: () {}, child: Text('Flat'))
KButton(variant: ButtonVariant.bordered, color: ButtonColor.success,   onPressed: () {}, child: Text('Bordered'))
KButton(variant: ButtonVariant.outline,  color: ButtonColor.warning,   onPressed: () {}, child: Text('Outline'))
KButton(variant: ButtonVariant.shadow,   color: ButtonColor.danger,    onPressed: () {}, child: Text('Shadow'))
KButton(variant: ButtonVariant.faded,    color: ButtonColor.default_,  onPressed: () {}, child: Text('Faded'))

// Sizes
KButton(size: ButtonSize.sm, onPressed: () {}, child: Text('Small'))
KButton(size: ButtonSize.md, onPressed: () {}, child: Text('Medium'))
KButton(size: ButtonSize.lg, onPressed: () {}, child: Text('Large'))

// Radius
KButton(radius: ButtonRadius.none, onPressed: () {}, child: Text('Square'))
KButton(radius: ButtonRadius.md,   onPressed: () {}, child: Text('Rounded'))
KButton(radius: ButtonRadius.full, onPressed: () {}, child: Text('Pill'))  // default

// With icons
KButton(
  startContent: Icon(Icons.add),
  onPressed: () {},
  child: Text('New item'),
)

// States
KButton(isLoading: true, child: Text('Saving...'))
KButton(isDisabled: true, onPressed: () {}, child: Text('Disabled'))
KButton(fullWidth: true, onPressed: () {}, child: Text('Full width'))
KButton(isIconOnly: true, onPressed: () {}, child: Icon(Icons.favorite))
```

### KInput

```dart
KInput(
  label:        'Email',
  hint:         'name@example.com',
  helper:       'We will never share your email.',
  startContent: Icon(Icons.mail_outline),
  variant:      InputVariant.bordered,
  color:        InputColor.primary,
  onChanged:    (value) { /* ... */ },
)

// Error state
KInput(
  label:       'Password',
  error:       'Password must be at least 8 characters',
  obscureText: true,
)

// Variants: flat (default), bordered, faded, underlined
// Sizes: sm, md (default), lg
// Props: isDisabled, isReadOnly, maxLines, keyboardType, textInputAction
```

### KCard

```dart
KCard(
  header: KCardHeader(
    title:    Text('Card title'),
    subtitle: Text('Optional subtitle'),
    action:   KButton(size: ButtonSize.sm, onPressed: () {}, child: Text('Edit')),
  ),
  child:  Text('Card body content'),
  footer: Text('Footer info'),
  onTap:  () { /* tappable card */ },
)

// Variants: default_ (default), secondary, tertiary, transparent
```

### KBadge

```dart
// Count badge overlaid on any widget
KBadge(
  count:     5,
  color:     BadgeColor.danger,
  child:     Icon(Icons.notifications),
)

// Variants
KBadge(count: 3, variant: BadgeVariant.solid,  color: BadgeColor.primary, child: widget)
KBadge(count: 3, variant: BadgeVariant.flat,   color: BadgeColor.success, child: widget)
KBadge(count: 3, variant: BadgeVariant.faded,  color: BadgeColor.warning, child: widget)
KBadge(count: 3, variant: BadgeVariant.shadow, color: BadgeColor.danger,  child: widget)

// Dot badge (no count)
KBadge(isDot: true, child: Icon(Icons.mail))

// Cap value
KBadge(count: 150, max: 99, child: widget)  // shows "99+"

// Placement: topRight (default), topLeft, bottomRight, bottomLeft
KBadge(count: 1, placement: BadgePlacement.bottomRight, child: widget)
```

### KChip

```dart
KChip(label: 'Design',  color: ChipColor.primary, variant: ChipVariant.flat)
KChip(label: 'In stock', color: ChipColor.success, variant: ChipVariant.solid)
KChip(label: 'Beta',     color: ChipColor.warning, variant: ChipVariant.bordered,
      startIcon: Icon(Icons.bolt), onClose: () {})

// Variants: solid, flat (default), bordered
// Sizes: sm, md (default), lg
```

### KAvatar

```dart
KAvatar(imageUrl: 'https://example.com/avatar.jpg')
KAvatar(initials: 'JD', color: AvatarColor.primary, size: AvatarSize.lg)
KAvatar(icon: Icon(Icons.person), isBordered: true, color: AvatarColor.secondary)

// Sizes: sm (32), md (40, default), lg (56)
// Radius: none, sm, md, lg, full (default)
// Colors: default_, primary, secondary, success, warning, danger
```

### KAlert

```dart
KAlert(
  variant:     AlertVariant.success,
  title:       'Changes saved',
  description: 'Your profile has been updated.',
)

KAlert(
  variant:     AlertVariant.danger,
  title:       'Error',
  description: 'Something went wrong.',
  onClose:     () { /* dismiss */ },
  action:      KButton(size: ButtonSize.sm, onPressed: () {}, child: Text('Retry')),
)

// Variants: default_, accent, success, warning, danger
```

### KDialog

```dart
showKDialog(
  context: context,
  child: KDialog(
    title:       Text('Confirm'),
    description: Text('Are you sure you want to continue?'),
    content:     SizedBox.shrink(),
    actions: [
      KButton(
        variant:   ButtonVariant.flat,
        color:     ButtonColor.default_,
        onPressed: () => Navigator.pop(context),
        child:     Text('Cancel'),
      ),
      KButton(
        onPressed: () => Navigator.pop(context),
        child:     Text('Confirm'),
      ),
    ],
  ),
)
```

### KToast

```dart
KToast.show(
  context,
  title:   'Success',
  message: 'Your data has been saved.',
  variant: ToastVariant.success,
)

// Variants: info, success, warning, danger
// Optional: title, action, duration
```

### KCheckbox / KSwitch / KRadioGroup

```dart
// Checkbox
KCheckbox(
  value:       _checked,
  onChanged:   (v) => setState(() => _checked = v),
  label:       'Accept terms',
  description: 'By checking this you agree to our terms.',
  color:       CheckboxColor.primary,
)

// Switch
KSwitch(
  value:      _on,
  onChanged:  (v) => setState(() => _on = v),
  label:      'Dark mode',
  color:      SwitchColor.primary,
  thumbIcon:  Icon(Icons.dark_mode),
)

// Radio group
KRadioGroup<String>(
  value:    _selected,
  onChanged: (v) => setState(() => _selected = v),
  label:    'Subscription',
  options: [
    KRadioOption(value: 'free',  label: 'Free',  description: 'Up to 3 projects'),
    KRadioOption(value: 'pro',   label: 'Pro',   description: 'Unlimited projects'),
    KRadioOption(value: 'team',  label: 'Team',  isDisabled: true),
  ],
)
```

---

## Design tokens

Access tokens in any widget:

```dart
final tokens = Theme.of(context).extension<KineticTokens>()!;

// Semantic colors
tokens.primary             // brand blue (#006FEE)
tokens.primaryForeground   // text on primary bg
tokens.secondary           // purple
tokens.secondaryForeground
tokens.success             // green
tokens.warning             // yellow
tokens.danger              // red
tokens.defaultColor        // neutral surface
tokens.defaultForeground   // neutral text

// Surface layers (light: white→zinc; dark: black→zinc)
tokens.background   // page background
tokens.foreground   // primary text
tokens.content1     // card surface
tokens.content2     // subtle surface / input fill
tokens.content3     // stronger surface / input border
tokens.content4     // divider / emphasis border
tokens.divider      // thin separator

// Misc
tokens.overlay      // modal backdrop tint
tokens.focus        // focus ring color

// Border radius
tokens.radiusSm   // 6.0
tokens.radiusMd   // 8.0
tokens.radiusLg   // 12.0
```

Customize tokens:

```dart
ThemeData.light().copyWith(
  extensions: [
    KineticTokens.light.copyWith(
      primary:  Color(0xFF6366F1),  // swap brand color to indigo
      radiusMd: 12,
    ),
  ],
)
```

---

## Project structure after `kinetic init`

```
my_flutter_app/
└── lib/
    ├── widgets/
    │   └── ui/                  ← components are installed here
    │       ├── button.dart
    │       ├── card.dart
    │       └── ...
    └── core/
        └── theme/
            ├── kinetic_tokens.dart   ← design tokens (edit freely)
            ├── app_theme.dart
            ├── colors.dart
            ├── typography.dart
            └── spacing.dart
```

---

## Requirements

- Flutter **3.10+**
- Dart **3.0+**

---

## Repository structure

```
kinetic_ui/
├── cli/                        # CLI source
│   ├── bin/kinetic.dart
│   └── lib/
│       ├── commands/           # init, add, list, diff
│       ├── installer.dart
│       └── registry.dart
├── registry/                   # Static files served from GitHub raw
│   ├── registry.json
│   ├── components/<name>/
│   │   ├── meta.json
│   │   └── <name>.dart
│   └── base/theme/             # Theme base files
├── packages/
│   └── kinetic_ui_tokens/      # The only pub package
└── lib/                        # Demo / showcase app
    └── ui/components/
```
