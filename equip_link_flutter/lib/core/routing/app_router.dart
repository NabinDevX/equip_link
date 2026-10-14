import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/bottom_nav_shell.dart';
import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/email_verification_screen.dart';
import '../../features/auth/presentation/password_recovery_screen.dart';
import '../../features/auth/presentation/student_identity_verification_screen.dart';
import '../../features/marketplace/presentation/home_dashboard_screen.dart';
import '../../features/marketplace/presentation/equipment_search_screen.dart';
import '../../features/marketplace/presentation/equipment_details_screen.dart';
import '../../features/marketplace/presentation/listing_form_screen.dart';
import '../../features/marketplace/presentation/my_listings_screen.dart';
import '../../features/rentals/presentation/rental_request_screen.dart';
import '../../features/rentals/presentation/rental_activity_screen.dart';
import '../../features/rentals/presentation/rental_details_screen.dart';
import '../../features/notifications/presentation/notification_centre_screen.dart';
import '../../features/profile/presentation/student_profile_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth/sign-in',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/auth/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/auth/verify-email',
      builder: (context, state) {
        final email = state.extra is String
            ? state.extra! as String
            : state.uri.queryParameters['email'] ?? '';
        return EmailVerificationScreen(email: email);
      },
    ),
    GoRoute(
      path: '/auth/forgot-password',
      builder: (context, state) => const PasswordRecoveryScreen(),
    ),
    GoRoute(
      path: '/auth/verify-student-email',
      builder: (context, state) => StudentIdentityVerificationScreen(
        initialEmail: state.extra is String ? state.extra! as String : null,
      ),
    ),
    GoRoute(
      path: '/equipment/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return EquipmentDetailsScreen(equipmentId: id);
      },
    ),
    GoRoute(
      path: '/equipment/:id/request',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return RentalRequestScreen(equipmentId: id);
      },
    ),
    GoRoute(
      path: '/listings/edit',
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];
        return ListingFormScreen(listingId: id);
      },
    ),
    GoRoute(
      path: '/my-listings',
      builder: (context, state) => const MyListingsScreen(),
    ),
    GoRoute(
      path: '/rentals/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return RentalDetailsScreen(rentalId: id);
      },
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationCentreScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeDashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const EquipmentSearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/rentals',
              builder: (context, state) => const RentalActivityScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const StudentProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
