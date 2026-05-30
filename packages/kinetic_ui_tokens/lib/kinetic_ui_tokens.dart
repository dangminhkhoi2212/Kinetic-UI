export 'colors.dart';
export 'spacing.dart';
export 'typography.dart';

import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';

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
    radiusSm:      lerpDouble(radiusSm, other.radiusSm, t),
    radiusMd:      lerpDouble(radiusMd, other.radiusMd, t),
    radiusLg:      lerpDouble(radiusLg, other.radiusLg, t),
  );

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
