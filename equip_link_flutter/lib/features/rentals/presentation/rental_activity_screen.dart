import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../data/serverpod_rental_repository.dart';
import '../data/models/rental_request.dart';

class RentalActivityScreen extends ConsumerStatefulWidget {
  const RentalActivityScreen({super.key});

  @override
  ConsumerState<RentalActivityScreen> createState() =>
      _RentalActivityScreenState();
}

class _RentalActivityScreenState extends ConsumerState<RentalActivityScreen> {
  int _selectedTabIndex = 0; // 0 = Borrowing, 1 = Lending
  String _selectedStatusFilter = 'All';

  final List<String> _statusFilters = [
    'All',
    'Active',
    'Pending',
    'Completed',
    'Cancelled',
  ];

  List<RentalRequest> _applyStatusFilter(List<RentalRequest> items) {
    if (_selectedStatusFilter == 'All') return items;
    return items.where((item) {
      switch (_selectedStatusFilter) {
        case 'Active':
          return item.status == RentalStatus.active ||
              item.status == RentalStatus.returnDue;
        case 'Pending':
          return item.status == RentalStatus.pending ||
              item.status == RentalStatus.approved;
        case 'Completed':
          return item.status == RentalStatus.completed;
        case 'Cancelled':
          return item.status == RentalStatus.cancelled ||
              item.status == RentalStatus.rejected;
        default:
          return true;
      }
    }).toList();
  }

  Color _getStatusColor(RentalStatus status) {
    switch (status) {
      case RentalStatus.active:
      case RentalStatus.completed:
        return AppColors.success;
      case RentalStatus.pending:
      case RentalStatus.approved:
        return AppColors.warning;
      case RentalStatus.returnDue:
        return AppColors.lockerAccent;
      case RentalStatus.cancelled:
      case RentalStatus.rejected:
        return AppColors.error;
    }
  }

  String _getStatusLabel(RentalStatus status) {
    switch (status) {
      case RentalStatus.pending:
        return 'Pending Review';
      case RentalStatus.approved:
        return 'Ready for Handover';
      case RentalStatus.active:
        return 'Active Loan';
      case RentalStatus.returnDue:
        return 'Return Due Today';
      case RentalStatus.completed:
        return 'Completed';
      case RentalStatus.cancelled:
        return 'Cancelled';
      case RentalStatus.rejected:
        return 'Declined';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBorrowing = _selectedTabIndex == 0;
    final rentalsAsync = ref.watch(
      isBorrowing ? borrowerRentalsProvider : lenderRentalsProvider,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Rental Activity',
          style: AppTypography.headlineSM.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Segmented Tab Selector (Borrowing vs Lending)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: AppColors.surface,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTabIndex = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 0
                                ? AppColors.surface
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: _selectedTabIndex == 0
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Borrowing',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: _selectedTabIndex == 0
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTabIndex = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedTabIndex == 1
                                ? AppColors.surface
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: _selectedTabIndex == 1
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Lending',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: _selectedTabIndex == 1
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Horizontal Status Filter Chips
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: AppColors.surface,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _statusFilters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final s = _statusFilters[index];
                  final isSelected = _selectedStatusFilter == s;
                  return ChoiceChip(
                    label: Text(s),
                    selected: isSelected,
                    selectedColor: AppColors.secondaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.secondary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    onSelected: (_) =>
                        setState(() => _selectedStatusFilter = s),
                  );
                },
              ),
            ),
            const Divider(height: 1, color: AppColors.outlineVariant),

            // Rental Request Cards List
            Expanded(
              child: rentalsAsync.when(
                data: (items) {
                  final filtered = _applyStatusFilter(items);

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 52,
                            color: AppColors.textTertiary.withValues(
                              alpha: 0.6,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isBorrowing
                                ? 'No borrowed equipment'
                                : 'No active lending requests',
                            style: AppTypography.headlineSM,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isBorrowing
                                ? 'Find gear across campus and start borrowing!'
                                : 'List your unused equipment to earn.',
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
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _buildRentalCard(item, isBorrowing);
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (err, _) =>
                    Center(child: Text('Error loading rentals: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentalCard(RentalRequest item, bool isBorrowing) {
    final statusColor = _getStatusColor(item.status);
    final statusLabel = _getStatusLabel(item.status);

    return InkWell(
      onTap: () => context.push('/rentals/${item.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: ID pill + Status pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: Text(
                    '#${item.id}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        statusLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Item Thumbnail + Title + Counterparty
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.equipmentImageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 64,
                      height: 64,
                      color: AppColors.surfaceContainer,
                      child: const Icon(Icons.hardware_rounded),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.equipmentName,
                        style: AppTypography.labelLG,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isBorrowing
                            ? 'Lender: ${item.lenderName}'
                            : 'Borrower: ${item.borrowerName}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total: \$${item.totalAmount.toStringAsFixed(2)} (${item.rentalDays} days)',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // If active loan, display loan progress timeline bar
            if (item.status == RentalStatus.active) ...[
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  value: 0.5,
                  minHeight: 6,
                  backgroundColor: AppColors.surfaceContainer,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pickup: ${item.startDate.month}/${item.startDate.day}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Text(
                    '2 days left',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  Text(
                    'Return: ${item.endDate.month}/${item.endDate.day}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 14),
            const Divider(height: 1, color: AppColors.outlineVariant),
            const SizedBox(height: 10),

            // Bottom Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      item.handoffMethod == HandoffMethod.smartLocker
                          ? Icons.lock_outline
                          : Icons.handshake_outlined,
                      size: 15,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.handoffMethod == HandoffMethod.smartLocker
                          ? 'Smart Locker 14B'
                          : 'In-person Meetup',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(100, 34),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => context.push('/rentals/${item.id}'),
                  child: const Text(
                    'View Details',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
