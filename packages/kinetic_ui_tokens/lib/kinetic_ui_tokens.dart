export 'colors.dart';
export 'spacing.dart';
export 'typography.dart';

import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';

@immutable
class KineticTokens extends ThemeExtension<KineticTokens> {
  const KineticTokens({
    required this.background,
    required this.foreground,
    required this.content1,
    required this.content2,
    required this.content3,
    required this.content4,
    required this.divider,
    required this.overlay,
    required this.focus,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.success,
    required this.successForeground,
    required this.warning,
    required this.warningForeground,
    required this.danger,
    required this.dangerForeground,
    required this.defaultColor,
    required this.defaultForeground,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
  });

  final Color  background;
  final Color  foreground;
  final Color  content1;
  final Color  content2;
  final Color  content3;
  final Color  content4;
  final Color  divider;
  final Color  overlay;
  final Color  focus;
  final Color  primary;
  final Color  primaryForeground;
  final Color  secondary;
  final Color  secondaryForeground;
  final Color  success;
  final Color  successForeground;
  final Color  warning;
  final Color  warningForeground;
  final Color  danger;
  final Color  dangerForeground;
  final Color  defaultColor;
  final Color  defaultForeground;
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;

  static const light = KineticTokens(
    background:          Color(0xFFFFFFFF),
    foreground:          Color(0xFF11181C),
    content1:            Color(0xFFFFFFFF),
    content2:            Color(0xFFF4F4F5),
    content3:            Color(0xFFE4E4E7),
    content4:            Color(0xFFD4D4D8),
    divider:             Color(0xFFF0F0F0),
    overlay:             Color(0xFF000000),
    focus:               KColors.primary500,
    primary:             KColors.primary500,
    primaryForeground:   Color(0xFFFFFFFF),
    secondary:           KColors.secondary500,
    secondaryForeground: Color(0xFFFFFFFF),
    success:             KColors.success500,
    successForeground:   Color(0xFFFFFFFF),
    warning:             KColors.warning500,
    warningForeground:   Color(0xFFFFFFFF),
    danger:              KColors.danger500,
    dangerForeground:    Color(0xFFFFFFFF),
    defaultColor:        KColors.default50,
    defaultForeground:   Color(0xFF11181C),
    radiusSm: KSpacing.radiusSm,
    radiusMd: KSpacing.radiusMd,
    radiusLg: KSpacing.radiusLg,
  );

  static const dark = KineticTokens(
    background:          Color(0xFF000000),
    foreground:          Color(0xFFECEDEE),
    content1:            Color(0xFF18181B),
    content2:            Color(0xFF27272A),
    content3:            Color(0xFF3F3F46),
    content4:            Color(0xFF52525B),
    divider:             Color(0xFF27272A),
    overlay:             Color(0xFF000000),
    focus:               KColors.primary500,
    primary:             KColors.primary500,
    primaryForeground:   Color(0xFFFFFFFF),
    secondary:           Color(0xFF9353D3),
    secondaryForeground: Color(0xFFFFFFFF),
    success:             KColors.success500,
    successForeground:   Color(0xFF000000),
    warning:             KColors.warning500,
    warningForeground:   Color(0xFF000000),
    danger:              KColors.danger500,
    dangerForeground:    Color(0xFFFFFFFF),
    defaultColor:        KColors.default700,
    defaultForeground:   Color(0xFFECEDEE),
    radiusSm: KSpacing.radiusSm,
    radiusMd: KSpacing.radiusMd,
    radiusLg: KSpacing.radiusLg,
  );

  @override
  KineticTokens copyWith({
    Color?  background,
    Color?  foreground,
    Color?  content1,
    Color?  content2,
    Color?  content3,
    Color?  content4,
    Color?  divider,
    Color?  overlay,
    Color?  focus,
    Color?  primary,
    Color?  primaryForeground,
    Color?  secondary,
    Color?  secondaryForeground,
    Color?  success,
    Color?  successForeground,
    Color?  warning,
    Color?  warningForeground,
    Color?  danger,
    Color?  dangerForeground,
    Color?  defaultColor,
    Color?  defaultForeground,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
  }) => KineticTokens(
    background:          background          ?? this.background,
    foreground:          foreground          ?? this.foreground,
    content1:            content1            ?? this.content1,
    content2:            content2            ?? this.content2,
    content3:            content3            ?? this.content3,
    content4:            content4            ?? this.content4,
    divider:             divider             ?? this.divider,
    overlay:             overlay             ?? this.overlay,
    focus:               focus               ?? this.focus,
    primary:             primary             ?? this.primary,
    primaryForeground:   primaryForeground   ?? this.primaryForeground,
    secondary:           secondary           ?? this.secondary,
    secondaryForeground: secondaryForeground ?? this.secondaryForeground,
    success:             success             ?? this.success,
    successForeground:   successForeground   ?? this.successForeground,
    warning:             warning             ?? this.warning,
    warningForeground:   warningForeground   ?? this.warningForeground,
    danger:              danger              ?? this.danger,
    dangerForeground:    dangerForeground    ?? this.dangerForeground,
    defaultColor:        defaultColor        ?? this.defaultColor,
    defaultForeground:   defaultForeground   ?? this.defaultForeground,
    radiusSm:            radiusSm            ?? this.radiusSm,
    radiusMd:            radiusMd            ?? this.radiusMd,
    radiusLg:            radiusLg            ?? this.radiusLg,
  );

  @override
  KineticTokens lerp(KineticTokens other, double t) => KineticTokens(
    background:          Color.lerp(background,          other.background,          t)!,
    foreground:          Color.lerp(foreground,          other.foreground,          t)!,
    content1:            Color.lerp(content1,            other.content1,            t)!,
    content2:            Color.lerp(content2,            other.content2,            t)!,
    content3:            Color.lerp(content3,            other.content3,            t)!,
    content4:            Color.lerp(content4,            other.content4,            t)!,
    divider:             Color.lerp(divider,             other.divider,             t)!,
    overlay:             Color.lerp(overlay,             other.overlay,             t)!,
    focus:               Color.lerp(focus,               other.focus,               t)!,
    primary:             Color.lerp(primary,             other.primary,             t)!,
    primaryForeground:   Color.lerp(primaryForeground,   other.primaryForeground,   t)!,
    secondary:           Color.lerp(secondary,           other.secondary,           t)!,
    secondaryForeground: Color.lerp(secondaryForeground, other.secondaryForeground, t)!,
    success:             Color.lerp(success,             other.success,             t)!,
    successForeground:   Color.lerp(successForeground,   other.successForeground,   t)!,
    warning:             Color.lerp(warning,             other.warning,             t)!,
    warningForeground:   Color.lerp(warningForeground,   other.warningForeground,   t)!,
    danger:              Color.lerp(danger,              other.danger,              t)!,
    dangerForeground:    Color.lerp(dangerForeground,    other.dangerForeground,    t)!,
    defaultColor:        Color.lerp(defaultColor,        other.defaultColor,        t)!,
    defaultForeground:   Color.lerp(defaultForeground,   other.defaultForeground,   t)!,
    radiusSm: radiusSm + (other.radiusSm - radiusSm) * t,
    radiusMd: radiusMd + (other.radiusMd - radiusMd) * t,
    radiusLg: radiusLg + (other.radiusLg - radiusLg) * t,
  );
}
