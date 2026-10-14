import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../auth/data/serverpod_auth_repository.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _pushNotifications = true;
  bool _returnReminders = true;
  bool _borrowerRequests = true;
  bool _emailDigests = false;

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log Out of EquipLink?'),
          content: const Text(
            'You will need to sign in again with your verified student (.edu.in) email to access your listings and rentals.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final router = GoRouter.of(context);
                Navigator.pop(dialogContext);
                final authRepo = ref.read(authRepositoryProvider);
                await authRepo.signOut();
                if (mounted) {
                  router.go('/auth/sign-in');
                }
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeTile({
    required String title,
    required String subtitle,
    required ThemeMode mode,
    required ThemeMode currentMode,
    required IconData icon,
  }) {
    final isSelected = currentMode == mode;

    return InkWell(
      onTap: () {
        ref.read(themeModeProvider.notifier).setThemeMode(mode);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.secondary : AppColors.textTertiary,
              size: 20,
            ),
            const SizedBox(width: 14),
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = ref.watch(themeModeProvider);

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
          'Settings',
          style: AppTypography.headlineSM.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appearance & Theme Mode Section
              const Text('Appearance', style: AppTypography.headlineSM),
              const SizedBox(height: 10),
              Material(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.outlineVariant),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _buildThemeTile(
                      title: 'System Default',
                      subtitle: 'Follow device system appearance',
                      mode: ThemeMode.system,
                      currentMode: currentThemeMode,
                      icon: Icons.brightness_auto,
                    ),
                    const Divider(height: 1, color: AppColors.outlineVariant),
                    _buildThemeTile(
                      title: 'Light Theme',
                      subtitle: 'EquipLink signature navy & teal canvas',
                      mode: ThemeMode.light,
                      currentMode: currentThemeMode,
                      icon: Icons.light_mode_outlined,
                    ),
                    const Divider(height: 1, color: AppColors.outlineVariant),
                    _buildThemeTile(
                      title: 'Dark Theme',
                      subtitle: 'Sleek dark collegiate night mode',
                      mode: ThemeMode.dark,
                      currentMode: currentThemeMode,
                      icon: Icons.dark_mode_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Notifications & Alerts Section
              const Text(
                'Notifications & Reminders',
                style: AppTypography.headlineSM,
              ),
              const SizedBox(height: 10),
              Material(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.outlineVariant),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SwitchListTile(
                      value: _pushNotifications,
                      activeThumbColor: AppColors.secondary,
                      title: const Text(
                        'Push Notifications',
                        style: AppTypography.labelLG,
                      ),
                      subtitle: const Text(
                        'Instant mobile push alerts for rental activity',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => _pushNotifications = val),
                    ),
                    const Divider(height: 1, color: AppColors.outlineVariant),
                    SwitchListTile(
                      value: _returnReminders,
                      activeThumbColor: AppColors.secondary,
                      title: const Text(
                        'Return Reminders',
                        style: AppTypography.labelLG,
                      ),
                      subtitle: const Text(
                        'Automated reminder 24 hours prior to locker return',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => _returnReminders = val),
                    ),
                    const Divider(height: 1, color: AppColors.outlineVariant),
                    SwitchListTile(
                      value: _borrowerRequests,
                      activeThumbColor: AppColors.secondary,
                      title: const Text(
                        'Borrower Inquiries',
                        style: AppTypography.labelLG,
                      ),
                      subtitle: const Text(
                        'Alert when a student requests your listed gear',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      onChanged: (val) =>
                          setState(() => _borrowerRequests = val),
                    ),
                    const Divider(height: 1, color: AppColors.outlineVariant),
                    SwitchListTile(
                      value: _emailDigests,
                      activeThumbColor: AppColors.secondary,
                      title: const Text(
                        'Weekly Digest Email',
                        style: AppTypography.labelLG,
                      ),
                      subtitle: const Text(
                        'Summary of campus equipment demand and earnings',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      onChanged: (val) => setState(() => _emailDigests = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Security & Account Management
              const Text('Account & Privacy', style: AppTypography.headlineSM),
              const SizedBox(height: 10),
              Material(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.outlineVariant),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.school_outlined,
                        color: AppColors.secondary,
                      ),
                      title: const Text(
                        'Institutional Email',
                        style: AppTypography.labelLG,
                      ),
                      subtitle: const Text(
                        'alex.rivera@stanford.edu (Verified)',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 18,
                      ),
                    ),
                    const Divider(height: 1, color: AppColors.outlineVariant),
                    ListTile(
                      leading: const Icon(
                        Icons.lock_reset,
                        color: AppColors.primary,
                      ),
                      title: const Text(
                        'Change Password',
                        style: AppTypography.labelLG,
                      ),
                      subtitle: const Text(
                        'Send reset instructions to institutional email',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.textTertiary,
                      ),
                      onTap: () => context.push('/auth/forgot-password'),
                    ),
                    const Divider(height: 1, color: AppColors.outlineVariant),
                    ListTile(
                      leading: const Icon(
                        Icons.policy_outlined,
                        color: AppColors.secondary,
                      ),
                      title: const Text(
                        'Honor Code Agreement',
                        style: AppTypography.labelLG,
                      ),
                      subtitle: const Text(
                        'Community rules, equipment protection policy & liability',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: AppColors.textTertiary,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'EquipLink Collegiate Honor Code active.',
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Log Out Action
              Center(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _showLogoutDialog,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'EquipLink v1.0.0 • Stanford University Network',
                  style: AppTypography.bodySM.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
