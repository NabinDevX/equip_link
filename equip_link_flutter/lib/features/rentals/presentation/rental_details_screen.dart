import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../data/serverpod_rental_repository.dart';
import '../data/models/rental_request.dart';

class RentalDetailsScreen extends ConsumerStatefulWidget {
  final String rentalId;

  const RentalDetailsScreen({super.key, required this.rentalId});

  @override
  ConsumerState<RentalDetailsScreen> createState() =>
      _RentalDetailsScreenState();
}

class _RentalDetailsScreenState extends ConsumerState<RentalDetailsScreen> {
  final Map<String, bool> _localAccessories = {};

  void _showExtensionDialog(RentalRequest item) {
    DateTime selectedDate = item.endDate.add(const Duration(days: 2));

    showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Request Rental Extension'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Return: ${item.endDate.month}/${item.endDate.day}/${item.endDate.year}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text('Select New Return Date:'),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.event),
                    label: Text(
                      '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}',
                    ),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: item.endDate.add(const Duration(days: 1)),
                        lastDate: item.endDate.add(const Duration(days: 14)),
                      );
                      if (picked != null) {
                        setDialogState(() => selectedDate = picked);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Additional days will be calculated at the standard daily rate.',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final repo = ref.read(rentalRepositoryProvider);
                    await repo.requestExtension(item.id, selectedDate);
                    ref.invalidate(rentalDetailsProvider(item.id));
                    ref.invalidate(borrowerRentalsProvider);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Extension request sent to lender!'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  },
                  child: const Text('Submit Request'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _initiateLockerReturn(RentalRequest item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Icon(
                Icons.lock_open_rounded,
                size: 48,
                color: AppColors.secondary,
              ),
              const SizedBox(height: 14),
              const Text(
                'Ready for Smart Locker Deposit',
                style: AppTypography.headlineMD,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Head to ${item.campusLocation}. Enter PIN ${item.lockerPin ?? "8492"} to open the door, place all verified items inside, and shut the door.',
                style: AppTypography.bodyMD.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Confirm Return Deposit',
                onPressed: () async {
                  final repo = ref.read(rentalRepositoryProvider);
                  await repo.updateRentalStatus(
                    item.id,
                    RentalStatus.completed,
                  );
                  ref.invalidate(rentalDetailsProvider(item.id));
                  ref.invalidate(borrowerRentalsProvider);
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Locker return verified! Rental marked completed.',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final rentalAsync = ref.watch(rentalDetailsProvider(widget.rentalId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Rental #${widget.rentalId}',
          style: AppTypography.headlineSM.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: rentalAsync.when(
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Rental record not found'));
          }

          if (_localAccessories.isEmpty &&
              item.accessoriesChecklist.isNotEmpty) {
            _localAccessories.addAll(item.accessoriesChecklist);
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 4-Step Lifecycle Timeline Tracker
                      _buildTimelineTracker(item.status),
                      const SizedBox(height: 20),

                      // Equipment Overview Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.equipmentImageUrl,
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  width: 72,
                                  height: 72,
                                  color: AppColors.surfaceContainer,
                                  child: const Icon(Icons.hardware_rounded),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.equipmentName,
                                    style: AppTypography.labelLG,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.startDate.month}/${item.startDate.day} – ${item.endDate.month}/${item.endDate.day} (${item.rentalDays} days)',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Total: \$${item.totalAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Smart Locker Digital Pass Card
                      if (item.handoffMethod == HandoffMethod.smartLocker &&
                          item.lockerPin != null) ...[
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0F2B3E), Color(0xFF143F5B)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.lock_rounded,
                                        color: AppColors.secondaryLight,
                                        size: 18,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Campus Smart Locker Pass',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '24/7 Access',
                                    style: TextStyle(
                                      color: AppColors.secondaryLight,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item.campusLocation,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'LOCKER KEYPAD PIN',
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 10,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.lockerPin!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 4.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.copy_rounded,
                                        color: AppColors.secondaryLight,
                                      ),
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(text: item.lockerPin!),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Locker PIN copied to clipboard!',
                                            ),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Pre-Return Accessories Checklist
                      if (_localAccessories.isNotEmpty) ...[
                        const Text(
                          'Pre-Return Accessories Checklist',
                          style: AppTypography.headlineSM,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Verify that every included component is packed before locking the door.',
                          style: AppTypography.bodySM.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.outlineVariant),
                          ),
                          child: Column(
                            children: _localAccessories.entries.map((entry) {
                              return CheckboxListTile(
                                value: entry.value,
                                activeColor: AppColors.secondary,
                                title: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontSize: 13,
                                    decoration: entry.value
                                        ? TextDecoration.none
                                        : null,
                                  ),
                                ),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _localAccessories[entry.key] = val;
                                    });
                                    final repo = ref.read(
                                      rentalRepositoryProvider,
                                    );
                                    repo.toggleAccessoryCheck(
                                      item.id,
                                      entry.key,
                                      val,
                                    );
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Lender / Borrower Profile Card
                      const Text(
                        'Campus Partner',
                        style: AppTypography.headlineSM,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.secondary.withValues(
                                alpha: 0.15,
                              ),
                              child: Text(
                                item.lenderName.isNotEmpty
                                    ? item.lenderName[0]
                                    : 'L',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.lenderName,
                                    style: AppTypography.labelLG,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.lenderUniversity,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(70, 36),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Chat messages available in notification centre.',
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: const Text('Chat'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Status-Specific Actions Bar
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: _buildActionButtons(item),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildTimelineTracker(RentalStatus status) {
    final steps = ['Requested', 'Approved', 'Handover', 'Return'];
    int activeStep = 0;
    if (status == RentalStatus.approved) activeStep = 1;
    if (status == RentalStatus.active) activeStep = 2;
    if (status == RentalStatus.returnDue || status == RentalStatus.completed) {
      activeStep = 3;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final isPast = index <= activeStep;
          final isCurrent = index == activeStep;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPast
                              ? AppColors.secondary
                              : AppColors.surfaceContainer,
                          border: isCurrent
                              ? Border.all(color: AppColors.primary, width: 2)
                              : null,
                        ),
                        child: Center(
                          child: Icon(
                            isPast ? Icons.check : Icons.circle,
                            size: 14,
                            color: isPast
                                ? Colors.white
                                : AppColors.textTertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        steps[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isCurrent
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isCurrent
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < steps.length - 1)
                  Container(
                    width: 14,
                    height: 2,
                    color: index < activeStep
                        ? AppColors.secondary
                        : AppColors.outlineVariant,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildActionButtons(RentalRequest item) {
    if (item.status == RentalStatus.active ||
        item.status == RentalStatus.returnDue) {
      return Row(
        children: [
          Expanded(
            child: SecondaryButton(
              label: 'Request Extension',
              onPressed: () => _showExtensionDialog(item),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PrimaryButton(
              label: 'Initiate Return →',
              onPressed: () => _initiateLockerReturn(item),
            ),
          ),
        ],
      );
    } else if (item.status == RentalStatus.pending) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final repo = ref.read(rentalRepositoryProvider);
                await repo.updateRentalStatus(item.id, RentalStatus.cancelled);
                ref.invalidate(rentalDetailsProvider(item.id));
                ref.invalidate(borrowerRentalsProvider);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rental request cancelled')),
                  );
                }
              },
              child: const Text('Cancel Request'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final repo = ref.read(rentalRepositoryProvider);
                await repo.updateRentalStatus(item.id, RentalStatus.active);
                ref.invalidate(rentalDetailsProvider(item.id));
                ref.invalidate(borrowerRentalsProvider);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rental approved & activated!'),
                    ),
                  );
                }
              },
              child: const Text('Simulate Approval'),
            ),
          ),
        ],
      );
    } else if (item.status == RentalStatus.completed) {
      return PrimaryButton(
        label: 'Leave Equipment Review ★',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Review modal will be available in Phase 8!'),
              duration: Duration(seconds: 1),
            ),
          );
        },
      );
    }

    return PrimaryButton(
      label: 'Back to Activity',
      onPressed: () => context.go('/rentals'),
    );
  }
}
