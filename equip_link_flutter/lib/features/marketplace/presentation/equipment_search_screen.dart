import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/equipment_card.dart';
import '../../../core/widgets/filter_bottom_sheet.dart';
import '../data/serverpod_equipment_repository.dart';
import '../data/models/equipment_item.dart';

class EquipmentSearchScreen extends ConsumerStatefulWidget {
  const EquipmentSearchScreen({super.key});

  @override
  ConsumerState<EquipmentSearchScreen> createState() =>
      _EquipmentSearchScreenState();
}

class _EquipmentSearchScreenState extends ConsumerState<EquipmentSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  FilterCriteria _criteria = const FilterCriteria();
  String _selectedSort = 'Lowest Price';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilterSheet() {
    FilterBottomSheet.show(
      context,
      initialCriteria: _criteria,
      onApply: (newCriteria) {
        setState(() {
          _criteria = newCriteria;
        });
      },
    );
  }

  List<EquipmentItem> _applyFilters(List<EquipmentItem> items) {
    final query = _searchController.text.trim().toLowerCase();

    return items.where((item) {
      if (query.isNotEmpty) {
        final matchesTitle = item.name.toLowerCase().contains(query);
        final matchesDesc = item.description.toLowerCase().contains(query);
        final matchesCategory = item.category.toLowerCase().contains(query);
        if (!matchesTitle && !matchesDesc && !matchesCategory) {
          return false;
        }
      }

      if (_criteria.categories.isNotEmpty &&
          !_criteria.categories.contains(item.category)) {
        return false;
      }

      if (_criteria.conditions.isNotEmpty &&
          !_criteria.conditions.contains(item.condition)) {
        return false;
      }

      if (item.dailyRate < _criteria.priceRange.start ||
          item.dailyRate > _criteria.priceRange.end) {
        return false;
      }

      if (_criteria.campusHub != null &&
          _criteria.campusHub != 'All Campus Hubs' &&
          !item.campusLocation.contains(_criteria.campusHub!)) {
        return false;
      }

      if (_criteria.availableToday && !item.isAvailable) {
        return false;
      }

      return true;
    }).toList()..sort((a, b) {
      if (_selectedSort == 'Lowest Price') {
        return a.dailyRate.compareTo(b.dailyRate);
      } else if (_selectedSort == 'Highest Price') {
        return b.dailyRate.compareTo(a.dailyRate);
      } else if (_selectedSort == 'Highest Rated') {
        return b.lenderRating.compareTo(a.lenderRating);
      }
      return 0;
    });
  }

  bool get _hasActiveFilters =>
      _criteria.categories.isNotEmpty ||
      _criteria.conditions.isNotEmpty ||
      _criteria.campusHub != null ||
      _criteria.availableToday ||
      _criteria.priceRange.start > 0 ||
      _criteria.priceRange.end < 50;

  @override
  Widget build(BuildContext context) {
    final equipmentAsync = ref.watch(equipmentListProvider);

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
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.outline),
          ),
          child: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search equipment...',
              hintStyle: AppTypography.bodyMD.copyWith(
                color: AppColors.textTertiary,
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 20,
                color: AppColors.textTertiary,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        size: 18,
                        color: AppColors.textTertiary,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.tune_rounded, color: AppColors.primary),
                if (_hasActiveFilters)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: _openFilterSheet,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.surface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  equipmentAsync.maybeWhen(
                    data: (items) {
                      final filtered = _applyFilters(items);
                      return Text(
                        '${filtered.length} equipment found',
                        style: AppTypography.bodySM.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedSort,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      style: AppTypography.bodySM.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedSort = val);
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Lowest Price',
                          child: Text('Lowest Price'),
                        ),
                        DropdownMenuItem(
                          value: 'Highest Price',
                          child: Text('Highest Price'),
                        ),
                        DropdownMenuItem(
                          value: 'Highest Rated',
                          child: Text('Highest Rated'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.outline),
            Expanded(
              child: equipmentAsync.when(
                data: (items) {
                  final filtered = _applyFilters(items);
                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 56,
                            color: AppColors.textTertiary.withValues(
                              alpha: 0.6,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No matching equipment',
                            style: AppTypography.headlineSM.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting keywords or filter parameters',
                            style: AppTypography.bodyMD.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return EquipmentCard(
                        item: item,
                        onTap: () => context.push('/equipment/${item.id}'),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
                error: (err, _) =>
                    Center(child: Text('Error loading search results: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
