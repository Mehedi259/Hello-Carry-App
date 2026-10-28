import 'package:flutter/material.dart';
import '../data/models/notification_item.dart';
import '../data/mock/mock_data.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationItem> _notifications = List.from(MockData.notifications);

  List<NotificationItem> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final item = _notifications.firstWhere(
      (n) => n.id == id,
      orElse: () => _notifications.first,
    );
    item.isRead = true;
    notifyListeners();
  }

  void markAllAsRead() {
    for (var n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }
}
