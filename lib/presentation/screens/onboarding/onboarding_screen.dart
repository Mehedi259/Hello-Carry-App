import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../providers/app_state_provider.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const OnboardingScreen({super.key, required this.onFinished});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final isBn = appState.isBengali;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Logo, Language Toggle, and Skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(AppAssets.appLogo, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        appState.t('appName'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  // Language Switcher & Skip Row
                  Row(
                    children: [
                      // Language Switcher Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            _buildLangTab('English', !isBn, () => appState.setLanguage('English')),
                            _buildLangTab('বাংলা', isBn, () => appState.setLanguage('বাংলা')),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Skip Button
                      if (_currentPage < 2)
                        TextButton(
                          onPressed: widget.onFinished,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            appState.t('skip'),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // PageView Slider
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  // Slide 1: Welcome & Language Choice + Air Cargo
                  _buildSlide(
                    imagePath: AppAssets.onboardingWelcome,
                    title: appState.t('onboardingTitle1'),
                    subtitle: appState.t('onboardingSub1'),
                    customContent: _buildLanguageSelector(appState),
                  ),

                  // Slide 2: Sourcing Products & Wholesale
                  _buildSlide(
                    imagePath: AppAssets.onboardingSourcing,
                    title: appState.t('onboardingTitle2'),
                    subtitle: appState.t('onboardingSub2'),
                    customContent: _buildFeaturePills([
                      '📱 Electronics & Phones',
                      '👕 Export RMG Garments',
                      '🍳 Home Appliances',
                      '💄 Cosmetics & Wellness',
                    ]),
                  ),

                  // Slide 3: Real-Time GPS Tracking & Doorstep Delivery
                  _buildSlide(
                    imagePath: AppAssets.trackingRouteMap,
                    title: appState.t('onboardingTitle3'),
                    subtitle: appState.t('onboardingSub3'),
                    customContent: _buildFeaturePills([
                      '🛡️ 100% Insured Protection',
                      '🛃 Full Customs Clearance',
                      '🚚 Door-to-Door Delivery',
                      '✈️ Express Air Cargo: 3-5 Days',
                    ]),
                  ),
                ],
              ),
            ),

            // Bottom Indicators and Next / Get Started Action
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Smooth Page Indicators
                      Row(
                        children: List.generate(3, (index) {
                          final isActive = index == _currentPage;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 6),
                            width: isActive ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isActive ? AppColors.accent : AppColors.border,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),

                      // Next / Get Started Button
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _currentPage == 2
                                    ? appState.t('getStarted')
                                    : appState.t('next'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _currentPage == 2
                                    ? Icons.check_circle_rounded
                                    : Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Sister concern branding footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.corporate_fare_rounded,
                        size: 12,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        appState.t('companySisterConcern'),
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLangTab(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSlide({
    required String imagePath,
    required String title,
    required String subtitle,
    Widget? customContent,
  }) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 10),
          // High-res Image Illustration Container
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.25,
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 8),

          // Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),

          if (customContent != null) ...[
            const SizedBox(height: 16),
            customContent,
          ],
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(AppStateProvider appState) {
    final isBn = appState.isBengali;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.language_rounded, size: 16, color: AppColors.accent),
              const SizedBox(width: 6),
              Text(
                appState.t('selectLanguage'),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildLangCard(
                  flag: '🇺🇸',
                  title: 'English',
                  subtitle: 'International',
                  isSelected: !isBn,
                  onTap: () => appState.setLanguage('English'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildLangCard(
                  flag: '🇧🇩',
                  title: 'বাংলা',
                  subtitle: 'বাংলাদেশ ও ওমান',
                  isSelected: isBn,
                  onTap: () => appState.setLanguage('বাংলা'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLangCard({
    required String flag,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent.withValues(alpha: 0.08)
              : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.border,
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? AppColors.accent : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.accent),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturePills(List<String> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        );
      }).toList(),
    );
  }
}
