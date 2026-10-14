import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../data/serverpod_auth_repository.dart';
import '../student_email_validation.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _universityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreedToTerms = false;
  bool _showTermsError = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _universityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      setState(() => _showTermsError = true);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final authRepo = ref.read(authRepositoryProvider);
      final success = await authRepo.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        university: _universityController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted && success) {
        context.push(
          '/auth/verify-email',
          extra: _emailController.text.trim(),
        );
      }
    } on Object catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_readableRegistrationError(error)),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _readableRegistrationError(Object error) {
    final message = error.toString().replaceFirst('Exception: ', '').trim();
    if (message.isEmpty) {
      return 'Unable to start registration. Check your connection and try again.';
    }
    final normalizedMessage = message.toLowerCase();
    if (normalizedMessage.contains('failed host lookup') ||
        normalizedMessage.contains('socketexception')) {
      return 'EquipLink could not resolve the server address. Check that this '
          'phone has internet access, then set Android Private DNS to '
          'Automatic and try again.';
    }
    return 'Unable to start registration: $message';
  }

  Future<void> _continueWithGoogle() async {
    if (!_agreedToTerms) {
      setState(() => _showTermsError = true);
      return;
    }
    try {
      final identity = await client.studentEmailAuth
          .getStudentEligibilityStatus();
      if (!mounted) return;
      context.go(
        identity.emailVerified && identity.eligibilityStatus == 'eligible'
            ? '/home'
            : '/auth/verify-student-email',
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to check student eligibility: $error'),
          backgroundColor: AppColors.error,
        ),
      );
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
                Text(
                  'Create Account',
                  style: AppTypography.headlineXL.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Join your campus equipment network to borrow and lend gear safely.',
                  style: AppTypography.bodyMD.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                // Full Name
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Alex Rivera',
                  controller: _nameController,
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.secondary,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Please enter your name'
                      : null,
                ),
                const SizedBox(height: 16),

                // College Email
                CustomTextField(
                  label: 'College Email (.edu.in)',
                  hint: 'student@university.edu.in',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.mail_outline_rounded,
                    color: AppColors.secondary,
                  ),
                  helperText: 'Use your university-issued .edu.in email',
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Please enter your college email';
                    }
                    if (!isValidStudentEmail(v)) {
                      return 'Must be a valid .edu.in student email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // University / Campus
                CustomTextField(
                  label: 'University / Campus',
                  hint: 'e.g., Stanford University',
                  controller: _universityController,
                  prefixIcon: const Icon(
                    Icons.school_outlined,
                    color: AppColors.secondary,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Please enter your university or campus'
                      : null,
                ),
                const SizedBox(height: 16),

                // Password
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
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  helperText: 'Minimum 8 characters with letters & numbers',
                  validator: (v) {
                    if (v == null || v.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password
                CustomTextField(
                  label: 'Confirm Password',
                  hint: '••••••••••••',
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  prefixIcon: const Icon(
                    Icons.lock_reset_outlined,
                    color: AppColors.secondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (v) {
                    if (v != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Terms & Honor Code Checkbox
                InkWell(
                  onTap: () => setState(() {
                    _agreedToTerms = !_agreedToTerms;
                    _showTermsError = false;
                  }),
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        activeColor: AppColors.secondary,
                        checkColor: Colors.white,
                        side: const BorderSide(
                          color: AppColors.textSecondary,
                          width: 1.8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (v) => setState(() {
                          _agreedToTerms = v ?? false;
                          _showTermsError = false;
                        }),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'I agree to the Campus Honor Code, Student Equipment Care terms, and Verified Borrower policies.',
                            style: AppTypography.bodySM.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showTermsError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 4),
                    child: Text(
                      'Please agree to the Honor Code and Equipment Care terms.',
                      style: AppTypography.bodySM.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                const SizedBox(height: 24),

                // CTA
                PrimaryButton(
                  label: 'Continue to Verification →',
                  isLoading: _isLoading,
                  onPressed: _handleRegister,
                ),
                const SizedBox(height: 12),
                AbsorbPointer(
                  absorbing: !_agreedToTerms,
                  child: Opacity(
                    opacity: _agreedToTerms ? 1 : 0.55,
                    child: GoogleSignInWidget(
                      client: client,
                      onAuthenticated: _continueWithGoogle,
                      onError: (error) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Google sign-in failed: $error'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (!_agreedToTerms)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Agree to the policies above to continue with Google.',
                      style: AppTypography.bodySM.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),

                // Switch to Sign In
                Center(
                  child: TextButton(
                    onPressed: () => context.push('/auth/sign-in'),
                    child: RichText(
                      text: TextSpan(
                        style: AppTypography.bodyMD,
                        children: const [
                          TextSpan(
                            text: 'Already registered? ',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          TextSpan(
                            text: 'Sign In',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
