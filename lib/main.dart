import 'package:flutter/material.dart';
import 'package:kinetic_ui_tokens/kinetic_ui_tokens.dart';
import 'ui/components/button.dart';
import 'ui/components/card.dart';
import 'ui/components/badge.dart';
import 'ui/components/input.dart';
import 'ui/components/skeleton.dart';
import 'ui/components/separator.dart';
import 'ui/components/label.dart';
import 'ui/components/dialog.dart';
import 'ui/components/toast.dart';

void main() {
  runApp(const KineticShowcase());
}

class KineticShowcase extends StatefulWidget {
  const KineticShowcase({super.key});

  @override
  State<KineticShowcase> createState() => _KineticShowcaseState();
}

class _KineticShowcaseState extends State<KineticShowcase> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:       'kinetic_ui showcase',
      debugShowCheckedModeBanner: false,
      themeMode:   _darkMode ? ThemeMode.dark : ThemeMode.light,
      theme:       ThemeData.light().copyWith(
        extensions: const [KineticTokens.light],
      ),
      darkTheme:   ThemeData.dark().copyWith(
        extensions: const [KineticTokens.dark],
      ),
      home: _ShowcasePage(
        darkMode: _darkMode,
        onToggleDark: () => setState(() => _darkMode = !_darkMode),
      ),
    );
  }
}

class _ShowcasePage extends StatelessWidget {
  const _ShowcasePage({required this.darkMode, required this.onToggleDark});

  final bool          darkMode;
  final VoidCallback  onToggleDark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('kinetic_ui', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(darkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleDark,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          _Section('Button'),
          _ButtonShowcase(),
          SizedBox(height: 32),

          _Section('Badge'),
          _BadgeShowcase(),
          SizedBox(height: 32),

          _Section('Input'),
          _InputShowcase(),
          SizedBox(height: 32),

          _Section('Card'),
          _CardShowcase(),
          SizedBox(height: 32),

          _Section('Skeleton'),
          _SkeletonShowcase(),
          SizedBox(height: 32),

          _Section('Separator'),
          _SeparatorShowcase(),
          SizedBox(height: 32),

          _Section('Dialog & Toast'),
          _DialogToastShowcase(),
          SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Divider(color: tokens.border),
        ],
      ),
    );
  }
}

class _ButtonShowcase extends StatelessWidget {
  const _ButtonShowcase();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        KButton(onPressed: () {}, child: const Text('Solid')),
        KButton(
          variant: ButtonVariant.outline,
          onPressed: () {},
          child: const Text('Outline'),
        ),
        KButton(
          variant: ButtonVariant.ghost,
          onPressed: () {},
          child: const Text('Ghost'),
        ),
        KButton(
          variant: ButtonVariant.destructive,
          onPressed: () {},
          child: const Text('Destructive'),
        ),
        KButton(isLoading: true, child: const Text('Loading')),
        KButton(
          size: ButtonSize.sm,
          onPressed: () {},
          leading: const Icon(Icons.add, size: 14),
          child: const Text('Small'),
        ),
        KButton(
          size: ButtonSize.lg,
          onPressed: () {},
          child: const Text('Large'),
        ),
      ],
    );
  }
}

class _BadgeShowcase extends StatelessWidget {
  const _BadgeShowcase();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        KBadge(label: 'Default'),
        KBadge(label: 'Secondary', variant: BadgeVariant.secondary),
        KBadge(label: 'Outline',   variant: BadgeVariant.outline),
        KBadge(label: 'Destructive', variant: BadgeVariant.destructive),
        KBadge(label: 'With icon', icon: Icon(Icons.circle, size: 6)),
      ],
    );
  }
}

class _InputShowcase extends StatelessWidget {
  const _InputShowcase();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        KInput(label: 'Email', hint: 'name@example.com'),
        SizedBox(height: 12),
        KInput(
          label: 'Password',
          hint: '••••••••',
          obscureText: true,
          helper: 'Ít nhất 8 ký tự',
        ),
        SizedBox(height: 12),
        KInput(
          label: 'Username',
          hint: 'your_username',
          error: 'Username đã được sử dụng',
        ),
      ],
    );
  }
}

class _CardShowcase extends StatelessWidget {
  const _CardShowcase();

  @override
  Widget build(BuildContext context) {
    return KCard(
      header: const KCardHeader(
        title:    Text('Thông tin tài khoản'),
        subtitle: Text('Quản lý thông tin cá nhân'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const KLabel(text: 'Tên hiển thị', required: true),
          const SizedBox(height: 6),
          const KInput(hint: 'Nhập tên của bạn'),
          const SizedBox(height: 16),
          KButton(
            fullWidth: true,
            onPressed: () {},
            child: const Text('Lưu thay đổi'),
          ),
        ],
      ),
      footer: Row(
        children: [
          const Icon(Icons.info_outline, size: 14),
          const SizedBox(width: 6),
          Text(
            'Thay đổi sẽ được áp dụng ngay lập tức',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).extension<KineticTokens>()!.onMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonShowcase extends StatelessWidget {
  const _SkeletonShowcase();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          KSkeleton(height: 48, isCircle: true),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KSkeleton(height: 16, width: 160),
                SizedBox(height: 8),
                KSkeleton(height: 12, width: 120),
              ],
            ),
          ),
        ]),
        SizedBox(height: 12),
        KSkeleton(height: 12),
        SizedBox(height: 6),
        KSkeleton(height: 12),
        SizedBox(height: 6),
        KSkeleton(height: 12, width: 200),
      ],
    );
  }
}

class _SeparatorShowcase extends StatelessWidget {
  const _SeparatorShowcase();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        KSeparator(),
        SizedBox(height: 8),
        KSeparator(label: 'HOẶC'),
        SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Trái'),
              KSeparator(orientation: SeparatorOrientation.vertical),
              Text('Phải'),
            ],
          ),
        ),
      ],
    );
  }
}

class _DialogToastShowcase extends StatelessWidget {
  const _DialogToastShowcase();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        KButton(
          variant: ButtonVariant.outline,
          onPressed: () => showKDialog(
            context: context,
            child: KDialog(
              title:       const Text('Xác nhận xóa'),
              description: const Text('Hành động này không thể hoàn tác. Bạn có chắc chắn không?'),
              content:     const SizedBox.shrink(),
              actions: [
                KButton(
                  variant:   ButtonVariant.outline,
                  onPressed: () => Navigator.pop(context),
                  child:     const Text('Hủy'),
                ),
                KButton(
                  variant:   ButtonVariant.destructive,
                  onPressed: () => Navigator.pop(context),
                  child:     const Text('Xóa'),
                ),
              ],
            ),
          ),
          child: const Text('Open Dialog'),
        ),
        KButton(
          variant: ButtonVariant.outline,
          onPressed: () => KToast.show(
            context,
            title:   'Thành công',
            message: 'Thay đổi đã được lưu.',
            variant: ToastVariant.success,
          ),
          child: const Text('Show Toast'),
        ),
        KButton(
          variant: ButtonVariant.outline,
          onPressed: () => KToast.show(
            context,
            message: 'Có lỗi xảy ra, vui lòng thử lại.',
            variant: ToastVariant.destructive,
          ),
          child: const Text('Error Toast'),
        ),
      ],
    );
  }
}
