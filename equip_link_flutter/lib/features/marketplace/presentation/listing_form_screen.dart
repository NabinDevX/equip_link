import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../data/serverpod_equipment_repository.dart';
import '../data/models/equipment_item.dart';

class ListingFormScreen extends ConsumerStatefulWidget {
  final String? listingId;

  const ListingFormScreen({super.key, this.listingId});

  @override
  ConsumerState<ListingFormScreen> createState() => _ListingFormScreenState();
}

class _ListingFormScreenState extends ConsumerState<ListingFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _dailyRateController;
  late TextEditingController _weeklyRateController;
  late TextEditingController _accessoryInputController;

  String _selectedCategory = 'Electronics & STEM';
  String _selectedCondition = 'Like New';
  String _selectedCampusHub = 'Huang Engineering Center (Locker 14B)';
  bool _isAvailable = true;
  bool _isLoading = false;
  bool _isInitialLoaded = false;

  final List<String> _photos = [
    'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=800',
  ];
  final List<String> _accessories = [];

  final List<String> _categories = [
    'Electronics & STEM',
    'Lab & Science',
    'Calculators',
    'Media & Cameras',
    'Drafting & Architecture',
  ];

  final List<String> _conditions = ['Like New', 'Excellent', 'Good'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _dailyRateController = TextEditingController();
    _weeklyRateController = TextEditingController();
    _accessoryInputController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dailyRateController.dispose();
    _weeklyRateController.dispose();
    _accessoryInputController.dispose();
    super.dispose();
  }

  void _populateExistingItem(EquipmentItem item) {
    if (_isInitialLoaded) return;
    _nameController.text = item.name;
    _descriptionController.text = item.description;
    _dailyRateController.text = item.dailyRate.toStringAsFixed(0);
    _weeklyRateController.text = item.weeklyRate.toStringAsFixed(0);
    _selectedCategory = item.category;
    _selectedCondition = item.condition;
    _selectedCampusHub = item.campusLocation;
    _isAvailable = item.isAvailable;
    _accessories.clear();
    _accessories.addAll(item.accessories);
    _isInitialLoaded = true;
  }

  void _addAccessory() {
    final text = _accessoryInputController.text.trim();
    if (text.isNotEmpty && !_accessories.contains(text)) {
      setState(() {
        _accessories.add(text);
        _accessoryInputController.clear();
      });
    }
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    if (_photos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one cover photo for the listing'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(equipmentRepositoryProvider);
      final daily = double.tryParse(_dailyRateController.text) ?? 5.0;
      final weekly =
          double.tryParse(_weeklyRateController.text) ?? (daily * 3.5);

      final item = EquipmentItem(
        id: widget.listingId ?? '',
        name: _nameController.text.trim(),
        category: _selectedCategory,
        condition: _selectedCondition,
        dailyRate: daily,
        weeklyRate: weekly,
        imageUrl: _photos.first,
        campusLocation: _selectedCampusHub,
        lenderName: 'Alex R.',
        lenderRating: 5.0,
        isAvailable: _isAvailable,
        description: _descriptionController.text.trim(),
        accessories: _accessories,
      );

      await repo.saveListing(item);
      ref.invalidate(equipmentListProvider);
      ref.invalidate(myListingsProvider);
      if (widget.listingId != null) {
        ref.invalidate(equipmentDetailsProvider(widget.listingId!));
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.listingId != null
                  ? 'Listing updated successfully!'
                  : 'Listing published to campus marketplace!',
            ),
            backgroundColor: AppColors.success,
          ),
        );
        context.go('/my-listings');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.listingId != null;

    if (isEditing && !_isInitialLoaded) {
      final existingAsync = ref.watch(
        equipmentDetailsProvider(widget.listingId!),
      );
      existingAsync.whenData((item) {
        if (item != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _populateExistingItem(item);
            setState(() {});
          });
        }
      });
    }

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
          isEditing ? 'Edit Listing' : 'Create Listing',
          style: AppTypography.headlineSM.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Upload Section
                      const Text(
                        'Equipment Photos',
                        style: AppTypography.headlineSM,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Upload clear photos of the gear, including tags, condition, and accessories.',
                        style: AppTypography.bodySM.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 110,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // Primary photo card
                            ..._photos.asMap().entries.map((entry) {
                              final index = entry.key;
                              final url = entry.value;
                              return Stack(
                                children: [
                                  Container(
                                    width: 110,
                                    height: 110,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: AppColors.secondary,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        url,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) => Container(
                                          color: AppColors.surfaceContainer,
                                          child: const Icon(
                                            Icons.image_outlined,
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    left: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Cover',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_photos.length > 1)
                                    Positioned(
                                      top: 4,
                                      right: 16,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(
                                            () => _photos.removeAt(index),
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            }),
                            // Dashed Add Photo slot
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _photos.add(
                                    'https://images.unsplash.com/photo-1581092335397-9583fe92d232?w=800',
                                  );
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Simulated photo added from campus camera roll',
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.outline,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: AppColors.secondary,
                                      size: 28,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '+ Add Photo',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Equipment Title
                      CustomTextField(
                        label: 'Equipment Title',
                        hint: 'e.g. Fluke 117 True RMS Digital Multimeter Kit',
                        controller: _nameController,
                        validator: (v) {
                          if (v == null || v.trim().length < 5) {
                            return 'Please enter a descriptive equipment name (min 5 characters)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // Category Dropdown
                      Text(
                        'Category',
                        style: AppTypography.labelMD.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCategory,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.category_outlined,
                            color: AppColors.secondary,
                          ),
                        ),
                        items: _categories.map((c) {
                          return DropdownMenuItem(value: c, child: Text(c));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedCategory = val);
                          }
                        },
                      ),
                      const SizedBox(height: 18),

                      // Condition Selector
                      Text(
                        'Condition',
                        style: AppTypography.labelMD.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: _conditions.map((cond) {
                          final isSelected = _selectedCondition == cond;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(cond),
                              selected: isSelected,
                              selectedColor: AppColors.successContainer,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? AppColors.success
                                    : AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) =>
                                  setState(() => _selectedCondition = cond),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 18),

                      // Description with character counter
                      CustomTextField(
                        label: 'Description & Course Relevance',
                        hint:
                            'Mention compatible courses (e.g. EE101, MATH 51), battery health, or specific instructions...',
                        controller: _descriptionController,
                        maxLines: 4,
                        validator: (v) {
                          if (v == null || v.trim().length < 15) {
                            return 'Please provide a helpful description (min 15 characters)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // Accessories List
                      Text(
                        'Included Accessories',
                        style: AppTypography.labelMD.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _accessoryInputController,
                              decoration: const InputDecoration(
                                hintText: 'e.g. Probes, USB cable, Charger',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                              ),
                              onSubmitted: (_) => _addAccessory(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(60, 48),
                            ),
                            onPressed: _addAccessory,
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                      if (_accessories.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          children: _accessories.map((acc) {
                            return Chip(
                              label: Text(
                                acc,
                                style: const TextStyle(fontSize: 12),
                              ),
                              deleteIcon: const Icon(Icons.close, size: 14),
                              onDeleted: () {
                                setState(() => _accessories.remove(acc));
                              },
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 18),

                      // Pricing: Daily & Weekly rates
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'Daily Rate (\$)',
                              hint: '6.00',
                              controller: _dailyRateController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              prefixIcon: const Icon(
                                Icons.attach_money,
                                color: AppColors.secondary,
                              ),
                              validator: (v) {
                                if (v == null || double.tryParse(v) == null) {
                                  return 'Enter daily price';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: CustomTextField(
                              label: 'Weekly Rate (\$)',
                              hint: '22.00',
                              controller: _weeklyRateController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              prefixIcon: const Icon(
                                Icons.attach_money,
                                color: AppColors.secondary,
                              ),
                              validator: (v) {
                                if (v == null || double.tryParse(v) == null) {
                                  return 'Enter weekly price';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Campus Pickup Hub
                      Text(
                        'Pickup & Smart Locker Location',
                        style: AppTypography.labelMD.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        initialValue: _selectedCampusHub,
                        decoration: const InputDecoration(
                          hintText: 'Enter pickup or smart locker location',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.secondary,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedCampusHub = value.trim();
                          });
                        },
                      ),
                      const SizedBox(height: 18),

                      // Availability Switch
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Available for Immediate Requests',
                          style: AppTypography.labelMD,
                        ),
                        subtitle: const Text(
                          'Students can discover and request this item right now',
                          style: AppTypography.bodySM,
                        ),
                        value: _isAvailable,
                        activeThumbColor: AppColors.secondary,
                        onChanged: (val) => setState(() => _isAvailable = val),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Sticky Bottom Action Bar
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
                label: isEditing ? 'Save Changes' : 'Publish Listing →',
                isLoading: _isLoading,
                onPressed: _handleSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
