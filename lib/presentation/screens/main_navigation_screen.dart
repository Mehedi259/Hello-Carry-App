import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/app_state_provider.dart';
import '../../providers/notification_provider.dart';
import 'onboarding/onboarding_screen.dart';
import 'home/home_screen.dart';
import 'tracking/track_cargo_screen.dart';
import 'sourcing/sourcing_products_screen.dart';
import 'shipments/my_shipments_screen.dart';
import 'profile/profile_screen.dart';
import 'quote/get_quote_screen.dart';
import 'notifications/notifications_screen.dart';
import 'drawer/app_side_drawer.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final notificationProvider = context.watch<NotificationProvider>();

    // Show onboarding flow if user hasn't completed it
    if (!appState.isOnboarded) {
      return OnboardingScreen(
        onFinished: () => appState.completeOnboarding(),
      );
    }

    final currentIndex = appState.currentNavIndex;

    // Sub-screens list
    final List<Widget> screens = [
      HomeScreen(onNavigate: appState.setNavIndex),
      TrackCargoScreen(onNavigate: appState.setNavIndex),
      SourcingProductsScreen(onNavigate: appState.setNavIndex),
      MyShipmentsScreen(onNavigate: appState.setNavIndex),
      ProfileScreen(onNavigate: appState.setNavIndex),
      const GetQuoteScreen(),
      NotificationsScreen(onNavigate: appState.setNavIndex),
    ];

    // For bottom bar, map index 0..4 directly. If 5 or 6 is active, show the corresponding screen.
    final bottomNavActiveIndex = (currentIndex < 5) ? currentIndex : 0;

    return Scaffold(
      drawer: AppSideDrawer(onNavigate: appState.setNavIndex),
      body: IndexedStack(
        index: currentIndex.clamp(0, screens.length - 1),
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: const Border(top: BorderSide(color: AppColors.border, width: 1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context,
                  index: 0,
                  icon: Icons.home_rounded,
                  label: appState.t('navHome'),
                  isSelected: bottomNavActiveIndex == 0 && currentIndex < 5,
                ),
                _buildNavItem(
                  context,
                  index: 1,
                  icon: Icons.explore_rounded,
                  label: appState.t('navTrack'),
                  isSelected: bottomNavActiveIndex == 1 && currentIndex < 5,
                ),
                _buildNavItem(
                  context,
                  index: 2,
                  icon: Icons.inventory_2_rounded,
                  label: appState.t('navProducts'),
                  isSelected: bottomNavActiveIndex == 2 && currentIndex < 5,
                ),
                _buildNavItem(
                  context,
                  index: 3,
                  icon: Icons.local_shipping_rounded,
                  label: appState.t('navShipments'),
                  isSelected: bottomNavActiveIndex == 3 && currentIndex < 5,
                ),
                _buildNavItem(
                  context,
                  index: 4,
                  icon: Icons.person_rounded,
                  label: appState.t('navProfile'),
                  isSelected: bottomNavActiveIndex == 4 && currentIndex < 5,
                  badgeCount: notificationProvider.unreadCount > 0 ? notificationProvider.unreadCount : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
    int? badgeCount,
  }) {
    final appState = context.read<AppStateProvider>();

    return GestureDetector(
      onTap: () => appState.setNavIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: isSelected ? AppColors.accent : AppColors.textMuted,
                ),
                if (badgeCount != null)
                  Positioned(
                    right: -6,
                    top: -3,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.omanRed,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? AppColors.accent : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
