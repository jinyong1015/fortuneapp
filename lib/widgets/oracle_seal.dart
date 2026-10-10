import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'asset_icon.dart';

/// Sacred oracle seal from the main fortune card.
class OracleSeal extends StatelessWidget {
  const OracleSeal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112,
      height: 112,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0x99373340),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lavender.withValues(alpha: 0.35),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.lavender.withValues(alpha: 0.1),
                  Colors.transparent,
                  AppColors.pink.withValues(alpha: 0.2),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const AssetIcon('assets/icons/seal_outer.svg', width: 80, height: 80),
                const AssetIcon('assets/icons/seal_mid.svg', width: 58, height: 58),
                const AssetIcon('assets/icons/seal_diamond.svg', width: 48, height: 54),
                const AssetIcon('assets/icons/seal_inner.svg', width: 38, height: 42),
                const AssetIcon('assets/icons/seal_crescent.svg', width: 10, height: 10),
                Positioned(
                  top: 8,
                  child: const AssetIcon('assets/icons/seal_dot.svg', width: 4, height: 4),
                ),
                Positioned(
                  right: 10,
                  child: const AssetIcon('assets/icons/seal_dot2.svg', width: 4, height: 4),
                ),
                Positioned(
                  bottom: 8,
                  child: const AssetIcon('assets/icons/seal_dot.svg', width: 4, height: 4),
                ),
                Positioned(
                  left: 10,
                  child: const AssetIcon('assets/icons/seal_dot2.svg', width: 4, height: 4),
                ),
                Positioned(
                  top: 28,
                  right: 28,
                  child: const AssetIcon('assets/icons/seal_star.svg', width: 4, height: 4),
                ),
              ],
            ),
          ),
          Positioned(
            top: -4,
            right: 4,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lavender.withValues(alpha: 0.2),
              ),
              alignment: Alignment.center,
              child: const AssetIcon('assets/icons/glint.svg', width: 12, height: 11),
            ),
          ),
        ],
      ),
    );
  }
}
