import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../providers/app_state_provider.dart';
import '../../../widgets/country_flag_pill.dart';

class HeroBannerWidget extends StatelessWidget {
  const HeroBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final isBDOrigin = appState.activeRoute == ActiveRoute.bdToOman;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                AppAssets.heroBanner,
                fit: BoxFit.cover,
              ),
            ),

            // Gradient Overlay for readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.35),
                      AppColors.primaryDark.withValues(alpha: 0.88),
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.accentCyan.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.accentCyan.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          size: 13,
                          color: AppColors.accentCyan,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          appState.t('directBadge'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Hero Title
                  Text(
                    appState.t('heroTitle'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      height: 1.25,
                      letterSpacing: -0.4,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    appState.t('heroSubtitle'),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Route Switcher Pill
                  GestureDetector(
                    onTap: () => appState.toggleRoute(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryFlagPill(
                            countryCode: isBDOrigin ? 'BD' : 'OM',
                            countryName: isBDOrigin ? appState.t('bangladesh') : appState.t('oman'),
                            isDark: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.accent.withValues(alpha: 0.6),
                              ),
                              child: const Icon(
                                Icons.swap_horiz_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          CountryFlagPill(
                            countryCode: isBDOrigin ? 'OM' : 'BD',
                            countryName: isBDOrigin ? appState.t('oman') : appState.t('bangladesh'),
                            isDark: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
