// kinetic_tokens.dart — copy-pasted by kinetic init, free to modify
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Colors
// ─────────────────────────────────────────────────────────────

abstract final class KColors {
  // Light
  static const lightPrimary       = Color(0xFF09090B);
  static const lightOnPrimary     = Color(0xFFFFFFFF);
  static const lightSecondary     = Color(0xFFF4F4F5);
  static const lightOnSecondary   = Color(0xFF09090B);
  static const lightDestructive   = Color(0xFFEF4444);
  static const lightOnDestructive = Color(0xFFFFFFFF);
  static const lightBackground    = Color(0xFFFFFFFF);
  static const lightMuted         = Color(0xFFF4F4F5);
  static const lightOnMuted       = Color(0xFF71717A);
  static const lightBorder        = Color(0xFFE4E4E7);
  static const lightRing          = Color(0xFF09090B);

  // Dark
  static const darkPrimary        = Color(0xFFFAFAFA);
  static const darkOnPrimary      = Color(0xFF09090B);
  static const darkSecondary      = Color(0xFF27272A);
  static const darkOnSecondary    = Color(0xFFFAFAFA);
  static const darkDestructive    = Color(0xFF7F1D1D);
  static const darkOnDestructive  = Color(0xFFFEF2F2);
  static const darkBackground     = Color(0xFF09090B);
  static const darkMuted          = Color(0xFF27272A);
  static const darkOnMuted        = Color(0xFFA1A1AA);
  static const darkBorder         = Color(0xFF27272A);
  static const darkRing           = Color(0xFFFAFAFA);
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

  static const double radiusSm   =  6.0;
  static const double radiusMd   =  8.0;
  static const double radiusLg   = 12.0;
  static const double radiusXl   = 16.0;
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

  static const weightNormal = FontWeight.w400;
  static const weightMedium = FontWeight.w500;
  static const weightSemi   = FontWeight.w600;
  static const weightBold   = FontWeight.w700;
}

// ─────────────────────────────────────────────────────────────
// KineticTokens — ThemeExtension
// ─────────────────────────────────────────────────────────────

@immutable
class KineticTokens extends ThemeExtension<KineticTokens> {
  const KineticTokens({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.destructive,
    required this.onDestructive,
    required this.background,
    required this.muted,
    required this.onMuted,
    required this.border,
    required this.ring,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
  });

  final Color  primary;
  final Color  onPrimary;
  final Color  secondary;
  final Color  onSecondary;
  final Color  destructive;
  final Color  onDestructive;
  final Color  background;
  final Color  muted;
  final Color  onMuted;
  final Color  border;
  final Color  ring;
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;

  static const light = KineticTokens(
    primary:       KColors.lightPrimary,
    onPrimary:     KColors.lightOnPrimary,
    secondary:     KColors.lightSecondary,
    onSecondary:   KColors.lightOnSecondary,
    destructive:   KColors.lightDestructive,
    onDestructive: KColors.lightOnDestructive,
    background:    KColors.lightBackground,
    muted:         KColors.lightMuted,
    onMuted:       KColors.lightOnMuted,
    border:        KColors.lightBorder,
    ring:          KColors.lightRing,
    radiusSm: KSpacing.radiusSm,
    radiusMd: KSpacing.radiusMd,
    radiusLg: KSpacing.radiusLg,
  );

  static const dark = KineticTokens(
    primary:       KColors.darkPrimary,
    onPrimary:     KColors.darkOnPrimary,
    secondary:     KColors.darkSecondary,
    onSecondary:   KColors.darkOnSecondary,
    destructive:   KColors.darkDestructive,
    onDestructive: KColors.darkOnDestructive,
    background:    KColors.darkBackground,
    muted:         KColors.darkMuted,
    onMuted:       KColors.darkOnMuted,
    border:        KColors.darkBorder,
    ring:          KColors.darkRing,
    radiusSm: KSpacing.radiusSm,
    radiusMd: KSpacing.radiusMd,
    radiusLg: KSpacing.radiusLg,
  );

  @override
  KineticTokens copyWith({
    Color?  primary,
    Color?  onPrimary,
    Color?  secondary,
    Color?  onSecondary,
    Color?  destructive,
    Color?  onDestructive,
    Color?  background,
    Color?  muted,
    Color?  onMuted,
    Color?  border,
    Color?  ring,
    double? radiusSm,
    double? radiusMd,
    double? radiusLg,
  }) => KineticTokens(
    primary:       primary       ?? this.primary,
    onPrimary:     onPrimary     ?? this.onPrimary,
    secondary:     secondary     ?? this.secondary,
    onSecondary:   onSecondary   ?? this.onSecondary,
    destructive:   destructive   ?? this.destructive,
    onDestructive: onDestructive ?? this.onDestructive,
    background:    background    ?? this.background,
    muted:         muted         ?? this.muted,
    onMuted:       onMuted       ?? this.onMuted,
    border:        border        ?? this.border,
    ring:          ring          ?? this.ring,
    radiusSm:      radiusSm      ?? this.radiusSm,
    radiusMd:      radiusMd      ?? this.radiusMd,
    radiusLg:      radiusLg      ?? this.radiusLg,
  );

  @override
  KineticTokens lerp(KineticTokens other, double t) => KineticTokens(
    primary:       Color.lerp(primary,       other.primary,       t)!,
    onPrimary:     Color.lerp(onPrimary,     other.onPrimary,     t)!,
    secondary:     Color.lerp(secondary,     other.secondary,     t)!,
    onSecondary:   Color.lerp(onSecondary,   other.onSecondary,   t)!,
    destructive:   Color.lerp(destructive,   other.destructive,   t)!,
    onDestructive: Color.lerp(onDestructive, other.onDestructive, t)!,
    background:    Color.lerp(background,    other.background,    t)!,
    muted:         Color.lerp(muted,         other.muted,         t)!,
    onMuted:       Color.lerp(onMuted,       other.onMuted,       t)!,
    border:        Color.lerp(border,        other.border,        t)!,
    ring:          Color.lerp(ring,          other.ring,          t)!,
    radiusSm: radiusSm + (other.radiusSm - radiusSm) * t,
    radiusMd: radiusMd + (other.radiusMd - radiusMd) * t,
    radiusLg: radiusLg + (other.radiusLg - radiusLg) * t,
  );
}
