import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTypography {
  static const TextStyle headlineXL = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineLG = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMD = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.35,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSM = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLG = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMD = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySM = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelLG = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMD = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.35,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSM = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  // Aliases for Material 3 naming conventions
  static const TextStyle headlineLarge = headlineLG;
  static const TextStyle headlineMedium = headlineMD;
  static const TextStyle headlineSmall = headlineSM;
  static const TextStyle bodyLarge = bodyLG;
  static const TextStyle bodyMedium = bodyMD;
  static const TextStyle bodySmall = bodySM;
  static const TextStyle labelLarge = labelLG;
  static const TextStyle labelMedium = labelMD;
  static const TextStyle labelSmall = labelSM;
}
