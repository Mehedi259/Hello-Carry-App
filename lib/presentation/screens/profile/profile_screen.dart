import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../providers/app_state_provider.dart';
import '../../../data/mock/mock_data.dart';


class ProfileScreen extends StatelessWidget {
  final Function(int)? onNavigate;

  const ProfileScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final user = MockData.user;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile edit mode enabled')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            // Avatar & Name Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.surfaceSubtle,
                        backgroundImage: AssetImage(user.avatarPath),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.phone,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),

                  const SizedBox(height: 18),
                  const Divider(color: AppColors.borderLight, height: 1),
                  const SizedBox(height: 14),

                  // Stats row: 5 Total | 2 In Transit | 3 Delivered
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('${user.totalShipments}', 'Total Shipments', AppColors.accent),
                      _buildVerticalDivider(),
                      _buildStatColumn('${user.inTransitCount}', 'In Transit', AppColors.warning),
                      _buildVerticalDivider(),
                      _buildStatColumn('${user.deliveredCount}', 'Delivered', AppColors.success),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Profile Options Menu
            Material(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildProfileTile(
                    icon: Icons.person_outline_rounded,
                    title: 'Personal Information',
                    subtitle: 'Full name, phone, NID & passport',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.location_on_outlined,
                    title: 'Shipping Addresses',
                    subtitle: 'Saved delivery points in BD & Oman',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.credit_card_rounded,
                    title: 'Payment Methods',
                    subtitle: 'Cards, bKash, Bank Muscat, Thawani',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.currency_exchange_rounded,
                    title: 'Currency Preference',
                    subtitle: 'Current: ${appState.selectedCurrency}',
                    trailingWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: ['USD', 'OMR', 'BDT'].map((curr) {
                        final isSel = curr == appState.selectedCurrency;
                        return GestureDetector(
                          onTap: () => appState.setCurrency(curr),
                          child: Container(
                            margin: const EdgeInsets.only(left: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: isSel ? AppColors.accent : AppColors.surfaceSubtle,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              curr,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: isSel ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.headset_mic_outlined,
                    title: 'Help & Support',
                    subtitle: 'FAQs, chat, and hotline',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Helpline: +968 9123-4567 / support@hellocarry.com')),
                      );
                    },
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.description_outlined,
                    title: 'Terms & Conditions',
                    subtitle: 'Cargo policy, insurance guidelines',
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.logout_rounded,
                    title: 'Log Out',
                    subtitle: 'Sign out of current device session',
                    iconColor: AppColors.error,
                    textColor: AppColors.error,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Session safe. Logged in as Mehedi Hasan Mridul')),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Company branding footer
            Column(
              children: [
                Text(
                  AppStrings.companySisterConcern,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  AppStrings.developedBy,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'v1.0.0 • Hello Carry Cargo Enterprise',
                  style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 30,
      color: AppColors.borderLight,
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? iconColor,
    Color? textColor,
    Widget? trailingWidget,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor ?? AppColors.textPrimary, size: 22),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: textColor ?? AppColors.textPrimary,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
              )
            : null,
        trailing: trailingWidget ??
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
      ),
    );
  }
}
