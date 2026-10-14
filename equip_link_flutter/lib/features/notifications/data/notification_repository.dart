import 'models/notification_item.dart';

abstract class NotificationRepository {
  Future<List<NotificationItem>> getNotifications({
    NotificationCategory? category,
  });
  Future<int> getUnreadCount();
  Future<bool> markAsRead(String id);
  Future<bool> markAllAsRead();
}
