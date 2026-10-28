import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../providers/app_state_provider.dart';

class QuickActionsGrid extends StatelessWidget {
  final Function(int) onActionTap;

  const QuickActionsGrid({super.key, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionItem(
          icon: Icons.inventory_2_rounded,
          iconColor: const Color(0xFF0284C7),
          bgColor: const Color(0xFFE0F2FE),
          title: appState.t('sourcingTitle'),
          subtitle: appState.t('sourcingSub'),
          onTap: () => onActionTap(2), // Sourcing tab
        ),
        _buildActionItem(
          icon: Icons.local_shipping_rounded,
          iconColor: const Color(0xFF059669),
          bgColor: const Color(0xFFD1FAE5),
          title: appState.t('shipmentsTitle'),
          subtitle: appState.t('shipmentsSub'),
          onTap: () => onActionTap(3), // Shipments tab
        ),
        _buildActionItem(
          icon: Icons.calculate_rounded,
          iconColor: const Color(0xFFD97706),
          bgColor: const Color(0xFFFEF3C7),
          title: appState.t('quoteTitle'),
          subtitle: appState.t('quoteSub'),
          onTap: () => onActionTap(5), // Quote tab/screen
        ),
        _buildActionItem(
          icon: Icons.headset_mic_rounded,
          iconColor: const Color(0xFF7C3AED),
          bgColor: const Color(0xFFEDE9FE),
          title: appState.t('supportTitle'),
          subtitle: appState.t('supportSub'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Hello Carry Helpdesk: Direct WhatsApp & Call Support Active (+968 9123-4567)',
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
