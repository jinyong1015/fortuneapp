import 'package:flutter/material.dart';

/// Design tokens from Figma COSMIC FLOW / ASTRA screens.
abstract final class AppColors {
  static const background = Color(0xFF15121D);
  static const surface = Color(0xFF1D1A26);
  static const surfaceElevated = Color(0xFF2C2834);
  static const surfaceMuted = Color(0xFF211E2A);
  static const surfaceDeep = Color(0xFF100C18);
  static const border = Color(0xFF4C4452);
  static const borderSoft = Color(0xFF373340);

  static const textPrimary = Color(0xFFE7DFF0);
  static const textSecondary = Color(0xFFCEC3D3);
  static const textMuted = Color(0xFF978D9D);

  static const lavender = Color(0xFFDDB8FF);
  static const pink = Color(0xFFFFAFD3);
  static const pinkSoft = Color(0xFFFFD8E7);
  static const purple = Color(0xFFC084FC);
  static const purpleDeep = Color(0xFF500989);
  static const magenta = Color(0xFF85145A);
  static const cyan = Color(0xFF7BD0FF);
  static const cyanDeep = Color(0xFF0EABE5);

  static const ctaGradient = LinearGradient(
    colors: [Color(0xFFC084FC), Color(0xFFDDB8FF), Color(0xFFFFAFD3)],
  );
}
