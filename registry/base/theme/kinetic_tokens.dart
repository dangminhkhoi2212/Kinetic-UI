// kinetic_tokens.dart — HeroUI color system, copy-pasted by kinetic init, free to modify
// Design reference: https://www.heroui.com/docs/customization/colors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color Scales
// ─────────────────────────────────────────────────────────────

abstract final class KColors {
  // ── Primary (Blue) ────────────────────────────────────────
  static const primary50  = Color(0xFFE6F1FE);
  static const primary100 = Color(0xFFCEE4FD);
  static const primary200 = Color(0xFF9ECBFA);
  static const primary300 = Color(0xFF6DB1F6);
  static const primary400 = Color(0xFF3D97F0);
  static const primary500 = Color(0xFF006FEE);
  static const primary600 = Color(0xFF005BC4);
  static const primary700 = Color(0xFF004493);
  static const primary800 = Color(0xFF002E62);
  static const primary900 = Color(0xFF001731);

  // ── Secondary (Purple) ────────────────────────────────────
  static const secondary50  = Color(0xFFF2EAFA);
  static const secondary100 = Color(0xFFE4D4F4);
  static const secondary200 = Color(0xFFCAADE8);
  static const secondary300 = Color(0xFFAF86DB);
  static const secondary400 = Color(0xFF955FCF);
  static const secondary500 = Color(0xFF7828C8);
  static const secondary600 = Color(0xFF6020A0);
  static const secondary700 = Color(0xFF481878);
  static const secondary800 = Color(0xFF301050);
  static const secondary900 = Color(0xFF180828);

  // ── Success (Green) ───────────────────────────────────────
  static const success50  = Color(0xFFE8FAF0);
  static const success100 = Color(0xFFD1F4E0);
  static const success200 = Color(0xFFA2E9C1);
  static const success300 = Color(0xFF74DFA2);
  static const success400 = Color(0xFF45D483);
  static const success500 = Color(0xFF17C964);
  static const success600 = Color(0xFF12A150);
  static const success700 = Color(0xFF0E793C);
  static const success800 = Color(0xFF095028);
  static const success900 = Color(0xFF052814);

  // ── Warning (Amber) ───────────────────────────────────────
  static const warning50  = Color(0xFFFEFCE8);
  static const warning100 = Color(0xFFFDF5B0);
  static const warning200 = Color(0xFFFBEA61);
  static const warning300 = Color(0xFFF9DA12);
  static const warning400 = Color(0xFFD4B800);
  static const warning500 = Color(0xFFF5A524);
  static const warning600 = Color(0xFFC4840B);
  static const warning700 = Color(0xFF936309);
  static const warning800 = Color(0xFF624206);
  static const warning900 = Color(0xFF312103);

  // ── Danger (Red) ──────────────────────────────────────────
  static const danger50  = Color(0xFFFEE7EF);
  static const danger100 = Color(0xFFFDD0DF);
  static const danger200 = Color(0xFFFAA0BF);
  static const danger300 = Color(0xFFF871A0);
  static const danger400 = Color(0xFFF54180);
  static const danger500 = Color(0xFFF31260);
  static const danger600 = Color(0xFFC20E4D);
  static const danger700 = Color(0xFF920B3A);
  static const danger800 = Color(0xFF610726);
  static const danger900 = Color(0xFF310413);

  // ── Default (Zinc/Gray) ───────────────────────────────────
  static const default50  = Color(0xFFF4F4F5);
  static const default100 = Color(0xFFE4E4E7);
  static const default200 = Color(0xFFD4D4D8);
  static const default300 = Color(0xFFA1A1AA);
  static const default400 = Color(0xFF71717A);
  static const default500 = Color(0xFF52525B);
  static const default600 = Color(0xFF3F3F46);
  static const default700 = Color(0xFF27272A);
  static const default800 = Color(0xFF18181B);
  static const default900 = Color(0xFF000000);
}

// ─────────────────────────────────────────────────────────────
// Spacing & Radius
// ─────────────────────────────────────────────────────────────

abstract final class KSpacing {
  static const double s1  =  4.0;
  static const double s2  =  8.0;
  static const double s3  = 12.0;
  static const double s4  = 16.0;
  static const double s5  = 20.0;
  static const double s6  = 24.0;
  static const double s8  = 32.0;
  static const double s10 = 40.0;
  static const double s12 = 48.0;

  static const double radiusNone = 0.0;
  static const double radiusSm   =  8.0;
  static const double radiusMd   = 12.0;
  static const double radiusLg   = 16.0;
  static const double radiusXl   = 20.0;
  static const double radiusFull = 9999.0;
}

// ─────────────────────────────────────────────────────────────
// Typography
// ─────────────────────────────────────────────────────────────

abstract final class KTypography {
  static const String fontFamily = 'Inter';

  static const xs   = TextStyle(fontSize: 12, height: 1.5);
  static const sm   = TextStyle(fontSize: 14, height: 1.5);
  static const base = TextStyle(fontSize: 16, height: 1.5);
  static const lg   = TextStyle(fontSize: 18, height: 1.5);
  static const xl   = TextStyle(fontSize: 20, height: 1.4);
  static const xl2  = TextStyle(fontSize: 24, height: 1.3);
  static const xl3  = TextStyle(fontSize: 30, height: 1.25);

  static const weightNormal = FontWeight.w400;
  static const weightMedium = FontWeight.w500;
  static const weightSemi   = FontWeight.w600;
  static const weightBold   = FontWeight.w700;
}

// ─────────────────────────────────────────────────────────────
// KineticTokens — ThemeExtension (HeroUI design system)
// ─────────────────────────────────────────────────────────────

@immutable
class KineticTokens extends ThemeExtension<KineticTokens> {
  const KineticTokens({
    // Layout
    required this.background,
    required this.foreground,
    required this.content1,
    required this.content2,
    required this.content3,
    required this.content4,
    required this.divider,
    required this.overlay,
    required this.focus,
    // Primary
    required this.primary,
    required this.primaryForeground,
    // Secondary
    required this.secondary,
    required this.secondaryForeground,
    // Success
    required this.success,
    required this.successForeground,
    // Warning
    required this.warning,
    required this.warningForeground,
    // Danger
    required this.danger,
    required this.dangerForeground,
    // Default (neutral)
    required this.defaultColor,
    required this.defaultForeground,
    // Radius
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
  });

  // Layout
  final Color  background;
  final Color  foreground;
  final Color  content1;
  final Color  content2;
  final Color  content3;
  final Color  content4;
  final Color  divider;
  final Color  overlay;
  final Color  focus;
  // Semantic colors
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
  // Radius
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;

  // ── Light ────────────────────────────────────────────────
  static const light = KineticTokens(
    background:         Color(0xFFFFFFFF),
    foreground:         Color(0xFF11181C),
    content1:           Color(0xFFFFFFFF),
    content2:           Color(0xFFF4F4F5),
    content3:           Color(0xFFE4E4E7),
    content4:           Color(0xFFD4D4D8),
    divider:            Color(0xFFF0F0F0),
    overlay:            Color(0xFF000000),
    focus:              KColors.primary500,

    primary:            KColors.primary500,
    primaryForeground:  Color(0xFFFFFFFF),

    secondary:          KColors.secondary500,
    secondaryForeground: Color(0xFFFFFFFF),

    success:            KColors.success500,
    successForeground:  Color(0xFFFFFFFF),

    warning:            KColors.warning500,
    warningForeground:  Color(0xFFFFFFFF),

    danger:             KColors.danger500,
    dangerForeground:   Color(0xFFFFFFFF),

    defaultColor:       KColors.default50,
    defaultForeground:  Color(0xFF11181C),

    radiusSm: KSpacing.radiusSm,
    radiusMd: KSpacing.radiusMd,
    radiusLg: KSpacing.radiusLg,
  );

  // ── Dark ─────────────────────────────────────────────────
  static const dark = KineticTokens(
    background:         Color(0xFF000000),
    foreground:         Color(0xFFECEDEE),
    content1:           Color(0xFF18181B),
    content2:           Color(0xFF27272A),
    content3:           Color(0xFF3F3F46),
    content4:           Color(0xFF52525B),
    divider:            Color(0xFF27272A),
    overlay:            Color(0xFF000000),
    focus:              KColors.primary500,

    primary:            KColors.primary500,
    primaryForeground:  Color(0xFFFFFFFF),

    secondary:          Color(0xFF9353D3),
    secondaryForeground: Color(0xFFFFFFFF),

    success:            KColors.success500,
    successForeground:  Color(0xFF000000),

    warning:            KColors.warning500,
    warningForeground:  Color(0xFF000000),

    danger:             KColors.danger500,
    dangerForeground:   Color(0xFFFFFFFF),

    defaultColor:       KColors.default700,
    defaultForeground:  Color(0xFFECEDEE),

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
