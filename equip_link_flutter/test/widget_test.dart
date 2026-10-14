import 'package:equip_link_flutter/core/widgets/primary_button.dart';
import 'package:equip_link_flutter/core/widgets/custom_text_field.dart';
import 'package:equip_link_flutter/features/marketplace/presentation/equipment_details_screen.dart';
import 'package:equip_link_flutter/features/marketplace/data/mock_equipment_repository.dart';
import 'package:equip_link_flutter/features/marketplace/data/serverpod_equipment_repository.dart';
import 'package:equip_link_flutter/features/marketplace/presentation/listing_form_screen.dart';
import 'package:equip_link_flutter/features/notifications/presentation/notification_centre_screen.dart';
import 'package:equip_link_flutter/features/profile/presentation/settings_screen.dart';
import 'package:equip_link_flutter/features/profile/presentation/student_profile_screen.dart';
import 'package:equip_link_flutter/features/profile/data/mock_profile_repository.dart';
import 'package:equip_link_flutter/features/profile/data/serverpod_profile_repository.dart';
import 'package:equip_link_flutter/features/rentals/presentation/rental_activity_screen.dart';
import 'package:equip_link_flutter/features/rentals/data/mock_rental_repository.dart'
    show MockRentalRepository;
import 'package:equip_link_flutter/features/rentals/data/serverpod_rental_repository.dart';
import 'package:equip_link_flutter/features/auth/student_email_validation.dart';
import 'package:equip_link_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('student email validation accepts only normalized .edu.in addresses', () {
    expect(isValidStudentEmail(' Student@College.edu.in '), isTrue);
    expect(isValidStudentEmail('student@college.edu'), isFalse);
    expect(isValidStudentEmail('student@college.ac.in'), isFalse);
    expect(isValidStudentEmail('student@college.edu.in.example'), isFalse);
  });

  testWidgets('EquipLink app loads onboarding screen initially', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: EquipLinkApp()));
    await tester.pumpAndSettle();

    expect(find.text('EquipLink'), findsOneWidget);
    expect(find.text('Borrow Smart. Lend Easy.'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.byType(PrimaryButton), findsOneWidget);
    expect(
      find.textContaining('Already have an account', findRichText: true),
      findsOneWidget,
    );
  });

  testWidgets('EquipmentDetailsScreen renders pricing and request button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          equipmentRepositoryProvider.overrideWithValue(
            MockEquipmentRepository(),
          ),
        ],
        child: MaterialApp(
          home: EquipmentDetailsScreen(equipmentId: 'fluke-117-multimeter'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Equipment Details'), findsOneWidget);
    expect(
      find.textContaining('Fluke 117 True RMS Digital Multimeter Kit'),
      findsOneWidget,
    );
    expect(find.text('\$0 Guarantee'), findsOneWidget);
    expect(find.text('Request to Borrow'), findsOneWidget);
  });

  testWidgets('RentalActivityScreen renders tabs and status filters', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          rentalRepositoryProvider.overrideWithValue(MockRentalRepository()),
        ],
        child: const MaterialApp(home: RentalActivityScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Rental Activity'), findsOneWidget);
    expect(find.text('Borrowing'), findsOneWidget);
    expect(find.text('Lending'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
  });

  testWidgets('ListingFormScreen validates required fields on submit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ListingFormScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Create Listing'), findsOneWidget);
    expect(find.text('Publish Listing →'), findsOneWidget);

    await tester.tap(find.text('Publish Listing →'));
    await tester.pumpAndSettle();

    expect(
      find.text('Please enter a descriptive equipment name (min 5 characters)'),
      findsOneWidget,
    );
  });

  testWidgets('NotificationCentreScreen renders categories and list items', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: NotificationCentreScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Notification Centre'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Requests'), findsOneWidget);
    expect(find.text('Mark all read'), findsOneWidget);
  });

  testWidgets('StudentProfileScreen renders identity and activity statistics', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileRepositoryProvider.overrideWithValue(MockProfileRepository()),
        ],
        child: const MaterialApp(home: StudentProfileScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Student Profile'), findsOneWidget);
    expect(find.text('Alex Rivera'), findsOneWidget);
    expect(find.text('alex.rivera@stanford.edu'), findsOneWidget);
    expect(find.text('My Equipment Listings'), findsOneWidget);
    expect(find.text('Rental Activity & History'), findsOneWidget);
  });

  testWidgets('SettingsScreen renders theme options and account settings', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('System Default'), findsOneWidget);
    expect(find.text('Light Theme'), findsOneWidget);
    expect(find.text('Dark Theme'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);
  });

  testWidgets('CustomTextField keeps entered text visible in both themes', (
    WidgetTester tester,
  ) async {
    final controller = TextEditingController(text: 'visible value');
    addTearDown(controller.dispose);

    for (final theme in [ThemeData.light(), ThemeData.dark()]) {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: CustomTextField(
              label: 'Value',
              controller: controller,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('visible value'), findsOneWidget);
    }
  });
}
