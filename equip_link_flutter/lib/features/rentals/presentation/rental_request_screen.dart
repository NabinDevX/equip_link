import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../../marketplace/data/serverpod_equipment_repository.dart';
import '../data/serverpod_rental_repository.dart';
import '../data/models/rental_request.dart';

class RentalRequestScreen extends ConsumerStatefulWidget {
  final String equipmentId;

  const RentalRequestScreen({super.key, required this.equipmentId});

  @override
  ConsumerState<RentalRequestScreen> createState() =>
      _RentalRequestScreenState();
}

class _RentalRequestScreenState extends ConsumerState<RentalRequestScreen> {
  late DateTime _startDate;
  late DateTime _endDate;
  HandoffMethod _handoffMethod = HandoffMethod.smartLocker;
  final TextEditingController _noteController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startDate = DateTime(now.year, now.month, now.day + 1);
    _endDate = DateTime(now.year, now.month, now.day + 5);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  int get _rentalDays => _endDate.difference(_startDate).inDays.clamp(1, 60);

  Future<void> _pickDate({required bool isStart}) async {
    final initialDate = isStart ? _startDate : _endDate;
    final firstDate = isStart
        ? DateTime.now()
        : _startDate.add(const Duration(days: 1));
    final lastDate = DateTime.now().add(const Duration(days: 90));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(firstDate) ? firstDate : initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate.add(const Duration(days: 1)))) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _submitRequest(
    double dailyRate,
    String equipmentName,
    String category,
    String imageUrl,
    String location,
    String lenderName,
  ) async {
    setState(() => _isLoading = true);

    try {
      final days = _rentalDays;
      final baseAmount = dailyRate * days;
      final discountAmount = days >= 3 ? (baseAmount * 0.15) : 0.0;
      const serviceFee = 1.50;
      final totalAmount = baseAmount - discountAmount + serviceFee;

      final newRequest = RentalRequest(
        id: 'EQ-${(1000 + DateTime.now().millisecondsSinceEpoch % 8999)}',
        equipmentId: widget.equipmentId,
        equipmentName: equipmentName,
        equipmentCategory: category,
        equipmentImageUrl: imageUrl,
        dailyRate: dailyRate,
        borrowerName: 'Alex Rivera',
        borrowerUniversity: 'Stanford University',
        lenderName: lenderName,
        lenderUniversity: 'Stanford University',
        startDate: _startDate,
        endDate: _endDate,
        handoffMethod: _handoffMethod,
        campusLocation: location,
        lockerPin: _handoffMethod == HandoffMethod.smartLocker ? '8492' : null,
        note: _noteController.text.trim().isNotEmpty
            ? _noteController.text.trim()
            : null,
        baseAmount: baseAmount,
        discountAmount: discountAmount,
        serviceFee: serviceFee,
        totalAmount: totalAmount,
        status: RentalStatus.pending,
        accessoriesChecklist: {
          'Main equipment': true,
          'Power cable / battery': true,
          'Protective case': true,
        },
        createdAt: DateTime.now(),
      );

      final repo = ref.read(rentalRepositoryProvider);
      final created = await repo.createRentalRequest(newRequest);
      ref.invalidate(borrowerRentalsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rental request sent to lender!'),
            backgroundColor: AppColors.success,
          ),
        );
        context.go('/rentals/${created.id}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final equipmentAsync = ref.watch(
      equipmentDetailsProvider(widget.equipmentId),
    );

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
          'Rental Request',
          style: AppTypography.headlineSM.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: equipmentAsync.when(
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Equipment not found'));
          }

          final days = _rentalDays;
          final baseAmount = item.dailyRate * days;
          final discountAmount = days >= 3 ? (baseAmount * 0.15) : 0.0;
          const serviceFee = 1.50;
          final totalAmount = baseAmount - discountAmount + serviceFee;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Equipment & Lender Recap Card
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.imageUrl,
                                width: 68,
                                height: 68,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  width: 68,
                                  height: 68,
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
                                    item.name,
                                    style: AppTypography.labelLG,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'Lender: ${item.lenderName}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '★ ${item.lenderRating}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Rental Period Selection Card
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rental Period',
                            style: AppTypography.headlineSM,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryContainer,
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Text(
                              '$days day${days > 1 ? 's' : ''} loan',
                              style: const TextStyle(
                                color: AppColors.secondary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _pickDate(isStart: true),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.outline),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Pickup Date',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today_outlined,
                                          size: 15,
                                          color: AppColors.secondary,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${_startDate.month}/${_startDate.day}/${_startDate.year}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _pickDate(isStart: false),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.outline),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Return Date',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.event_available_outlined,
                                          size: 15,
                                          color: AppColors.secondary,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${_endDate.month}/${_endDate.day}/${_endDate.year}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Handoff Method Selection
                      const Text(
                        'Handover Preference',
                        style: AppTypography.headlineSM,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => setState(
                                () =>
                                    _handoffMethod = HandoffMethod.smartLocker,
                              ),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _handoffMethod ==
                                              HandoffMethod.smartLocker
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color:
                                          _handoffMethod ==
                                              HandoffMethod.smartLocker
                                          ? AppColors.secondary
                                          : AppColors.textTertiary,
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Campus Smart Locker (Contactless 24/7)',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            item.campusLocation,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: AppColors.outlineVariant,
                            ),
                            InkWell(
                              onTap: () => setState(
                                () => _handoffMethod = HandoffMethod.inPerson,
                              ),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _handoffMethod == HandoffMethod.inPerson
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color:
                                          _handoffMethod ==
                                              HandoffMethod.inPerson
                                          ? AppColors.secondary
                                          : AppColors.textTertiary,
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'In-Person Campus Handover',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Coordinate mutual time & spot via in-app chat',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Note to Lender
                      const Text(
                        'Message for Lender (Optional)',
                        style: AppTypography.headlineSM,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _noteController,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          hintText:
                              'e.g. Need for EE101 lab exam, will treat with great care!',
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Price Breakdown Card
                      const Text(
                        'Price Breakdown',
                        style: AppTypography.headlineSM,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${item.dailyRate.toStringAsFixed(2)} × $days day${days > 1 ? 's' : ''}',
                                  style: AppTypography.bodyMD,
                                ),
                                Text(
                                  '\$${baseAmount.toStringAsFixed(2)}',
                                  style: AppTypography.labelLG,
                                ),
                              ],
                            ),
                            if (discountAmount > 0) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Multi-day Student Discount (15%)',
                                    style: TextStyle(
                                      color: AppColors.success,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '-\$${discountAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Campus Network & Trust Fee',
                                  style: AppTypography.bodyMD,
                                ),
                                Text('\$1.50', style: AppTypography.labelLG),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(
                              height: 1,
                              color: AppColors.outlineVariant,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Amount',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  '\$${totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Deferred Charge Notice
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer.withValues(
                            alpha: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.info_outline,
                              size: 18,
                              color: AppColors.secondary,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'No payment is collected now. Payment is only initiated after the lender confirms and handover occurs.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textSecondary,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sticky Bottom Submission Button
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
                child: PrimaryButton(
                  label: 'Send Rental Request →',
                  isLoading: _isLoading,
                  onPressed: () => _submitRequest(
                    item.dailyRate,
                    item.name,
                    item.category,
                    item.imageUrl,
                    item.campusLocation,
                    item.lenderName,
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (err, _) => Center(child: Text('Error loading item: $err')),
      ),
    );
  }
}
