import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../data/mock_notification_repository.dart';
import '../data/models/notification_item.dart';

class NotificationCentreScreen extends ConsumerStatefulWidget {
  const NotificationCentreScreen({super.key});

  @override
  ConsumerState<NotificationCentreScreen> createState() =>
      _NotificationCentreScreenState();
}

class _NotificationCentreScreenState
    extends ConsumerState<NotificationCentreScreen> {
  NotificationCategory _selectedCategory = NotificationCategory.all;

  String _formatTimestamp(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }

  IconData _getIconForCategory(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.requests:
        return Icons.sync_alt_rounded;
      case NotificationCategory.returns:
        return Icons.schedule_rounded;
      case NotificationCategory.system:
        return Icons.verified_user_rounded;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _getColorForCategory(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.requests:
        return AppColors.primary;
      case NotificationCategory.returns:
        return AppColors.warning;
      case NotificationCategory.system:
        return AppColors.secondary;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        title: Text(
          'Notification Centre',
          style: AppTypography.headlineSM.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final repo = ref.read(notificationRepositoryProvider);
              await repo.markAllAsRead();
              ref.invalidate(notificationsProvider);
              ref.invalidate(unreadNotificationsCountProvider);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications marked as read'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: Text(
              'Mark all read',
              style: AppTypography.labelMD.copyWith(color: AppColors.secondary),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Category Filter Pills
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: AppColors.surface,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildFilterChip('All', NotificationCategory.all),
                  const SizedBox(width: 8),
                  _buildFilterChip('Requests', NotificationCategory.requests),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'Returns & Alerts',
                    NotificationCategory.returns,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'System & Trust',
                    NotificationCategory.system,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.outlineVariant),

            // Notifications List
            Expanded(
              child: notificationsAsync.when(
                data: (items) {
                  final filtered = _selectedCategory == NotificationCategory.all
                      ? items
                      : items
                            .where((n) => n.category == _selectedCategory)
                            .toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 52,
                            color: AppColors.textTertiary.withValues(
                              alpha: 0.6,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'No notifications found',
                            style: AppTypography.headlineSM,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'You are all caught up with your campus gear activity!',
                            style: AppTypography.bodyMD.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _buildNotificationCard(item);
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (err, _) =>
                    Center(child: Text('Error loading notifications: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, NotificationCategory cat) {
    final isSelected = _selectedCategory == cat;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.secondaryContainer,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.secondary : AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      onSelected: (_) => setState(() => _selectedCategory = cat),
    );
  }

  Widget _buildNotificationCard(NotificationItem item) {
    final iconColor = _getColorForCategory(item.category);

    return InkWell(
      onTap: () async {
        final repo = ref.read(notificationRepositoryProvider);
        await repo.markAsRead(item.id);
        ref.invalidate(notificationsProvider);
        ref.invalidate(unreadNotificationsCountProvider);

        if (item.relatedRentalId != null && mounted) {
          context.push('/rentals/${item.relatedRentalId}');
        }
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: item.isRead
              ? AppColors.surface
              : AppColors.secondaryContainer.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: item.isRead
                ? AppColors.outlineVariant
                : AppColors.secondary.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForCategory(item.category),
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                item.title,
                                style: AppTypography.labelLG.copyWith(
                                  fontWeight: item.isRead
                                      ? FontWeight.w600
                                      : FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (!item.isRead) ...[
                              const SizedBox(width: 6),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: AppColors.secondary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Text(
                        _formatTimestamp(item.timestamp),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.message,
                    style: AppTypography.bodyMD.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  if (item.relatedRentalId != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'View Rental #${item.relatedRentalId} →',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: iconColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
