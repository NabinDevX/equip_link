import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/notification_item.dart';
import 'notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: 'notif-1',
      title: 'New Rental Request Waiting',
      message:
          'Jordan Lee requested to borrow your Sony Alpha a6400 Mirrorless Camera Kit for 3 days.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 35)),
      isRead: false,
      category: NotificationCategory.requests,
      relatedRentalId: 'EQ-9310',
    ),
    NotificationItem(
      id: 'notif-2',
      title: 'Smart Locker Pass Issued',
      message:
          'Locker PIN 8492 is active at Packard EE Bldg Locker 14B for Fluke 117 Multimeter.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      category: NotificationCategory.requests,
      relatedRentalId: 'EQ-8841',
    ),
    NotificationItem(
      id: 'notif-3',
      title: 'Return Due in 24 Hours',
      message:
          'Your active rental for Fluke 117 Multimeter is due tomorrow at 5:00 PM. Verify accessories before deposit.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
      category: NotificationCategory.returns,
      relatedRentalId: 'EQ-8841',
    ),
    NotificationItem(
      id: 'notif-4',
      title: 'Honor Code Trust Rating Updated',
      message:
          'Congratulations! Your successful return of Rigol Oscilloscope earned you a 5.0 ★ rating from Sarah J.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      category: NotificationCategory.system,
      relatedRentalId: 'EQ-7640',
    ),
    NotificationItem(
      id: 'notif-5',
      title: 'Rental Approved',
      message:
          'Chloe Bennett approved your rental request for TI-84 Plus CE Graphing Calculator.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      category: NotificationCategory.requests,
      relatedRentalId: 'EQ-9022',
    ),
  ];

  @override
  Future<List<NotificationItem>> getNotifications({
    NotificationCategory? category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (category == null || category == NotificationCategory.all) {
      return List.unmodifiable(_notifications);
    }
    return _notifications.where((n) => n.category == category).toList();
  }

  @override
  Future<int> getUnreadCount() async {
    return _notifications.where((n) => !n.isRead).length;
  }

  @override
  Future<bool> markAsRead(String id) async {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index >= 0) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      return true;
    }
    return false;
  }

  @override
  Future<bool> markAllAsRead() async {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    return true;
  }
}

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return MockNotificationRepository();
});

final notificationsProvider =
    FutureProvider.autoDispose<List<NotificationItem>>((ref) async {
      final repo = ref.watch(notificationRepositoryProvider);
      return repo.getNotifications();
    });

final unreadNotificationsCountProvider = FutureProvider.autoDispose<int>((
  ref,
) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getUnreadCount();
});
