import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Primary & Accent
  static const Color primary = Color(0xFF143F5B);
  static const Color primaryContainer = Color(0xFF002940);
  static const Color primaryLight = Color(0xFFADD3F6);

  static const Color secondary = Color(0xFF147D77);
  static const Color secondaryContainer = Color(0xFFE6F4F2);
  static const Color secondaryLight = Color(0xFF99F2EA);

  // Status & Utility
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEE2E2);

  // Light Background & Surfaces
  static const Color background = Color(0xFFF5F8FC);
  static const Color canvas = background;
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFE8EFF5);
  static const Color surfaceContainerHigh = Color(0xFFE2E9F0);

  // Dark Palette
  static const Color darkBackground = Color(0xFF101923);
  static const Color darkSurface = Color(0xFF182433);
  static const Color darkSurfaceContainer = Color(0xFF233246);
  static const Color darkOutline = Color(0xFF2E425B);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // Typography / Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textMuted = textTertiary;

  // Borders & Dividers
  static const Color outline = Color(0xFFCBD5E1);
  static const Color outlineVariant = Color(0xFFE2E8F0);

  // Locker Accent
  static const Color lockerAccent = Color(0xFF0284C7);
}
