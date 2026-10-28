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
        title: Text(
          appState.t('profile'),
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
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

                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn('${user.totalShipments}', appState.t('totalShipments'), AppColors.accent),
                      _buildVerticalDivider(),
                      _buildStatColumn('${user.inTransitCount}', appState.t('inTransit'), AppColors.warning),
                      _buildVerticalDivider(),
                      _buildStatColumn('${user.deliveredCount}', appState.t('delivered'), AppColors.success),
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
                  // Language Selection Tile
                  _buildProfileTile(
                    icon: Icons.language_rounded,
                    title: appState.t('language'),
                    subtitle: appState.selectedLanguage,
                    trailingWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLangChoice('English', !appState.isBengali, () => appState.setLanguage('English')),
                        const SizedBox(width: 6),
                        _buildLangChoice('বাংলা', appState.isBengali, () => appState.setLanguage('বাংলা')),
                      ],
                    ),
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),

                  // Currency Preference
                  _buildProfileTile(
                    icon: Icons.currency_exchange_rounded,
                    title: appState.t('currencyPreference'),
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
                    icon: Icons.person_outline_rounded,
                    title: appState.t('personalInfo'),
                    subtitle: appState.t('personalInfoSub'),
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.location_on_outlined,
                    title: appState.t('shippingAddresses'),
                    subtitle: appState.t('shippingAddressesSub'),
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.credit_card_rounded,
                    title: appState.t('paymentMethods'),
                    subtitle: appState.t('paymentMethodsSub'),
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.restart_alt_rounded,
                    title: 'Onboarding Intro',
                    subtitle: 'View introduction slides again',
                    onTap: () => appState.resetOnboarding(),
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.headset_mic_outlined,
                    title: appState.t('helpSupport'),
                    subtitle: appState.t('helpSupportSub'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Helpline: +968 9123-4567 / support@hellocarry.com')),
                      );
                    },
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.description_outlined,
                    title: appState.t('termsConditions'),
                    subtitle: appState.t('termsConditionsSub'),
                    onTap: () {},
                  ),
                  const Divider(color: AppColors.borderLight, height: 1),
                  _buildProfileTile(
                    icon: Icons.logout_rounded,
                    title: appState.t('logOut'),
                    subtitle: appState.t('logOutSub'),
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
                  appState.t('companySisterConcern'),
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

  Widget _buildLangChoice(String name, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.surfaceSubtle,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
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
