// Top-level void functions can use dart:io, otherwise avoid flutter/foundation.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/trust_badge.dart';
import '../../../client.dart';
import '../data/serverpod_auth_repository.dart';
import '../student_email_validation.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final authRepo = ref.read(authRepositoryProvider);
      final success = await authRepo.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (mounted && success) await _continueAfterAuthentication();
    } on Object catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Unable to sign in. Check your details and try again.',
            ),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _continueAfterAuthentication() async {
    setState(() => _isLoading = true);
    try {
      final identity = await client.studentEmailAuth
          .getStudentEligibilityStatus();
      if (!mounted) return;
      final isEligible =
          identity.emailVerified && identity.eligibilityStatus == 'eligible';
      context.go(isEligible ? '/home' : '/auth/verify-student-email');
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to check student eligibility. Please try again.',
          ),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo & Header
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.swap_horiz_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Welcome Back',
                    style: AppTypography.headlineXL.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Sign in with your verified student account to borrow and lend gear.',
                    style: AppTypography.bodyMD.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                // Form Fields
                CustomTextField(
                  label: 'College Email (.edu.in)',
                  hint: 'student@university.edu.in',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.mail_outline_rounded,
                    color: AppColors.secondary,
                  ),
                  helperText: 'Use your university-issued email address',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your college email';
                    }
                    if (!isValidStudentEmail(value)) {
                      return 'Must be a valid .edu.in student email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: 'Password',
                  hint: '••••••••••••',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.secondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                // Forgot Password link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/auth/forgot-password'),
                    child: Text(
                      'Forgot Password?',
                      style: AppTypography.labelMD.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Primary CTA
                PrimaryButton(
                  label: 'Sign In',
                  isLoading: _isLoading,
                  onPressed: _handleSignIn,
                ),
                const SizedBox(height: 24),

                Semantics(
                  button: true,
                  label: 'Continue with Google',
                  child: GoogleSignInWidget(
                    client: client,
                    onAuthenticated: () async {
                      await _continueAfterAuthentication();
                    },
                    onError: (error) {
                      debugPrint('Google sign-in failed: $error');
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Unable to sign in with Google. Please try again.',
                          ),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Switch to Register
                Center(
                  child: TextButton(
                    onPressed: () => context.push('/auth/register'),
                    child: RichText(
                      text: TextSpan(
                        style: AppTypography.bodyMD,
                        children: const [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          TextSpan(
                            text: 'Register as a Student',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Trust Badge
                const Center(
                  child: TrustBadge(
                    customText: 'Verified Campus Network • .edu Only',
                    variant: TrustBadgeVariant.verifiedEdu,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
