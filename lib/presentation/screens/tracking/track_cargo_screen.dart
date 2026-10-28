import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../providers/app_state_provider.dart';
import '../../../providers/shipment_provider.dart';
import '../../widgets/status_badge.dart';
import 'shipment_details_screen.dart';

class TrackCargoScreen extends StatefulWidget {
  final Function(int)? onNavigate;

  const TrackCargoScreen({super.key, this.onNavigate});

  @override
  State<TrackCargoScreen> createState() => _TrackCargoScreenState();
}

class _TrackCargoScreenState extends State<TrackCargoScreen> {
  final TextEditingController _trackingController =
      TextEditingController(text: '#HC123456');

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }

  void _search() async {
    final query = _trackingController.text.trim();
    if (query.isEmpty) return;

    final provider = context.read<ShipmentProvider>();
    await provider.trackCargo(query);
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final provider = context.watch<ShipmentProvider>();
    final tracked = provider.trackedShipment;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          appState.t('trackCargo'),
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Barcode & QR Scanner activated')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route Graphic Map
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        AppAssets.trackingRouteMap,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.radar_rounded, color: AppColors.accentCyan, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              appState.t('liveHubRadar'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tracking Input Box
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appState.t('trackingNumber'),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _trackingController,
                    decoration: InputDecoration(
                      hintText: appState.t('trackingInputHint'),
                      suffixIcon: const Icon(Icons.info_outline_rounded, size: 18),
                    ),
                    onSubmitted: (_) => _search(),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: provider.isTrackingLoading ? null : _search,
                      child: provider.isTrackingLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              appState.t('trackNow'),
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                    ),
                  ),
                ],
              ),
            ),

            // Tracked Result Card (if any found)
            if (tracked != null) ...[
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.08),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tracked.id,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        StatusBadge(status: tracked.status),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tracked.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.flight_takeoff_rounded, size: 16, color: AppColors.accent),
                        const SizedBox(width: 6),
                        Text(
                          '${tracked.originCity} (${tracked.originCode}) → ${tracked.destinationCity} (${tracked.destinationCode})',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Latest: ${tracked.latestUpdate}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.timeline_rounded, size: 16),
                        label: Text(appState.t('viewFullTimeline')),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ShipmentDetailsScreen(shipment: tracked),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // How It Works Steps
            Text(
              appState.t('howItWorks'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                _buildStep(
                  step: '1',
                  icon: Icons.edit_note_rounded,
                  title: appState.t('step1'),
                ),
                _buildStepDivider(),
                _buildStep(
                  step: '2',
                  icon: Icons.checklist_rtl_rounded,
                  title: appState.t('step2'),
                ),
                _buildStepDivider(),
                _buildStep(
                  step: '3',
                  icon: Icons.track_changes_rounded,
                  title: appState.t('step3'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Safe Hands Trust Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield_rounded,
                      color: AppColors.success,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appState.t('safeHands'),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF166534),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          appState.t('safeHandsSub'),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF15803D),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildStep({
    required String step,
    required IconData icon,
    required String title,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: AppColors.accent, size: 22),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDivider() {
    return Container(
      width: 24,
      height: 2,
      margin: const EdgeInsets.only(bottom: 24),
      color: AppColors.border,
    );
  }
}
