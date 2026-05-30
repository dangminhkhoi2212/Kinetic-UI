import 'package:flutter/material.dart';

abstract final class KSpacing {
  // ── Base scale (rem × 4px) ─────────────────────────────────────────────
  static const double px  =  1.0;
  static const double s0  =  0.0;
  static const double s1  =  4.0;
  static const double s2  =  8.0;
  static const double s3  = 12.0;
  static const double s4  = 16.0;
  static const double s5  = 20.0;
  static const double s6  = 24.0;
  static const double s8  = 32.0;
  static const double s10 = 40.0;
  static const double s12 = 48.0;
  static const double s16 = 64.0;
  static const double s20 = 80.0;
  static const double s24 = 96.0;

  // ── Border radius ──────────────────────────────────────────────────────
  static const double radiusSm  =  6.0;
  static const double radiusMd  =  8.0;
  static const double radiusLg  = 12.0;
  static const double radiusXl  = 16.0;
  static const double radiusFull = 9999.0;

  // ── Convenience EdgeInsets ─────────────────────────────────────────────
  static const insets1  = EdgeInsets.all(s1);
  static const insets2  = EdgeInsets.all(s2);
  static const insets3  = EdgeInsets.all(s3);
  static const insets4  = EdgeInsets.all(s4);

  static const insetH3 = EdgeInsets.symmetric(horizontal: s3);
  static const insetH4 = EdgeInsets.symmetric(horizontal: s4);
  static const insetH5 = EdgeInsets.symmetric(horizontal: s5);
  static const insetV2 = EdgeInsets.symmetric(vertical: s2);
  static const insetV3 = EdgeInsets.symmetric(vertical: s3);
}
