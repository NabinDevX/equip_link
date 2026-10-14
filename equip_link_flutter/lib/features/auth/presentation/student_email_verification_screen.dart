import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../client.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../student_email_validation.dart';

class StudentEmailVerificationScreen extends StatefulWidget {
  const StudentEmailVerificationScreen({super.key});

  @override
  State<StudentEmailVerificationScreen> createState() =>
      _StudentEmailVerificationScreenState();
}

class _StudentEmailVerificationScreenState
    extends State<StudentEmailVerificationScreen> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  String? _challengeId;
  String? _errorText;
  int _resendSeconds = 0;
  bool _loading = false;
  Timer? _resendTimer;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  Future<void> _requestCode() async {
    final email = normalizeStudentEmail(_emailController.text);
    if (!isValidStudentEmail(email)) {
      setState(
        () => _errorText = 'Only valid .edu.in student emails are accepted.',
      );
      return;
    }
    if (_resendSeconds > 0) return;
    setState(() => _loading = true);
    try {
      final response = await client.studentEmailAuth
          .requestStudentEmailVerification(email: email);
      if (mounted) {
        setState(() {
          _challengeId = response.challengeId;
          _errorText = null;
          _resendSeconds = response.expiresInSeconds.clamp(1, 60);
        });
        _startResendCountdown();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification code sent.')),
        );
      }
    } catch (_) {
      if (mounted) {
        setState(
          () => _errorText =
              'Unable to send a verification code. Try again later.',
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _verifyCode() async {
    final challengeId = _challengeId;
    if (challengeId == null || _codeController.text.trim().isEmpty) {
      setState(
        () => _errorText = 'Request a code and enter it before continuing.',
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final identity = await client.studentEmailAuth.verifyStudentEmail(
        challengeId: challengeId,
        code: _codeController.text.trim(),
      );
      if (mounted && identity.emailVerified) context.go('/home');
    } catch (_) {
      if (mounted) {
        setState(() => _errorText = 'That code is invalid or expired.');
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _resendSeconds <= 1) {
        timer.cancel();
        if (mounted) {
          setState(() => _resendSeconds = 0);
        }
        return;
      }
      setState(() => _resendSeconds -= 1);
    });
  }

  String _maskedEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final local = parts.first;
    final visiblePrefix = local.length <= 2 ? local : local.substring(0, 2);
    return '$visiblePrefix***@${parts.last}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify student access')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Use your institution-provided .edu.in email. Google sign-in and student eligibility are verified separately.',
          ),
          const SizedBox(height: 24),
          CustomTextField(
            label: 'Student email',
            hint: 'student@college.edu.in',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 6),
          Text(
            'Only .edu.in student-email addresses are currently accepted.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (_errorText != null) ...[
            const SizedBox(height: 8),
            Text(
              _errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 12),
          PrimaryButton(
            label: _resendSeconds > 0
                ? 'Resend in ${_resendSeconds}s'
                : (_challengeId == null
                      ? 'Send verification code'
                      : 'Resend verification code'),
            isLoading: _loading,
            onPressed: _requestCode,
          ),
          if (_challengeId != null) ...[
            const SizedBox(height: 8),
            Text(
              'Code sent to ${_maskedEmail(normalizeStudentEmail(_emailController.text))}.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Verification code',
              hint: '123456',
              controller: _codeController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Verify student email',
              isLoading: _loading,
              onPressed: _verifyCode,
            ),
          ],
        ],
      ),
    );
  }
}
