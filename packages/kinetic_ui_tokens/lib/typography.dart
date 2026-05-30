import 'package:flutter/material.dart';

abstract final class KTypography {
  static const fontFamily = 'Inter';

  static const xs   = TextStyle(fontSize: 12, height: 1.5);
  static const sm   = TextStyle(fontSize: 14, height: 1.5);
  static const base = TextStyle(fontSize: 16, height: 1.5);
  static const lg   = TextStyle(fontSize: 18, height: 1.5);
  static const xl   = TextStyle(fontSize: 20, height: 1.4);
  static const xl2  = TextStyle(fontSize: 24, height: 1.3);
  static const xl3  = TextStyle(fontSize: 30, height: 1.25);
  static const xl4  = TextStyle(fontSize: 36, height: 1.2);

  static const weightNormal  = FontWeight.w400;
  static const weightMedium  = FontWeight.w500;
  static const weightSemi    = FontWeight.w600;
  static const weightBold    = FontWeight.w700;

  static TextStyle heading1() =>
      xl4.copyWith(fontWeight: weightBold,   letterSpacing: -0.5);
  static TextStyle heading2() =>
      xl3.copyWith(fontWeight: weightSemi,   letterSpacing: -0.3);
  static TextStyle heading3() =>
      xl2.copyWith(fontWeight: weightSemi);
  static TextStyle heading4() =>
      xl.copyWith(fontWeight:  weightSemi);
  static TextStyle label()    =>
      sm.copyWith(fontWeight:  weightMedium, letterSpacing: 0.1);
  static TextStyle caption()  =>
      xs.copyWith(color: const Color(0xFF71717A));
}
