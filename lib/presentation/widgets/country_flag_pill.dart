import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CountryFlagPill extends StatelessWidget {
  final String countryCode;
  final String countryName;
  final bool isDark;

  const CountryFlagPill({
    super.key,
    required this.countryCode,
    required this.countryName,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final isBD = countryCode == 'BD';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.15) : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.25)
              : AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Styled Flag icon badge
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isBD ? AppColors.bdGreen : AppColors.omanRed,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            alignment: Alignment.center,
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isBD ? AppColors.omanRed : Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            countryName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
