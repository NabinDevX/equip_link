import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum TrustBadgeVariant { verifiedEdu, honorCode, inspected, lockerReady }

class TrustBadge extends StatelessWidget {
  final String? customText;
  final TrustBadgeVariant variant;
  final bool? isVerified;

  const TrustBadge({
    super.key,
    this.customText,
    this.variant = TrustBadgeVariant.verifiedEdu,
    this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;
    String text;

    switch (variant) {
      case TrustBadgeVariant.verifiedEdu:
        bg = AppColors.secondaryContainer;
        fg = AppColors.secondary;
        icon = Icons.verified_user_rounded;
        text = customText ?? 'Verified .edu Network';
        break;
      case TrustBadgeVariant.honorCode:
        bg = AppColors.successContainer;
        fg = AppColors.success;
        icon = Icons.shield_rounded;
        text = customText ?? 'Honor Code Protected';
        break;
      case TrustBadgeVariant.inspected:
        bg = AppColors.successContainer;
        fg = AppColors.success;
        icon = Icons.check_circle_rounded;
        text = customText ?? 'Inspected & Tested';
        break;
      case TrustBadgeVariant.lockerReady:
        bg = const Color(0xFFE0F2FE);
        fg = AppColors.lockerAccent;
        icon = Icons.lock_outline_rounded;
        text = customText ?? 'Smart Locker Available';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(text, style: AppTypography.labelSM.copyWith(color: fg)),
        ],
      ),
    );
  }
}
