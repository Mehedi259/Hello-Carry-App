import 'package:flutter/material.dart';
import '../data/models/shipment.dart';
import '../data/mock/mock_data.dart';

class ShipmentProvider extends ChangeNotifier {
  final List<Shipment> _shipments = List.from(MockData.shipments);
  String _searchQuery = '';
  String _selectedStatusFilter = 'All'; // 'All', 'In Transit', 'Delivered', 'Processing', 'Cancelled'
  Shipment? _trackedShipment;
  bool _isTrackingLoading = false;
  String? _trackingError;

  List<Shipment> get shipments => _shipments;
  String get searchQuery => _searchQuery;
  String get selectedStatusFilter => _selectedStatusFilter;
  Shipment? get trackedShipment => _trackedShipment;
  bool get isTrackingLoading => _isTrackingLoading;
  String? get trackingError => _trackingError;

  // Active shipment for home widget
  Shipment get activeShipment => _shipments.firstWhere(
        (s) => s.status == ShipmentStatus.inTransit,
        orElse: () => _shipments.first,
      );

  List<Shipment> get filteredShipments {
    return _shipments.where((shipment) {
      final matchesQuery = _searchQuery.isEmpty ||
          shipment.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          shipment.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          shipment.category.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesFilter = _selectedStatusFilter == 'All' ||
          shipment.status.displayName.toLowerCase() ==
              _selectedStatusFilter.toLowerCase();

      return matchesQuery && matchesFilter;
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setStatusFilter(String filter) {
    _selectedStatusFilter = filter;
    notifyListeners();
  }

  Shipment? findById(String id) {
    final cleanId = id.trim().toLowerCase();
    return _shipments.cast<Shipment?>().firstWhere(
          (s) =>
              s!.id.toLowerCase() == cleanId ||
              s.id.toLowerCase().replaceAll('#', '') == cleanId.replaceAll('#', ''),
          orElse: () => null,
        );
  }

  Future<bool> trackCargo(String trackingNumber) async {
    final cleanNumber = trackingNumber.trim();
    if (cleanNumber.isEmpty) {
      _trackingError = 'Please enter a valid tracking number';
      _trackedShipment = null;
      notifyListeners();
      return false;
    }

    _isTrackingLoading = true;
    _trackingError = null;
    notifyListeners();

    // Realistic network simulation delay
    await Future.delayed(const Duration(milliseconds: 600));

    final match = findById(cleanNumber);
    _isTrackingLoading = false;

    if (match != null) {
      _trackedShipment = match;
      _trackingError = null;
      notifyListeners();
      return true;
    } else {
      // Create on-the-fly realistic shipment so user can test ANY tracking number!
      final customShipment = Shipment(
        id: cleanNumber.startsWith('#') ? cleanNumber.toUpperCase() : '#${cleanNumber.toUpperCase()}',
        title: 'Custom Cargo Shipment',
        category: 'General Freight',
        weightKg: 3.5,
        originCity: 'Dhaka',
        originCountry: 'Bangladesh',
        originCode: 'BD',
        destinationCity: 'Muscat',
        destinationCountry: 'Oman',
        destinationCode: 'OM',
        status: ShipmentStatus.inTransit,
        shippingMethod: 'Air Cargo Express',
        createdDate: 'Oct 24, 2026',
        eta: '4 Days',
        latestUpdate: 'Dispatched from Dhaka Cargo Airport to Muscat',
        latestUpdateTime: 'Today • 08:30 AM',
        imagePath: MockData.shipments.first.imagePath,
        senderName: 'Express Logistic Center',
        senderAddress: 'Dhaka, Bangladesh',
        receiverName: 'Valued Customer',
        receiverAddress: 'Muscat, Oman',
        timeline: [
          const TrackingStep(
            title: 'Shipment Created',
            description: 'Order logged into Hello Carry Cargo Grid',
            location: 'Dhaka Hub, Bangladesh',
            timestamp: 'Oct 24, 08:00 AM',
            isCompleted: true,
            icon: Icons.receipt_long_rounded,
          ),
          const TrackingStep(
            title: 'Customs Cleared',
            description: 'International customs check passed',
            location: 'Hazrat Shahjalal Int Airport',
            timestamp: 'Oct 24, 02:00 PM',
            isCompleted: true,
            icon: Icons.verified_user_rounded,
          ),
          const TrackingStep(
            title: 'In Flight Transit',
            description: 'Aircraft departed towards Oman',
            location: 'International Airspace',
            timestamp: 'Today, 08:30 AM',
            isCompleted: true,
            isCurrent: true,
            icon: Icons.flight_takeoff_rounded,
          ),
          const TrackingStep(
            title: 'Arrival at Muscat',
            description: 'Unloading and hub distribution',
            location: 'Muscat Airport (MCT)',
            timestamp: 'Estimated Tomorrow',
            isCompleted: false,
            icon: Icons.flight_land_rounded,
          ),
        ],
      );

      _shipments.insert(0, customShipment);
      _trackedShipment = customShipment;
      _trackingError = null;
      notifyListeners();
      return true;
    }
  }

  void clearTrackedShipment() {
    _trackedShipment = null;
    _trackingError = null;
    notifyListeners();
  }
}
