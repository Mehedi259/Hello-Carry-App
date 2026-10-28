import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import '../../../providers/shipment_provider.dart';

import '../../../providers/sourcing_provider.dart';
import '../../../providers/notification_provider.dart';
import '../../widgets/section_header.dart';
import 'widgets/hero_banner_widget.dart';
import 'widgets/quick_tracker_card.dart';
import 'widgets/quick_actions_grid.dart';
import 'widgets/active_shipment_card.dart';
import '../sourcing/widgets/product_card.dart';
import '../sourcing/product_details_screen.dart';
import '../tracking/shipment_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final shipmentProvider = context.watch<ShipmentProvider>();
    final sourcingProvider = context.watch<SourcingProvider>();
    final notificationProvider = context.watch<NotificationProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 16,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primary, size: 26),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(AppAssets.appLogo, fit: BoxFit.cover),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  AppStrings.appTagline,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Notification Bell
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
                onPressed: () => onNavigate(6), // Notifications screen
              ),
              if (notificationProvider.unreadCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.omanRed,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    alignment: Alignment.center,
                    child: Text(
                      '${notificationProvider.unreadCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // User Profile Avatar
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 4),
            child: GestureDetector(
              onTap: () => onNavigate(4), // Profile screen
              child: CircleAvatar(
                radius: 17,
                backgroundColor: AppColors.surfaceSubtle,
                backgroundImage: const AssetImage(AppAssets.userAvatar),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Banner
            const HeroBannerWidget(),

            const SizedBox(height: 16),

            // 2. Quick Tracker Card
            const QuickTrackerCard(),

            const SizedBox(height: 18),

            // 3. Quick Actions Grid
            QuickActionsGrid(onActionTap: onNavigate),

            const SizedBox(height: 22),

            // 4. Live Active Shipment
            SectionHeader(
              title: 'Active Shipment',
              subtitle: 'Real-time status of your cargo',
              actionText: 'View All',
              onActionTap: () => onNavigate(3), // Shipments tab
            ),

            const SizedBox(height: 12),

            ActiveShipmentCard(
              shipment: shipmentProvider.activeShipment,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShipmentDetailsScreen(
                      shipment: shipmentProvider.activeShipment,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // 5. Sourcing Products Section
            SectionHeader(
              title: 'Sourcing Products',
              subtitle: 'Explore popular products you can source & ship',
              actionText: 'View All',
              onActionTap: () => onNavigate(2), // Sourcing tab
            ),

            const SizedBox(height: 14),

            // Horizontal / Grid Sourcing preview
            SizedBox(
              height: 235,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: sourcingProvider.allProducts.length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final product = sourcingProvider.allProducts[index];
                  return SizedBox(
                    width: 175,
                    child: ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // 6. Why Choose Hello Carry Guarantee Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0A2342), Color(0xFF133660)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.verified_user_rounded,
                          color: AppColors.accentCyan,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello Carry Security Guarantee',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '100% cargo insurance & full customs clearance support',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTrustPoint(Icons.airplanemode_active_rounded, 'Air: 3-5 Days'),
                      _buildTrustPoint(Icons.directions_boat_rounded, 'Sea: Low Cost'),
                      _buildTrustPoint(Icons.door_front_door_rounded, 'Door Delivery'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustPoint(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentCyan, size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
