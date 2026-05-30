import 'package:flutter/material.dart';
import 'package:kinetic_ui_tokens/kinetic_ui_tokens.dart';

import 'ui/components/alert.dart';
import 'ui/components/avatar.dart';
import 'ui/components/badge.dart';
import 'ui/components/button.dart';
import 'ui/components/card.dart';
import 'ui/components/checkbox.dart';
import 'ui/components/chip.dart';
import 'ui/components/dialog.dart';
import 'ui/components/input.dart';
import 'ui/components/kswitch.dart';
import 'ui/components/label.dart';
import 'ui/components/progress.dart';
import 'ui/components/radio.dart';
import 'ui/components/separator.dart';
import 'ui/components/skeleton.dart';
import 'ui/components/slider.dart';
import 'ui/components/spinner.dart';
import 'ui/components/tabs.dart';
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
      title: 'kinetic_ui',
      debugShowCheckedModeBanner: false,
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        extensions: const [KineticTokens.light],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: const [KineticTokens.dark],
      ),
      home: _LandingPage(
        darkMode: _darkMode,
        onToggleDark: () => setState(() => _darkMode = !_darkMode),
      ),
    );
  }
}

// ─── Landing Page ────────────────────────────────────────────────────────────

class _LandingPage extends StatefulWidget {
  const _LandingPage({required this.darkMode, required this.onToggleDark});
  final bool darkMode;
  final VoidCallback onToggleDark;

  @override
  State<_LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<_LandingPage> {
  final _scroll = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'Button': GlobalKey(),
    'Input': GlobalKey(),
    'Label': GlobalKey(),
    'Card': GlobalKey(),
    'Badge': GlobalKey(),
    'Chip': GlobalKey(),
    'Avatar': GlobalKey(),
    'Alert': GlobalKey(),
    'Checkbox': GlobalKey(),
    'Radio': GlobalKey(),
    'Switch': GlobalKey(),
    'Slider': GlobalKey(),
    'Tabs': GlobalKey(),
    'Progress': GlobalKey(),
    'Spinner': GlobalKey(),
    'Separator': GlobalKey(),
    'Skeleton': GlobalKey(),
    'Dialog': GlobalKey(),
    'Toast': GlobalKey(),
  };
  String _active = 'Button';

  void _scrollTo(String section) {
    final ctx = _sectionKeys[section]?.currentContext;
    if (ctx == null) return;
    setState(() => _active = section);
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.05,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;

    return Scaffold(
      backgroundColor: tokens.background,
      body: Column(
        children: [
          _TopBar(darkMode: widget.darkMode, onToggleDark: widget.onToggleDark),
          Divider(height: 1, color: tokens.divider),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Sidebar(
                  sections: _sectionKeys.keys.toList(),
                  active: _active,
                  onTap: _scrollTo,
                ),
                VerticalDivider(width: 1, color: tokens.divider),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scroll,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroSection(),
                          const SizedBox(height: 56),
                          _ComponentSection(
                            key: _sectionKeys['Button'],
                            title: 'Button',
                            child: const _ButtonDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Input'],
                            title: 'Input',
                            child: const _InputDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Label'],
                            title: 'Label',
                            child: const _LabelDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Card'],
                            title: 'Card',
                            child: const _CardDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Badge'],
                            title: 'Badge',
                            child: const _BadgeDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Chip'],
                            title: 'Chip',
                            child: const _ChipDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Avatar'],
                            title: 'Avatar',
                            child: const _AvatarDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Alert'],
                            title: 'Alert',
                            child: const _AlertDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Checkbox'],
                            title: 'Checkbox',
                            child: const _CheckboxDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Radio'],
                            title: 'Radio',
                            child: const _RadioDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Switch'],
                            title: 'Switch',
                            child: const _SwitchDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Slider'],
                            title: 'Slider',
                            child: const _SliderDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Tabs'],
                            title: 'Tabs',
                            child: const _TabsDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Progress'],
                            title: 'Progress',
                            child: const _ProgressDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Spinner'],
                            title: 'Spinner',
                            child: const _SpinnerDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Separator'],
                            title: 'Separator',
                            child: const _SeparatorDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Skeleton'],
                            title: 'Skeleton',
                            child: const _SkeletonDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Dialog'],
                            title: 'Dialog',
                            child: const _DialogDemo(),
                          ),
                          _ComponentSection(
                            key: _sectionKeys['Toast'],
                            title: 'Toast',
                            child: _ToastDemo(),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Top Bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.darkMode, required this.onToggleDark});
  final bool darkMode;
  final VoidCallback onToggleDark;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Container(
      height: 56,
      color: tokens.background,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: tokens.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'kinetic_ui',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: tokens.foreground,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: tokens.defaultColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'v2.0.0',
              style: TextStyle(
                fontSize: 11,
                color: tokens.defaultForeground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onToggleDark,
            icon: Icon(
              darkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              size: 20,
              color: tokens.defaultForeground,
            ),
            tooltip: darkMode ? 'Light mode' : 'Dark mode',
          ),
        ],
      ),
    );
  }
}

// ─── Sidebar ─────────────────────────────────────────────────────────────────

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.sections,
    required this.active,
    required this.onTap,
  });
  final List<String> sections;
  final String active;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return SizedBox(
      width: 200,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'Components',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: tokens.defaultForeground,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...sections.map((s) {
            final isActive = s == active;
            return GestureDetector(
              onTap: () => onTap(s),
              child: Container(
                margin: const EdgeInsets.only(bottom: 2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: isActive ? tokens.defaultColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  s,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive
                        ? tokens.foreground
                        : tokens.defaultForeground,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Hero Section ────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KChip(label: 'Open Source', color: ChipColor.secondary),
        const SizedBox(height: 16),
        Text(
          'Flutter UI\nComponents',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: tokens.foreground,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Copy-paste source code directly into your project.\nFull ownership, no runtime dependency.',
          style: TextStyle(
            fontSize: 16,
            color: tokens.defaultForeground,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            KButton(
              onPressed: () {},
              startContent: const Icon(Icons.terminal, size: 16),
              child: const Text('dart run kinetic_ui:kinetic init'),
            ),
            const SizedBox(width: 12),
            KButton(
              variant: ButtonVariant.flat,
              color: ButtonColor.default_,
              onPressed: () {},
              startContent: const Icon(Icons.open_in_new, size: 16),
              child: const Text('GitHub'),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _StatChip(icon: Icons.widgets_outlined, label: '19 components'),
            _StatChip(icon: Icons.palette_outlined, label: 'HeroUI tokens'),
            _StatChip(icon: Icons.dark_mode_outlined, label: 'Dark mode'),
            _StatChip(icon: Icons.code_outlined, label: 'Copy-paste'),
          ],
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: tokens.defaultColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: tokens.defaultForeground),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: tokens.foreground,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section wrapper ─────────────────────────────────────────────────────────

class _ComponentSection extends StatelessWidget {
  const _ComponentSection({
    super.key,
    required this.title,
    required this.child,
  });
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: tokens.foreground,
            ),
          ),
          const SizedBox(height: 4),
          Divider(color: tokens.divider),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

// ─── Component Demos ─────────────────────────────────────────────────────────

class _ButtonDemo extends StatefulWidget {
  const _ButtonDemo();
  @override
  State<_ButtonDemo> createState() => _ButtonDemoState();
}

class _ButtonDemoState extends State<_ButtonDemo> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Variants',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              KButton(onPressed: () {}, child: Text('Solid')),
              KButton(
                variant: ButtonVariant.flat,
                onPressed: () {},
                child: Text('Flat'),
              ),
              KButton(
                variant: ButtonVariant.bordered,
                onPressed: () {},
                child: Text('Bordered'),
              ),
              KButton(
                variant: ButtonVariant.outline,
                onPressed: () {},
                child: Text('Outline'),
              ),
              KButton(
                variant: ButtonVariant.shadow,
                onPressed: () {},
                child: Text('Shadow'),
              ),
              KButton(
                variant: ButtonVariant.faded,
                onPressed: () {},
                child: Text('Faded'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Colors',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              KButton(
                color: ButtonColor.default_,
                onPressed: () {},
                child: Text('Default'),
              ),
              KButton(
                color: ButtonColor.primary,
                onPressed: () {},
                child: Text('Primary'),
              ),
              KButton(
                color: ButtonColor.secondary,
                onPressed: () {},
                child: Text('Secondary'),
              ),
              KButton(
                color: ButtonColor.success,
                onPressed: () {},
                child: Text('Success'),
              ),
              KButton(
                color: ButtonColor.warning,
                onPressed: () {},
                child: Text('Warning'),
              ),
              KButton(
                color: ButtonColor.danger,
                onPressed: () {},
                child: Text('Danger'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Flat colors',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              KButton(
                variant: ButtonVariant.flat,
                color: ButtonColor.default_,
                onPressed: () {},
                child: Text('Default'),
              ),
              KButton(
                variant: ButtonVariant.flat,
                color: ButtonColor.primary,
                onPressed: () {},
                child: Text('Primary'),
              ),
              KButton(
                variant: ButtonVariant.flat,
                color: ButtonColor.secondary,
                onPressed: () {},
                child: Text('Secondary'),
              ),
              KButton(
                variant: ButtonVariant.flat,
                color: ButtonColor.success,
                onPressed: () {},
                child: Text('Success'),
              ),
              KButton(
                variant: ButtonVariant.flat,
                color: ButtonColor.warning,
                onPressed: () {},
                child: Text('Warning'),
              ),
              KButton(
                variant: ButtonVariant.flat,
                color: ButtonColor.danger,
                onPressed: () {},
                child: Text('Danger'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Sizes',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              KButton(
                size: ButtonSize.sm,
                onPressed: () {},
                child: Text('Small'),
              ),
              KButton(
                size: ButtonSize.md,
                onPressed: () {},
                child: Text('Medium'),
              ),
              KButton(
                size: ButtonSize.lg,
                onPressed: () {},
                child: Text('Large'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Radius',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              const KButton(radius: ButtonRadius.none, child: Text('None')),
              KButton(
                radius: ButtonRadius.sm,
                onPressed: () {},
                child: const Text('SM'),
              ),
              KButton(
                radius: ButtonRadius.md,
                onPressed: () {},
                child: const Text('MD'),
              ),
              KButton(
                radius: ButtonRadius.lg,
                onPressed: () {},
                child: const Text('LG'),
              ),
              KButton(
                radius: ButtonRadius.full,
                onPressed: () {},
                child: const Text('Full'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'States',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              KButton(
                isLoading: _loading,
                onPressed: () async {
                  setState(() => _loading = true);
                  await Future.delayed(const Duration(seconds: 2));
                  if (mounted) setState(() => _loading = false);
                },
                child: const Text('Click to load'),
              ),
              KButton(
                isDisabled: true,
                onPressed: () {},
                child: Text('Disabled'),
              ),
              KButton(
                startContent: const Icon(Icons.add, size: 16),
                onPressed: () {},
                child: const Text('With icon'),
              ),
              KButton(
                variant: ButtonVariant.bordered,
                color: ButtonColor.danger,
                startContent: const Icon(Icons.delete_outline, size: 16),
                onPressed: () {},
                child: const Text('Delete'),
              ),
              KButton(
                isIconOnly: true,
                onPressed: () {},
                child: const Icon(Icons.favorite_border, size: 18),
              ),
              KButton(
                isIconOnly: true,
                variant: ButtonVariant.flat,
                color: ButtonColor.danger,
                onPressed: () {},
                child: const Icon(Icons.delete_outline, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InputDemo extends StatelessWidget {
  const _InputDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _DemoRow(
          label: 'Variants',
          child: Column(
            children: [
              KInput(
                label: 'Flat',
                hint: 'Enter text...',
                variant: InputVariant.flat,
              ),
              SizedBox(height: 14),
              KInput(
                label: 'Bordered',
                hint: 'Enter text...',
                variant: InputVariant.bordered,
              ),
              SizedBox(height: 14),
              KInput(
                label: 'Faded',
                hint: 'Enter text...',
                variant: InputVariant.faded,
              ),
              SizedBox(height: 14),
              KInput(
                label: 'Underlined',
                hint: 'Enter text...',
                variant: InputVariant.underlined,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        _DemoRow(
          label: 'States',
          child: Column(
            children: [
              KInput(
                label: 'Password',
                hint: '••••••••',
                obscureText: true,
                helper: 'At least 8 characters',
                variant: InputVariant.bordered,
                endContent: Icon(Icons.visibility_off_outlined, size: 18),
              ),
              SizedBox(height: 14),
              KInput(
                label: 'Username',
                hint: 'your_username',
                error: 'Username is already taken',
                variant: InputVariant.bordered,
                startContent: Icon(Icons.alternate_email, size: 18),
              ),
              SizedBox(height: 14),
              KInput(
                label: 'Disabled',
                hint: 'Cannot edit',
                isDisabled: true,
                variant: InputVariant.bordered,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LabelDemo extends StatelessWidget {
  const _LabelDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KLabel(text: 'Display name'),
        SizedBox(height: 12),
        KLabel(text: 'Email (required)', required: true),
        SizedBox(height: 12),
        KLabel(text: 'Disabled field', disabled: true),
      ],
    );
  }
}

class _CardDemo extends StatelessWidget {
  const _CardDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DemoRow(
          label: 'Form card',
          child: KCard(
            header: const KCardHeader(
              title: Text('Account settings'),
              subtitle: Text('Manage your personal information'),
            ),
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                KButton(
                  variant: ButtonVariant.flat,
                  color: ButtonColor.default_,
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                KButton(onPressed: () {}, child: const Text('Save changes')),
              ],
            ),
            child: const Column(
              children: [
                KInput(
                  hint: 'Enter display name',
                  variant: InputVariant.bordered,
                ),
                SizedBox(height: 12),
                KInput(
                  hint: 'name@example.com',
                  variant: InputVariant.bordered,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Variants',
          child: Row(
            children: [
              Expanded(
                child: KCard(
                  variant: CardVariant.default_,
                  child: const Center(child: Text('Default')),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: KCard(
                  variant: CardVariant.secondary,
                  child: const Center(child: Text('Secondary')),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: KCard(
                  variant: CardVariant.tertiary,
                  child: const Center(child: Text('Tertiary')),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: KCard(
                  variant: CardVariant.transparent,
                  child: const Center(child: Text('Transparent')),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Stat cards',
          child: Row(
            children: [
              Expanded(
                child: KCard(
                  onTap: () {},
                  child: Column(
                    children: [
                      Icon(
                        Icons.trending_up,
                        size: 32,
                        color: Theme.of(
                          context,
                        ).extension<KineticTokens>()!.success,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Revenue',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        '\$12,400',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: KCard(
                  onTap: () {},
                  child: Column(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 32,
                        color: Theme.of(
                          context,
                        ).extension<KineticTokens>()!.primary,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Users',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        '4,821',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BadgeDemo extends StatelessWidget {
  const _BadgeDemo();

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Colors',
          child: Wrap(
            spacing: 24,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              KBadge(
                count: 5,
                color: BadgeColor.primary,
                child: Icon(
                  Icons.notifications_outlined,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                count: 5,
                color: BadgeColor.secondary,
                child: Icon(
                  Icons.mail_outline,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                count: 5,
                color: BadgeColor.success,
                child: Icon(
                  Icons.check_circle_outline,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                count: 5,
                color: BadgeColor.warning,
                child: Icon(
                  Icons.warning_amber_outlined,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                count: 5,
                color: BadgeColor.danger,
                child: Icon(
                  Icons.error_outline,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Variants',
          child: Wrap(
            spacing: 24,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              KBadge(
                count: 5,
                variant: BadgeVariant.solid,
                color: BadgeColor.primary,
                child: Icon(
                  Icons.notifications_outlined,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                count: 5,
                variant: BadgeVariant.flat,
                color: BadgeColor.primary,
                child: Icon(
                  Icons.mail_outline,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                count: 5,
                variant: BadgeVariant.faded,
                color: BadgeColor.primary,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                count: 5,
                variant: BadgeVariant.shadow,
                color: BadgeColor.primary,
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Dot',
          child: Wrap(
            spacing: 24,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              KBadge(
                isDot: true,
                color: BadgeColor.danger,
                child: Icon(
                  Icons.person_outline,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                isDot: true,
                color: BadgeColor.success,
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
              KBadge(
                isDot: true,
                color: BadgeColor.warning,
                child: Icon(
                  Icons.notifications_outlined,
                  size: 28,
                  color: tokens.foreground,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Placement',
          child: Wrap(
            spacing: 24,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              KBadge(
                count: 5,
                placement: BadgePlacement.topRight,
                child: _badgeBox(tokens),
              ),
              KBadge(
                count: 5,
                placement: BadgePlacement.topLeft,
                child: _badgeBox(tokens),
              ),
              KBadge(
                count: 5,
                placement: BadgePlacement.bottomRight,
                child: _badgeBox(tokens),
              ),
              KBadge(
                count: 5,
                placement: BadgePlacement.bottomLeft,
                child: _badgeBox(tokens),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _badgeBox(KineticTokens t) => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: t.defaultColor,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class _ChipDemo extends StatelessWidget {
  const _ChipDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Variants',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              KChip(
                label: 'Solid',
                color: ChipColor.primary,
                variant: ChipVariant.solid,
              ),
              KChip(
                label: 'Flat',
                color: ChipColor.primary,
                variant: ChipVariant.flat,
              ),
              KChip(
                label: 'Bordered',
                color: ChipColor.primary,
                variant: ChipVariant.bordered,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Colors',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              KChip(label: 'Default', color: ChipColor.default_),
              KChip(label: 'Primary', color: ChipColor.primary),
              KChip(label: 'Secondary', color: ChipColor.secondary),
              KChip(label: 'Success', color: ChipColor.success),
              KChip(label: 'Warning', color: ChipColor.warning),
              KChip(label: 'Danger', color: ChipColor.danger),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'With icons',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              KChip(
                label: 'New',
                color: ChipColor.primary,
                startIcon: Icon(Icons.fiber_new),
              ),
              KChip(
                label: 'Beta',
                color: ChipColor.secondary,
                startIcon: Icon(Icons.science_outlined),
              ),
              KChip(
                label: 'Hot',
                color: ChipColor.danger,
                startIcon: Icon(Icons.local_fire_department),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Sizes',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              KChip(
                label: 'Small',
                size: ChipSize.sm,
                color: ChipColor.primary,
              ),
              KChip(
                label: 'Medium',
                size: ChipSize.md,
                color: ChipColor.primary,
              ),
              KChip(
                label: 'Large',
                size: ChipSize.lg,
                color: ChipColor.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarDemo extends StatelessWidget {
  const _AvatarDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Content',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              KAvatar(imageUrl: 'https://i.pravatar.cc/150?img=1'),
              KAvatar(initials: 'KD'),
              KAvatar(icon: Icon(Icons.support_agent)),
              KAvatar(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Sizes',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              KAvatar(
                initials: 'SM',
                size: AvatarSize.sm,
                color: AvatarColor.primary,
              ),
              KAvatar(
                initials: 'MD',
                size: AvatarSize.md,
                color: AvatarColor.primary,
              ),
              KAvatar(
                initials: 'LG',
                size: AvatarSize.lg,
                color: AvatarColor.primary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Colors',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              KAvatar(initials: 'DE', color: AvatarColor.default_),
              KAvatar(initials: 'PR', color: AvatarColor.primary),
              KAvatar(initials: 'SE', color: AvatarColor.secondary),
              KAvatar(initials: 'SC', color: AvatarColor.success),
              KAvatar(initials: 'WA', color: AvatarColor.warning),
              KAvatar(initials: 'DA', color: AvatarColor.danger),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Radius',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              KAvatar(
                initials: 'NO',
                color: AvatarColor.primary,
                radius: AvatarRadius.none,
              ),
              KAvatar(
                initials: 'SM',
                color: AvatarColor.primary,
                radius: AvatarRadius.sm,
              ),
              KAvatar(
                initials: 'MD',
                color: AvatarColor.primary,
                radius: AvatarRadius.md,
              ),
              KAvatar(
                initials: 'LG',
                color: AvatarColor.primary,
                radius: AvatarRadius.lg,
              ),
              KAvatar(
                initials: 'FL',
                color: AvatarColor.primary,
                radius: AvatarRadius.full,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Bordered',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              KAvatar(
                initials: 'KD',
                isBordered: true,
                color: AvatarColor.primary,
              ),
              KAvatar(
                initials: 'SU',
                isBordered: true,
                color: AvatarColor.success,
              ),
              KAvatar(
                imageUrl: 'https://i.pravatar.cc/150?img=2',
                isBordered: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AlertDemo extends StatelessWidget {
  const _AlertDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DemoRow(
          label: 'Variants',
          child: const Column(
            children: [
              KAlert(description: 'A general purpose informational alert.'),
              SizedBox(height: 10),
              KAlert(
                variant: AlertVariant.accent,
                title: 'Update available',
                description:
                    'A new version of the package is ready to install.',
              ),
              SizedBox(height: 10),
              KAlert(
                variant: AlertVariant.success,
                title: 'Changes saved',
                description: 'Your profile has been updated successfully.',
              ),
              SizedBox(height: 10),
              KAlert(
                variant: AlertVariant.warning,
                title: 'Session expiring',
                description: 'Your session will expire in 5 minutes.',
              ),
              SizedBox(height: 10),
              KAlert(
                variant: AlertVariant.danger,
                title: 'Payment failed',
                description: 'We could not process your payment.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'With action',
          child: KAlert(
            variant: AlertVariant.accent,
            title: 'New feature available',
            description:
                'Check out the new component library we just launched.',
            action: KButton(
              size: ButtonSize.sm,
              onPressed: () {},
              child: const Text('Learn more'),
            ),
          ),
        ),
      ],
    );
  }
}

class _CheckboxDemo extends StatefulWidget {
  const _CheckboxDemo();
  @override
  State<_CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  bool _v1 = true;
  bool _v2 = false;
  bool _v3 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Basic',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KCheckbox(
                value: _v1,
                onChanged: (v) => setState(() => _v1 = v),
                label: 'Accept terms and conditions',
              ),
              const SizedBox(height: 10),
              KCheckbox(
                value: _v2,
                onChanged: (v) => setState(() => _v2 = v),
                label: 'Subscribe to newsletter',
                description: 'Receive weekly updates',
              ),
              const SizedBox(height: 10),
              const KCheckbox(
                value: false,
                onChanged: null,
                label: 'Disabled option',
                isDisabled: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Colors',
          child: Wrap(
            spacing: 16,
            runSpacing: 10,
            children: [
              KCheckbox(
                value: true,
                onChanged: (_) {},
                label: 'Default',
                color: CheckboxColor.default_,
              ),
              KCheckbox(
                value: true,
                onChanged: (_) {},
                label: 'Primary',
                color: CheckboxColor.primary,
              ),
              KCheckbox(
                value: true,
                onChanged: (_) {},
                label: 'Secondary',
                color: CheckboxColor.secondary,
              ),
              KCheckbox(
                value: true,
                onChanged: (_) {},
                label: 'Success',
                color: CheckboxColor.success,
              ),
              KCheckbox(
                value: true,
                onChanged: (_) {},
                label: 'Warning',
                color: CheckboxColor.warning,
              ),
              KCheckbox(
                value: true,
                onChanged: (_) {},
                label: 'Danger',
                color: CheckboxColor.danger,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Sizes',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KCheckbox(
                value: _v3,
                onChanged: (v) => setState(() => _v3 = v),
                label: 'Small',
                size: CheckboxSize.sm,
              ),
              const SizedBox(height: 10),
              KCheckbox(
                value: _v3,
                onChanged: (v) => setState(() => _v3 = v),
                label: 'Medium',
                size: CheckboxSize.md,
              ),
              const SizedBox(height: 10),
              KCheckbox(
                value: _v3,
                onChanged: (v) => setState(() => _v3 = v),
                label: 'Large',
                size: CheckboxSize.lg,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Invalid',
          child: KCheckbox(
            value: false,
            onChanged: (_) {},
            label: 'Agree to terms',
            isInvalid: true,
          ),
        ),
      ],
    );
  }
}

class _RadioDemo extends StatefulWidget {
  const _RadioDemo();
  @override
  State<_RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<_RadioDemo> {
  String _plan = 'pro';
  String _invalid = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Basic',
          child: KRadioGroup<String>(
            value: _plan,
            onChanged: (v) => setState(() => _plan = v),
            options: const [
              KRadioOption(
                value: 'free',
                label: 'Free',
                description: 'Up to 3 projects',
              ),
              KRadioOption(
                value: 'pro',
                label: 'Pro',
                description: 'Unlimited projects',
              ),
              KRadioOption(
                value: 'enterprise',
                label: 'Enterprise',
                description: 'Custom pricing',
                isDisabled: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Colors',
          child: Wrap(
            spacing: 24,
            runSpacing: 12,
            children: [
              KRadioGroup<String>(
                value: 'a',
                onChanged: (_) {},
                color: RadioColor.primary,
                options: const [KRadioOption(value: 'a', label: 'Primary')],
              ),
              KRadioGroup<String>(
                value: 'a',
                onChanged: (_) {},
                color: RadioColor.secondary,
                options: const [KRadioOption(value: 'a', label: 'Secondary')],
              ),
              KRadioGroup<String>(
                value: 'a',
                onChanged: (_) {},
                color: RadioColor.success,
                options: const [KRadioOption(value: 'a', label: 'Success')],
              ),
              KRadioGroup<String>(
                value: 'a',
                onChanged: (_) {},
                color: RadioColor.warning,
                options: const [KRadioOption(value: 'a', label: 'Warning')],
              ),
              KRadioGroup<String>(
                value: 'a',
                onChanged: (_) {},
                color: RadioColor.danger,
                options: const [KRadioOption(value: 'a', label: 'Danger')],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Invalid',
          child: KRadioGroup<String>(
            value: _invalid,
            onChanged: (v) => setState(() => _invalid = v),
            isInvalid: true,
            errorMessage: 'Please select an option',
            options: const [
              KRadioOption(value: 'yes', label: 'Yes'),
              KRadioOption(value: 'no', label: 'No'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SwitchDemo extends StatefulWidget {
  const _SwitchDemo();
  @override
  State<_SwitchDemo> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<_SwitchDemo> {
  bool _notifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Basic',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KSwitch(
                value: _notifications,
                onChanged: (v) => setState(() => _notifications = v),
                label: 'Push notifications',
                description: 'Receive alerts on your device',
              ),
              const SizedBox(height: 14),
              KSwitch(
                value: _darkMode,
                onChanged: (v) => setState(() => _darkMode = v),
                label: 'Dark mode',
              ),
              const SizedBox(height: 14),
              const KSwitch(
                value: false,
                onChanged: null,
                label: 'Disabled',
                isDisabled: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Colors',
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              KSwitch(
                value: true,
                onChanged: (_) {},
                color: SwitchColor.default_,
                label: 'Default',
              ),
              KSwitch(
                value: true,
                onChanged: (_) {},
                color: SwitchColor.primary,
                label: 'Primary',
              ),
              KSwitch(
                value: true,
                onChanged: (_) {},
                color: SwitchColor.secondary,
                label: 'Secondary',
              ),
              KSwitch(
                value: true,
                onChanged: (_) {},
                color: SwitchColor.success,
                label: 'Success',
              ),
              KSwitch(
                value: true,
                onChanged: (_) {},
                color: SwitchColor.warning,
                label: 'Warning',
              ),
              KSwitch(
                value: true,
                onChanged: (_) {},
                color: SwitchColor.danger,
                label: 'Danger',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Sizes',
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              KSwitch(value: true, onChanged: (_) {}, size: SwitchSize.sm),
              KSwitch(value: true, onChanged: (_) {}, size: SwitchSize.md),
              KSwitch(value: true, onChanged: (_) {}, size: SwitchSize.lg),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Thumb icon',
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              KSwitch(
                value: true,
                onChanged: (_) {},
                thumbIcon: const Icon(Icons.light_mode_outlined),
                label: 'Light',
              ),
              KSwitch(
                value: false,
                onChanged: (_) {},
                thumbIcon: const Icon(Icons.dark_mode_outlined),
                label: 'Dark',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SliderDemo extends StatefulWidget {
  const _SliderDemo();
  @override
  State<_SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<_SliderDemo> {
  double _vol = 60;
  double _steps = 40;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Basic',
          child: KSlider(
            value: _vol,
            label: 'Volume',
            showValue: true,
            onChanged: (v) => setState(() => _vol = v),
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'With labels',
          child: KSlider(
            value: _steps,
            label: 'Steps',
            showValue: true,
            startLabel: '0',
            endLabel: '100',
            divisions: 10,
            onChanged: (v) => setState(() => _steps = v),
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Disabled',
          child: KSlider(value: 30, isDisabled: true, onChanged: (v) {}),
        ),
      ],
    );
  }
}

class _TabsDemo extends StatelessWidget {
  const _TabsDemo();

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Primary',
          child: KTabs(
            variant: TabVariant.primary,
            tabs: const [
              KTabItem(label: 'Overview', icon: Icon(Icons.home_outlined)),
              KTabItem(label: 'Analytics'),
              KTabItem(label: 'Settings'),
            ],
            children: [
              Text(
                'Overview content',
                style: TextStyle(color: tokens.defaultForeground),
              ),
              Text(
                'Analytics content',
                style: TextStyle(color: tokens.defaultForeground),
              ),
              Text(
                'Settings content',
                style: TextStyle(color: tokens.defaultForeground),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _DemoRow(
          label: 'Secondary',
          child: KTabs(
            variant: TabVariant.secondary,
            tabs: const [
              KTabItem(label: 'All'),
              KTabItem(label: 'Pending'),
              KTabItem(label: 'Done'),
            ],
            children: [
              Text(
                'All items',
                style: TextStyle(color: tokens.defaultForeground),
              ),
              Text(
                'Pending items',
                style: TextStyle(color: tokens.defaultForeground),
              ),
              Text(
                'Completed items',
                style: TextStyle(color: tokens.defaultForeground),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressDemo extends StatelessWidget {
  const _ProgressDemo();

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Colors',
          child: const Column(
            children: [
              KProgressBar(
                value: 0.7,
                color: ProgressColor.primary,
                label: 'Primary',
                showValue: true,
              ),
              SizedBox(height: 10),
              KProgressBar(
                value: 0.5,
                color: ProgressColor.success,
                label: 'Success',
                showValue: true,
              ),
              SizedBox(height: 10),
              KProgressBar(
                value: 0.3,
                color: ProgressColor.warning,
                label: 'Warning',
                showValue: true,
              ),
              SizedBox(height: 10),
              KProgressBar(
                value: 0.8,
                color: ProgressColor.danger,
                label: 'Danger',
                showValue: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Sizes',
          child: const Column(
            children: [
              KProgressBar(value: 0.6, size: ProgressSize.sm),
              SizedBox(height: 8),
              KProgressBar(value: 0.6, size: ProgressSize.md),
              SizedBox(height: 8),
              KProgressBar(value: 0.6, size: ProgressSize.lg),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Circular',
          child: Wrap(
            spacing: 20,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              KProgressCircle(
                value: 0.75,
                size: 64,
                child: Text(
                  '75%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: tokens.foreground,
                  ),
                ),
              ),
              const KProgressCircle(
                value: 0.4,
                size: 64,
                color: ProgressColor.success,
              ),
              const KProgressCircle(
                value: 0.9,
                size: 64,
                color: ProgressColor.danger,
              ),
              const KProgressCircle(
                value: 0.0,
                size: 48,
                isIndeterminate: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SpinnerDemo extends StatelessWidget {
  const _SpinnerDemo();

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Sizes',
          child: Wrap(
            spacing: 20,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              KSpinner(size: SpinnerSize.sm),
              KSpinner(size: SpinnerSize.md),
              KSpinner(size: SpinnerSize.lg),
              KSpinner(size: SpinnerSize.xl),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Colors',
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              KSpinner(color: tokens.primary),
              KSpinner(color: tokens.secondary),
              KSpinner(color: tokens.success),
              KSpinner(color: tokens.warning),
              KSpinner(color: tokens.danger),
            ],
          ),
        ),
      ],
    );
  }
}

class _SeparatorDemo extends StatelessWidget {
  const _SeparatorDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DemoRow(
          label: 'Horizontal',
          child: const Column(
            children: [
              KSeparator(),
              SizedBox(height: 8),
              KSeparator(label: 'OR CONTINUE WITH'),
              SizedBox(height: 8),
              KSeparator(variant: SeparatorVariant.secondary),
              SizedBox(height: 8),
              KSeparator(variant: SeparatorVariant.tertiary),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Vertical',
          child: SizedBox(
            height: 48,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('All'),
                KSeparator(orientation: SeparatorOrientation.vertical),
                Text('Pending'),
                KSeparator(orientation: SeparatorOrientation.vertical),
                Text('Done'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SkeletonDemo extends StatelessWidget {
  const _SkeletonDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DemoRow(
          label: 'Card',
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  KSkeleton(height: 48, isCircle: true),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KSkeleton(height: 14, width: 140),
                        SizedBox(height: 6),
                        KSkeleton(height: 12, width: 100),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              KSkeleton(height: 12),
              SizedBox(height: 6),
              KSkeleton(height: 12),
              SizedBox(height: 6),
              KSkeleton(height: 12, width: 220),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _DemoRow(
          label: 'Shapes',
          child: const Row(
            children: [
              KSkeleton(height: 40, isCircle: true),
              SizedBox(width: 12),
              KSkeleton(height: 40, width: 80, borderRadius: 4),
              SizedBox(width: 12),
              KSkeleton(height: 40, width: 40, borderRadius: 0),
            ],
          ),
        ),
      ],
    );
  }
}

class _DialogDemo extends StatelessWidget {
  const _DialogDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        KButton(
          variant: ButtonVariant.flat,
          color: ButtonColor.default_,
          onPressed: () => showKDialog(
            context: context,
            child: KDialog(
              title: const Text('Confirm delete'),
              description: const Text(
                'This action cannot be undone. Are you sure you want to delete this item?',
              ),
              content: const SizedBox.shrink(),
              actions: [
                KButton(
                  variant: ButtonVariant.flat,
                  color: ButtonColor.default_,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                KButton(
                  color: ButtonColor.danger,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ),
          child: const Text('Confirm dialog'),
        ),
        KButton(
          variant: ButtonVariant.flat,
          color: ButtonColor.default_,
          onPressed: () => showKDialog(
            context: context,
            child: KDialog(
              title: const Text('Edit profile'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KInput(
                    label: 'Name',
                    hint: 'Enter your name',
                    variant: InputVariant.bordered,
                  ),
                  SizedBox(height: 12),
                  KInput(
                    label: 'Email',
                    hint: 'name@example.com',
                    variant: InputVariant.bordered,
                  ),
                ],
              ),
              actions: [
                KButton(
                  variant: ButtonVariant.flat,
                  color: ButtonColor.default_,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                KButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
          child: const Text('Form dialog'),
        ),
      ],
    );
  }
}

class _ToastDemo extends StatelessWidget {
  const _ToastDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        KButton(
          variant: ButtonVariant.flat,
          color: ButtonColor.default_,
          startContent: const Icon(Icons.info_outline, size: 16),
          onPressed: () => KToast.show(
            context,
            message: 'A new update is available.',
            title: 'Info',
          ),
          child: const Text('Info'),
        ),
        KButton(
          variant: ButtonVariant.flat,
          color: ButtonColor.default_,
          startContent: const Icon(Icons.check_circle_outline, size: 16),
          onPressed: () => KToast.show(
            context,
            message: 'Changes saved successfully.',
            title: 'Success',
            variant: ToastVariant.success,
          ),
          child: const Text('Success'),
        ),
        KButton(
          variant: ButtonVariant.flat,
          color: ButtonColor.default_,
          startContent: const Icon(Icons.warning_amber_outlined, size: 16),
          onPressed: () => KToast.show(
            context,
            message: 'Your session is about to expire.',
            title: 'Warning',
            variant: ToastVariant.warning,
          ),
          child: const Text('Warning'),
        ),
        KButton(
          variant: ButtonVariant.flat,
          color: ButtonColor.default_,
          startContent: const Icon(Icons.error_outline, size: 16),
          onPressed: () => KToast.show(
            context,
            message: 'Something went wrong. Try again.',
            title: 'Error',
            variant: ToastVariant.danger,
          ),
          child: const Text('Error'),
        ),
      ],
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────

class _DemoRow extends StatelessWidget {
  const _DemoRow({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<KineticTokens>()!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: tokens.defaultForeground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
