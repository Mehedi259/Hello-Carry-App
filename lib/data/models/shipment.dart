import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

enum ShipmentStatus {
  inTransit,
  delivered,
  processing,
  pickedUp,
  cancelled;

  String get displayName {
    switch (this) {
      case ShipmentStatus.inTransit:
        return 'In Transit';
      case ShipmentStatus.delivered:
        return 'Delivered';
      case ShipmentStatus.processing:
        return 'Processing';
      case ShipmentStatus.pickedUp:
        return 'Picked Up';
      case ShipmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  String localizedName(bool isBengali) {
    if (!isBengali) return displayName;
    switch (this) {
      case ShipmentStatus.inTransit:
        return 'ট্রানজিটে আছে';
      case ShipmentStatus.delivered:
        return 'ডেলিভার্ড';
      case ShipmentStatus.processing:
        return 'প্রক্রিয়াধীন';
      case ShipmentStatus.pickedUp:
        return 'পিকড আপ';
      case ShipmentStatus.cancelled:
        return 'বাতিল';
    }
  }

  Color get color {
    switch (this) {
      case ShipmentStatus.inTransit:
        return AppColors.accent;
      case ShipmentStatus.delivered:
        return AppColors.success;
      case ShipmentStatus.processing:
        return AppColors.warning;
      case ShipmentStatus.pickedUp:
        return AppColors.info;
      case ShipmentStatus.cancelled:
        return AppColors.error;
    }
  }

  Color get backgroundColor {
    return color.withValues(alpha: 0.12);
  }
}

class TrackingStep {
  final String title;
  final String description;
  final String location;
  final String timestamp;
  final bool isCompleted;
  final bool isCurrent;
  final IconData icon;

  const TrackingStep({
    required this.title,
    required this.description,
    required this.location,
    required this.timestamp,
    required this.isCompleted,
    this.isCurrent = false,
    required this.icon,
  });
}

class Shipment {
  final String id; // e.g. #HC123456
  final String title;
  final String category;
  final double weightKg;
  final String originCity;
  final String originCountry;
  final String originCode;
  final String destinationCity;
  final String destinationCountry;
  final String destinationCode;
  final ShipmentStatus status;
  final String shippingMethod; // e.g. "Air Cargo", "Sea Freight"
  final String createdDate;
  final String eta;
  final String? deliveredDate;
  final String latestUpdate;
  final String latestUpdateTime;
  final String imagePath;
  final String senderName;
  final String senderAddress;
  final String receiverName;
  final String receiverAddress;
  final List<TrackingStep> timeline;

  const Shipment({
    required this.id,
    required this.title,
    required this.category,
    required this.weightKg,
    required this.originCity,
    required this.originCountry,
    required this.originCode,
    required this.destinationCity,
    required this.destinationCountry,
    required this.destinationCode,
    required this.status,
    required this.shippingMethod,
    required this.createdDate,
    required this.eta,
    this.deliveredDate,
    required this.latestUpdate,
    required this.latestUpdateTime,
    required this.imagePath,
    required this.senderName,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverAddress,
    required this.timeline,
  });

  String get routeDisplay => '$originCode → $destinationCode';
  String get categoryWeight => '$category | ${weightKg.toStringAsFixed(1)} kg';
}
