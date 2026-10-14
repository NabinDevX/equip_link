import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'primary_button.dart';

class FilterCriteria {
  final Set<String> categories;
  final RangeValues priceRange;
  final Set<String> conditions;
  final String? campusHub;
  final bool availableToday;

  const FilterCriteria({
    this.categories = const {},
    this.priceRange = const RangeValues(0, 50),
    this.conditions = const {},
    this.campusHub,
    this.availableToday = false,
  });

  FilterCriteria copyWith({
    Set<String>? categories,
    RangeValues? priceRange,
    Set<String>? conditions,
    String? campusHub,
    bool? availableToday,
  }) {
    return FilterCriteria(
      categories: categories ?? this.categories,
      priceRange: priceRange ?? this.priceRange,
      conditions: conditions ?? this.conditions,
      campusHub: campusHub ?? this.campusHub,
      availableToday: availableToday ?? this.availableToday,
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final FilterCriteria initialCriteria;
  final ValueChanged<FilterCriteria> onApply;

  const FilterBottomSheet({
    super.key,
    required this.initialCriteria,
    required this.onApply,
  });

  static Future<FilterCriteria?> show(
    BuildContext context, {
    required FilterCriteria initialCriteria,
    required ValueChanged<FilterCriteria> onApply,
  }) {
    return showModalBottomSheet<FilterCriteria>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          FilterBottomSheet(initialCriteria: initialCriteria, onApply: onApply),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Set<String> _selectedCategories;
  late RangeValues _priceRange;
  late Set<String> _selectedConditions;
  late String? _selectedCampusHub;
  late bool _availableToday;

  final List<String> _allCategories = [
    'Electronics & STEM',
    'Lab & Science',
    'Calculators',
    'Media & Cameras',
    'Drafting & Architecture',
  ];

  final List<String> _allConditions = ['Like New', 'Excellent', 'Good'];

  @override
  void initState() {
    super.initState();
    _selectedCategories = Set.from(widget.initialCriteria.categories);
    _priceRange = widget.initialCriteria.priceRange;
    _selectedConditions = Set.from(widget.initialCriteria.conditions);
    _selectedCampusHub = widget.initialCriteria.campusHub;
    _availableToday = widget.initialCriteria.availableToday;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filter Equipment', style: AppTypography.headlineMD),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategories.clear();
                      _priceRange = const RangeValues(0, 50);
                      _selectedConditions.clear();
                      _selectedCampusHub = null;
                      _availableToday = false;
                    });
                  },
                  child: Text(
                    'Reset',
                    style: AppTypography.labelMD.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: AppColors.outlineVariant),
            const SizedBox(height: 12),
            const Text('Category', style: AppTypography.labelLG),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _allCategories.map((cat) {
                final selected = _selectedCategories.contains(cat);
                return FilterChip(
                  label: Text(cat),
                  selected: selected,
                  selectedColor: AppColors.secondaryContainer,
                  checkmarkColor: AppColors.secondary,
                  labelStyle: AppTypography.labelMD.copyWith(
                    color: selected
                        ? AppColors.secondary
                        : AppColors.textPrimary,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                    side: BorderSide(
                      color: selected
                          ? AppColors.secondary
                          : AppColors.outlineVariant,
                    ),
                  ),
                  onSelected: (val) {
                    setState(() {
                      if (val) {
                        _selectedCategories.add(cat);
                      } else {
                        _selectedCategories.remove(cat);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Price Range (Daily)', style: AppTypography.labelLG),
                Text(
                  '\$${_priceRange.start.round()} – \$${_priceRange.end.round()}/day',
                  style: AppTypography.labelMD.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 50,
              divisions: 10,
              activeColor: AppColors.secondary,
              inactiveColor: AppColors.surfaceContainer,
              onChanged: (values) {
                setState(() => _priceRange = values);
              },
            ),
            const SizedBox(height: 16),
            const Text('Condition', style: AppTypography.labelLG),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _allConditions.map((cond) {
                final selected = _selectedConditions.contains(cond);
                return ChoiceChip(
                  label: Text(cond),
                  selected: selected,
                  selectedColor: AppColors.successContainer,
                  labelStyle: AppTypography.labelMD.copyWith(
                    color: selected ? AppColors.success : AppColors.textPrimary,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: selected
                          ? AppColors.success
                          : AppColors.outlineVariant,
                    ),
                  ),
                  onSelected: (val) {
                    setState(() {
                      if (val) {
                        _selectedConditions.add(cond);
                      } else {
                        _selectedConditions.remove(cond);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Campus Pickup Location', style: AppTypography.labelLG),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _selectedCampusHub,
              decoration: const InputDecoration(
                hintText: 'Enter campus pickup location',
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.secondary,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedCampusHub = value.trim().isEmpty ? null : value;
                });
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Available Immediately Today',
                style: AppTypography.labelMD,
              ),
              subtitle: const Text(
                'Pick up from smart locker or in-person today',
                style: AppTypography.bodySM,
              ),
              value: _availableToday,
              activeThumbColor: AppColors.secondary,
              onChanged: (val) => setState(() => _availableToday = val),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Apply Filters',
              onPressed: () {
                final result = FilterCriteria(
                  categories: _selectedCategories,
                  priceRange: _priceRange,
                  conditions: _selectedConditions,
                  campusHub: _selectedCampusHub,
                  availableToday: _availableToday,
                );
                widget.onApply(result);
                Navigator.of(context).pop(result);
              },
            ),
          ],
        ),
      ),
    );
  }
}
