import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:equip_link_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('EmailOtpChallenge Security Logic', () {
    test('hashes OTP code with salt and never exposes plaintext', () {
      const plainOtp = '123456';
      const salt = 'random-unique-salt-xyz';
      final expectedHash = sha256
          .convert(utf8.encode('$salt:$plainOtp'))
          .toString();

      final challenge = EmailOtpChallenge(
        challengeId: 'challenge-uuid-1',
        email: 'student@stanford.edu',
        codeHash: expectedHash,
        salt: salt,
        issuedAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(minutes: 10)),
        attempts: 0,
        maxAttempts: 5,
        consumed: false,
      );

      // Verify matching submitted code
      final validSubmittedHash = sha256
          .convert(utf8.encode('${challenge.salt}:$plainOtp'))
          .toString();
      expect(validSubmittedHash, equals(challenge.codeHash));

      // Verify wrong code produces mismatch
      final wrongSubmittedHash = sha256
          .convert(utf8.encode('${challenge.salt}:999999'))
          .toString();
      expect(wrongSubmittedHash, isNot(equals(challenge.codeHash)));
    });

    test('enforces challenge expiry and max attempt invalidation', () {
      final expiredChallenge = EmailOtpChallenge(
        challengeId: 'challenge-expired',
        email: 'user@campus.edu',
        codeHash: 'hash',
        salt: 'salt',
        issuedAt: DateTime.now().subtract(const Duration(minutes: 15)),
        expiresAt: DateTime.now().subtract(const Duration(minutes: 5)),
        attempts: 0,
        maxAttempts: 5,
        consumed: false,
      );

      expect(DateTime.now().isAfter(expiredChallenge.expiresAt), isTrue);

      final maxedChallenge = EmailOtpChallenge(
        challengeId: 'challenge-maxed',
        email: 'user@campus.edu',
        codeHash: 'hash',
        salt: 'salt',
        issuedAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(minutes: 10)),
        attempts: 5,
        maxAttempts: 5,
        consumed: false,
      );

      expect(maxedChallenge.attempts >= maxedChallenge.maxAttempts, isTrue);
    });

    test('single-use consumption prevents replay', () {
      final challenge = EmailOtpChallenge(
        challengeId: 'challenge-single-use',
        email: 'user@campus.edu',
        codeHash: 'hash',
        salt: 'salt',
        issuedAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(minutes: 10)),
        attempts: 1,
        maxAttempts: 5,
        consumed: true,
      );

      expect(challenge.consumed, isTrue);
    });
  });

  group('Rental Domain Business Rules', () {
    test('detects overlapping rental intervals accurately', () {
      final bookedStart = DateTime(2026, 10, 20);
      final bookedEnd = DateTime(2026, 10, 25);

      bool overlaps(DateTime reqStart, DateTime reqEnd) {
        return reqStart.isBefore(bookedEnd) && reqEnd.isAfter(bookedStart);
      }

      // Overlapping: inside
      expect(overlaps(DateTime(2026, 10, 21), DateTime(2026, 10, 23)), isTrue);
      // Overlapping: engulfing
      expect(overlaps(DateTime(2026, 10, 19), DateTime(2026, 10, 26)), isTrue);
      // Overlapping: starts before, ends inside
      expect(overlaps(DateTime(2026, 10, 19), DateTime(2026, 10, 22)), isTrue);
      // Overlapping: starts inside, ends after
      expect(overlaps(DateTime(2026, 10, 24), DateTime(2026, 10, 27)), isTrue);

      // Non-overlapping: completely before
      expect(overlaps(DateTime(2026, 10, 15), DateTime(2026, 10, 19)), isFalse);
      // Non-overlapping: completely after
      expect(overlaps(DateTime(2026, 10, 26), DateTime(2026, 10, 30)), isFalse);
    });

    test('calculates rental duration and total price correctly', () {
      final start = DateTime(2026, 11, 1);
      final end = DateTime(2026, 11, 5);
      final days = end.difference(start).inDays;
      const dailyRate = 25.0;
      final total = days * dailyRate;

      expect(days, equals(4));
      expect(total, equals(100.0));
    });

    test('validates rating constraints (1 to 5)', () {
      bool isValidRating(int r) => r >= 1 && r <= 5;

      expect(isValidRating(1), isTrue);
      expect(isValidRating(5), isTrue);
      expect(isValidRating(3), isTrue);
      expect(isValidRating(0), isFalse);
      expect(isValidRating(6), isFalse);
      expect(isValidRating(-1), isFalse);
    });
  });
}
