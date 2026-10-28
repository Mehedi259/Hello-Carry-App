import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/app_state_provider.dart';
import '../../../providers/shipment_provider.dart';
import '../tracking/shipment_details_screen.dart';
import 'widgets/shipment_list_tile.dart';

class MyShipmentsScreen extends StatefulWidget {
  final Function(int)? onNavigate;

  const MyShipmentsScreen({super.key, this.onNavigate});

  @override
  State<MyShipmentsScreen> createState() => _MyShipmentsScreenState();
}

class _MyShipmentsScreenState extends State<MyShipmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'In Transit', 'Delivered', 'Processing', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        context.read<ShipmentProvider>().setStatusFilter(_tabs[_tabController.index]);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getTabLabel(String key, AppStateProvider appState) {
    if (key == 'All') return appState.isBengali ? 'সকল' : 'All';
    if (key == 'In Transit') return appState.t('inTransit');
    if (key == 'Delivered') return appState.t('delivered');
    if (key == 'Processing') return appState.t('processing');
    if (key == 'Cancelled') return appState.t('cancelled');
    return key;
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final shipmentProvider = context.watch<ShipmentProvider>();
    final shipments = shipmentProvider.filteredShipments;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          appState.t('myShipments'),
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            height: 44,
            margin: const EdgeInsets.only(bottom: 8),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              dividerColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: _tabs.map((tab) => Tab(text: _getTabLabel(tab, appState))).toList(),
            ),
          ),
        ),
      ),
      body: shipments.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    size: 52,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    appState.t('noShipments'),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    appState.t('noShipmentsSub'),
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: shipments.length,
              itemBuilder: (context, index) {
                final shipment = shipments[index];
                return ShipmentListTile(
                  shipment: shipment,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ShipmentDetailsScreen(shipment: shipment),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
