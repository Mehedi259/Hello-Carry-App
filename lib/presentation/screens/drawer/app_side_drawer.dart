import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import '../../../providers/app_state_provider.dart';
import '../../../providers/notification_provider.dart';
import '../../../data/mock/mock_data.dart';

class AppSideDrawer extends StatelessWidget {
  final Function(int) onNavigate;

  const AppSideDrawer({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.watch<NotificationProvider>();
    final appState = context.watch<AppStateProvider>();

    return Drawer(
      backgroundColor: AppColors.drawerBg,
      child: SafeArea(
        child: Column(
          children: [
            // Header with Logo, Tagline & Close Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      AppAssets.appLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.appName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          AppStrings.appTagline,
                          style: TextStyle(
                            color: AppColors.accentCyan,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white70,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // User Info Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.drawerCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.drawerBorder,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white24,
                      backgroundImage: AssetImage(MockData.user.avatarPath),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MockData.user.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            MockData.user.email,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),
            const Divider(color: AppColors.drawerBorder, height: 1),

            // Navigation Items List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                children: [
                  _buildDrawerItem(
                    icon: Icons.home_rounded,
                    label: AppStrings.navHome,
                    isSelected: appState.currentNavIndex == 0,
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(0);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.explore_rounded,
                    label: AppStrings.trackCargo,
                    isSelected: appState.currentNavIndex == 1,
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(1);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.inventory_2_rounded,
                    label: AppStrings.sourcingProducts,
                    isSelected: appState.currentNavIndex == 2,
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(2);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.local_shipping_rounded,
                    label: AppStrings.myShipments,
                    isSelected: appState.currentNavIndex == 3,
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(3);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.request_quote_rounded,
                    label: AppStrings.getQuote,
                    isSelected: false,
                    badgeText: 'Instant',
                    badgeColor: AppColors.accentCyan,
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(5); // Get a quote view index
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.notifications_rounded,
                    label: 'Notifications',
                    isSelected: false,
                    badgeText: notificationProvider.unreadCount > 0
                        ? '${notificationProvider.unreadCount}'
                        : null,
                    badgeColor: AppColors.omanRed,
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(6); // Notifications index
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    isSelected: appState.currentNavIndex == 4,
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(4);
                    },
                  ),
                  const Divider(color: AppColors.drawerBorder, height: 16),
                  _buildDrawerItem(
                    icon: Icons.headset_mic_rounded,
                    label: 'Help & 24/7 Support',
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hello Carry 24/7 Helpline: +968 9123-4567 / +880 1712-345678'),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_rounded,
                    label: 'Settings',
                    isSelected: false,
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(4); // Navigate to Profile / Settings
                    },
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.drawerBorder)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.corporate_fare_rounded,
                        size: 14,
                        color: Colors.white54,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.companySisterConcern,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.code_rounded,
                        size: 14,
                        color: AppColors.accentCyan,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.developedBy,
                        style: const TextStyle(
                          color: AppColors.accentCyan,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
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

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    String? badgeText,
    Color? badgeColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.accent.withValues(alpha: 0.25)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: isSelected
            ? Border.all(color: AppColors.accent.withValues(alpha: 0.5), width: 1)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: onTap,
          dense: true,
          leading: Icon(
            icon,
            color: isSelected ? AppColors.accentCyan : Colors.white70,
            size: 20,
          ),
          title: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          trailing: badgeText != null
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor ?? AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badgeText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
              : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );

  }
}
