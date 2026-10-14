import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../client.dart';

/// Resumes an already stored Serverpod session and sends the user to the
/// appropriate screen for their student verification state.
class SessionRestoreScreen extends StatefulWidget {
  const SessionRestoreScreen({super.key});

  @override
  State<SessionRestoreScreen> createState() => _SessionRestoreScreenState();
}

class _SessionRestoreScreenState extends State<SessionRestoreScreen> {
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _resumeSession();
    });
  }

  Future<void> _resumeSession() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    if (!client.auth.isAuthenticated) {
      if (mounted) context.go('/onboarding');
      return;
    }

    try {
      final identity = await client.studentEmailAuth
          .getStudentEligibilityStatus();
      if (!mounted) return;
      final isEligible =
          identity.emailVerified && identity.eligibilityStatus == 'eligible';
      context.go(
        isEligible ? '/home' : '/auth/verify-student-email',
        extra: identity.studentEmail,
      );
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error =
              'Could not restore your account. Check your connection and retry.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _loading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_error ?? 'Could not restore your account.'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _resumeSession,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
