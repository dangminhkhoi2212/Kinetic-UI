# kinetic_ui

Flutter UI component library theo phong cách [shadcn/ui](https://ui.shadcn.com/) — copy-paste source code thay vì pub dependency. CLI-driven, full ownership.

---

## Triết lý

- **Không phải runtime package** — CLI copy source code thẳng vào `/lib/ui/` của project bạn
- **Full ownership** — bạn sở hữu và tự chỉnh sửa mọi component
- **Chỉ 1 pub dependency** — `kinetic_ui_tokens` (design tokens)
- **Registry-based** — mọi component lưu trên GitHub raw, CLI fetch về

---

## Cài đặt

Thêm vào `pubspec.yaml` của Flutter project:

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

---

## Quick start

### 1. Khởi tạo trong Flutter project

```bash
cd my_flutter_app
dart run kinetic_ui:kinetic init
```

Lệnh này sẽ:
- Tạo thư mục `lib/ui/components/`, `lib/ui/theme/`, `lib/ui/hooks/`
- Copy theme base files (colors, typography, spacing)
- Thêm `kinetic_ui_tokens: ^1.0.0` vào `pubspec.yaml`

### 2. Wrap `MaterialApp` với tokens

```dart
import 'package:kinetic_ui_tokens/kinetic_ui_tokens.dart';

MaterialApp(
  theme: ThemeData.light().copyWith(
    extensions: const [KineticTokens.light],
  ),
  darkTheme: ThemeData.dark().copyWith(
    extensions: const [KineticTokens.dark],
  ),
)
```

### 3. Thêm components

```bash
dart run kinetic_ui:kinetic add button
dart run kinetic_ui:kinetic add card dialog input    # nhiều component cùng lúc
```

### 4. Dùng component

```dart
import 'package:my_app/ui/components/button.dart';

KButton(
  onPressed: () {},
  child: const Text('Click me'),
)
```

---

## CLI commands

| Command | Mô tả |
|---|---|
| `dart run kinetic_ui:kinetic init` | Khởi tạo `lib/ui/` + copy theme base |
| `dart run kinetic_ui:kinetic add <name...>` | Thêm một hoặc nhiều component |
| `dart run kinetic_ui:kinetic add <name> --force` | Overwrite file đã tồn tại |
| `dart run kinetic_ui:kinetic list` | Xem tất cả components trong registry |
| `dart run kinetic_ui:kinetic list --tag=form` | Lọc theo tag |
| `dart run kinetic_ui:kinetic diff <name>` | So sánh file local vs registry |

---

## Components

### Phase 1 — Core

| Component | Class | Mô tả |
|---|---|---|
| `button` | `KButton` | Button với 4 variants, 3 sizes, loading state |
| `card` | `KCard`, `KCardHeader` | Container surface với header/footer slot |
| `input` | `KInput` | Text input với label, helper, error state |
| `badge` | `KBadge` | Status badge với 4 color variants |
| `skeleton` | `KSkeleton` | Loading placeholder với shimmer animation |
| `separator` | `KSeparator` | Horizontal/vertical divider, hỗ trợ label |
| `label` | `KLabel` | Form label với required indicator |
| `dialog` | `KDialog`, `showKDialog()` | Modal dialog accessible |
| `toast` | `KToast`, `KToast.show()` | Notification toast với auto-dismiss |

### Roadmap

- **Phase 2 — Overlay:** `sheet`, `tooltip`, `popover`
- **Phase 3 — Form:** `checkbox`, `radio`, `switch`, `select`, `slider`
- **Phase 4 — Navigation:** `tabs`, `accordion`, `command`

---

## Component examples

### KButton

```dart
// Variants
KButton(variant: ButtonVariant.solid,       onPressed: () {}, child: Text('Solid'))
KButton(variant: ButtonVariant.outline,     onPressed: () {}, child: Text('Outline'))
KButton(variant: ButtonVariant.ghost,       onPressed: () {}, child: Text('Ghost'))
KButton(variant: ButtonVariant.destructive, onPressed: () {}, child: Text('Delete'))

// Sizes
KButton(size: ButtonSize.sm, onPressed: () {}, child: Text('Small'))
KButton(size: ButtonSize.lg, onPressed: () {}, child: Text('Large'))

// Với icon
KButton(
  leading: Icon(Icons.add, size: 14),
  onPressed: () {},
  child: Text('New item'),
)

// Loading state
KButton(isLoading: true, child: Text('Saving...'))

// Full width
KButton(fullWidth: true, onPressed: () {}, child: Text('Submit'))
```

### KCard

```dart
KCard(
  header: KCardHeader(
    title:    Text('Tiêu đề'),
    subtitle: Text('Mô tả phụ'),
    action:   KButton(size: ButtonSize.sm, onPressed: () {}, child: Text('Edit')),
  ),
  child: Text('Nội dung card'),
  footer: Text('Footer info'),
)
```

### KInput

```dart
KInput(
  label:   'Email',
  hint:    'name@example.com',
  helper:  'Chúng tôi sẽ không chia sẻ email của bạn',
  error:   'Email không hợp lệ',   // hiển thị trạng thái lỗi
  prefix:  Icon(Icons.mail_outline),
  onChanged: (value) { /* ... */ },
)
```

### KBadge

```dart
KBadge(label: 'New')
KBadge(label: 'Beta',    variant: BadgeVariant.secondary)
KBadge(label: 'Outline', variant: BadgeVariant.outline)
KBadge(label: 'Error',   variant: BadgeVariant.destructive)
```

### KDialog

```dart
showKDialog(
  context: context,
  child: KDialog(
    title:       Text('Xác nhận'),
    description: Text('Bạn có chắc chắn muốn tiếp tục?'),
    content:     SizedBox.shrink(),
    actions: [
      KButton(variant: ButtonVariant.outline, onPressed: () => Navigator.pop(context), child: Text('Hủy')),
      KButton(onPressed: () => Navigator.pop(context), child: Text('Xác nhận')),
    ],
  ),
)
```

### KToast

```dart
KToast.show(
  context,
  title:   'Thành công',
  message: 'Dữ liệu đã được lưu.',
  variant: ToastVariant.success,
)

// Variants: info, success, warning, destructive
```

---

## Design tokens

Đọc token trong bất kỳ widget nào:

```dart
final tokens = Theme.of(context).extension<KineticTokens>()!;

// Colors
tokens.primary       // màu chính
tokens.border        // màu border
tokens.muted         // background nhạt
tokens.destructive   // màu nguy hiểm

// Border radius
tokens.radiusSm  // 6
tokens.radiusMd  // 8
tokens.radiusLg  // 12
```

Custom tokens:

```dart
KineticTokens.light.copyWith(
  primary:  Color(0xFF6366F1),   // indigo
  radiusMd: 12,
)
```

---

## Cấu trúc sau khi `kinetic init`

```
my_flutter_app/
└── lib/
    ├── widgets/
    │   └── ui/             ← widgets được copy vào đây
    │       ├── button.dart
    │       └── ...
    └── core/
        ├── theme/
        │   ├── kinetic_tokens.dart   ← colors, spacing, KineticTokens — tự sửa
        │   ├── app_theme.dart
        │   ├── colors.dart
        │   ├── typography.dart
        │   └── spacing.dart
        └── hooks/
```

---

## Yêu cầu

- Flutter **3.10+**
- Dart **3.0+**

---

## Repository structure

```
kinetic_ui/
├── cli/                     # CLI source (ship as pub global)
├── registry/                # Static component files (GitHub raw)
│   ├── registry.json
│   ├── components/<name>/
│   │   ├── meta.json
│   │   └── <name>.dart
│   └── base/theme/
└── packages/
    └── kinetic_ui_tokens/   # Pub package duy nhất
```
