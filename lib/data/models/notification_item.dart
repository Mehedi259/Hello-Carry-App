import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

enum NotificationType {
  transit,
  order,
  product,
  delivery,
  quote;

  IconData get icon {
    switch (this) {
      case NotificationType.transit:
        return Icons.local_shipping_rounded;
      case NotificationType.order:
        return Icons.check_circle_rounded;
      case NotificationType.product:
        return Icons.stars_rounded;
      case NotificationType.delivery:
        return Icons.task_alt_rounded;
      case NotificationType.quote:
        return Icons.request_quote_rounded;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.transit:
        return AppColors.accent;
      case NotificationType.order:
        return AppColors.success;
      case NotificationType.product:
        return AppColors.warning;
      case NotificationType.delivery:
        return AppColors.bdGreen;
      case NotificationType.quote:
        return AppColors.accentCyan;
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String timestamp;
  final NotificationType type;
  bool isRead;
  final String? relatedShipmentId;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.relatedShipmentId,
  });
}
