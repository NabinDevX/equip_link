import 'dart:async';
import 'dart:typed_data';

import 'package:equip_link_client/equip_link_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../client.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../student_email_validation.dart';

class StudentIdentityVerificationScreen extends StatefulWidget {
  final String? initialEmail;

  const StudentIdentityVerificationScreen({super.key, this.initialEmail});

  @override
  State<StudentIdentityVerificationScreen> createState() =>
      _StudentIdentityVerificationScreenState();
}

class _StudentIdentityVerificationScreenState
    extends State<StudentIdentityVerificationScreen> {
  final _emailController = TextEditingController();
  final _universityController = TextEditingController();
  final _codeController = TextEditingController();
  final _imagePicker = ImagePicker();

  XFile? _studentIdImage;
  Uint8List? _imageBytes;
  DateTime? _expiryDate;
  String? _challengeId;
  String? _challengeEmail;
  String? _errorText;
  int _resendSeconds = 0;
  bool _loading = false;
  bool _documentReady = false;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.initialEmail ?? '';
    unawaited(_loadExistingIdentity());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _universityController.dispose();
    _codeController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadExistingIdentity() async {
    try {
      final identity = await client.studentEmailAuth
          .getStudentEligibilityStatus();
      if (!mounted) return;
      setState(() {
        if (_emailController.text.isEmpty && identity.studentEmail != null) {
          _emailController.text = identity.studentEmail!;
        }
        _universityController.text = identity.university ?? '';
        _expiryDate = identity.studentIdExpiresAt;
        _documentReady =
            identity.studentIdCardVerified &&
            identity.studentIdExpiresAt != null &&
            DateTime.now().isBefore(identity.studentIdExpiresAt!);
      });

      if (_universityController.text.isEmpty) {
        final profile = await client.profile.getMyProfile();
        if (!mounted) return;
        if (profile.university != 'Campus University') {
          setState(() => _universityController.text = profile.university);
        }
      }
    } catch (error) {
      if (mounted) {
        setState(() => _errorText = 'Unable to load your account: $error');
      }
    }
  }

  Future<void> _chooseStudentIdImage() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        imageQuality: 85,
      );
      if (image == null) return;
      final bytes = await image.readAsBytes();
      if (bytes.isEmpty || bytes.length > 8 * 1024 * 1024) {
        setState(() => _errorText = 'Choose an image up to 8 MB.');
        return;
      }
      final extension = image.name.split('.').last.toLowerCase();
      if (!const {'jpg', 'jpeg', 'png', 'webp'}.contains(extension)) {
        setState(() => _errorText = 'Choose a JPG, PNG, or WebP image.');
        return;
      }
      setState(() {
        _studentIdImage = image;
        _imageBytes = bytes;
        _documentReady = false;
        _errorText = null;
      });
    } catch (error) {
      if (mounted) {
        setState(() => _errorText = 'Could not select that image: $error');
      }
    }
  }

  Future<void> _chooseExpiryDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _expiryDate != null && _expiryDate!.isAfter(now)
          ? _expiryDate!
          : now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 8, 12, 31),
      helpText: 'Student ID expiry date',
    );
    if (selected == null || !mounted) return;
    setState(() {
      _expiryDate = selected;
      _documentReady = false;
      _errorText = null;
    });
  }

  Future<void> _requestCode() async {
    final email = normalizeStudentEmail(_emailController.text);
    final university = _universityController.text.trim();
    if (!isValidStudentEmail(email)) {
      setState(() => _errorText = 'Enter a valid .edu.in student email.');
      return;
    }
    if (university.isEmpty) {
      setState(() => _errorText = 'Enter your university or campus.');
      return;
    }
    final expiryEnd = _expiryDate == null
        ? null
        : DateTime(
            _expiryDate!.year,
            _expiryDate!.month,
            _expiryDate!.day,
            23,
            59,
            59,
          );
    if (expiryEnd == null || !expiryEnd.isAfter(DateTime.now())) {
      setState(() => _errorText = 'Choose a future student ID expiry date.');
      return;
    }
    if (!_documentReady && _studentIdImage == null) {
      setState(
        () => _errorText = 'Upload a clear image of your student ID card.',
      );
      return;
    }
    if (_resendSeconds > 0) return;

    setState(() {
      _loading = true;
      _errorText = null;
    });
    try {
      if (!_documentReady) {
        final image = _studentIdImage!;
        final bytes = _imageBytes ?? await image.readAsBytes();
        final upload = await client.studentEmailAuth.prepareStudentIdCardUpload(
          university: university,
          expiresAt: _expiryDate!,
          fileName: image.name,
          fileSizeBytes: bytes.length,
        );
        final uploaded = await FileUploader(
          upload.uploadDescription,
        ).uploadByteData(ByteData.sublistView(bytes));
        if (!uploaded) throw StateError('The student ID image upload failed.');
        await client.studentEmailAuth.verifyStudentIdCardUpload(
          path: upload.path,
        );
        if (mounted) setState(() => _documentReady = true);
      }

      final response = await client.studentEmailAuth
          .requestStudentEmailVerification(email: email);
      if (!mounted) return;
      if (response.challengeId.isEmpty) {
        context.go('/home');
        return;
      }
      setState(() {
        _challengeId = response.challengeId;
        _challengeEmail = email;
        _errorText = null;
        _resendSeconds = response.expiresInSeconds.clamp(1, 60);
      });
      _startResendCountdown();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification code sent to your student email.'),
        ),
      );
    } catch (error) {
      if (mounted) {
        setState(() => _errorText = 'Unable to continue verification: $error');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _verifyCode() async {
    final challengeId = _challengeId;
    if (challengeId == null || _codeController.text.trim().length != 6) {
      setState(() => _errorText = 'Enter the 6-digit code sent to your email.');
      return;
    }
    setState(() {
      _loading = true;
      _errorText = null;
    });
    try {
      final identity = await client.studentEmailAuth.verifyStudentEmail(
        challengeId: challengeId,
        code: _codeController.text.trim(),
      );
      if (mounted && identity.eligibilityStatus == 'eligible') {
        context.go('/home');
      }
    } catch (error) {
      if (mounted) {
        setState(() => _errorText = 'That code could not be verified: $error');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _resendSeconds <= 1) {
        timer.cancel();
        if (mounted) setState(() => _resendSeconds = 0);
        return;
      }
      setState(() => _resendSeconds -= 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expiryLabel = _expiryDate == null
        ? 'Select expiry date'
        : '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}';

    return Scaffold(
      appBar: AppBar(title: const Text('Verify student access')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Verify your .edu.in email and current student ID. Your account stays limited after the ID expiry date until you verify a new student identity.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          CustomTextField(
            label: 'University / Campus',
            hint: 'Enter your university or campus',
            controller: _universityController,
            onChanged: (_) => setState(() => _documentReady = false),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Student email (.edu.in)',
            hint: 'student@university.edu.in',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (_challengeId != null &&
                  normalizeStudentEmail(value) != _challengeEmail) {
                setState(() {
                  _challengeId = null;
                  _challengeEmail = null;
                  _resendSeconds = 0;
                });
                _resendTimer?.cancel();
              }
            },
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _loading ? null : _chooseExpiryDate,
            icon: const Icon(Icons.event_outlined),
            label: Text('Student ID expiry: $expiryLabel'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _loading ? null : _chooseStudentIdImage,
            icon: const Icon(Icons.badge_outlined),
            label: Text(
              _studentIdImage?.name ??
                  (_documentReady
                      ? 'Student ID image uploaded'
                      : 'Upload student ID card image'),
            ),
          ),
          if (_imageBytes != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                _imageBytes!,
                height: 180,
                fit: BoxFit.contain,
              ),
            ),
          ],
          if (_errorText != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 16),
          PrimaryButton(
            label: _challengeId == null
                ? 'Upload ID & send verification code'
                : (_resendSeconds > 0
                      ? 'Resend in ${_resendSeconds}s'
                      : 'Resend verification code'),
            isLoading: _loading,
            onPressed: _requestCode,
          ),
          if (_challengeId != null) ...[
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Verification code',
              hint: '123456',
              controller: _codeController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Verify student email & activate account',
              isLoading: _loading,
              onPressed: _verifyCode,
            ),
          ],
        ],
      ),
    );
  }
}
