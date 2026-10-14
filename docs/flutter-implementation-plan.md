# EquipLink — Flutter Implementation Plan

**Stitch Project ID:** `7305517365938937763`  
**Design System Asset ID:** `assets/6753531371765945936`  
**Target Platform:** Flutter (Mobile Portrait)  
**Backend Architecture:** FastAPI (Endpoints marked `TBD` where not yet defined/deployed)  

---

## 1. Architecture Overview

### State Management & Architecture
- **State Management:** Riverpod (`flutter_riverpod`) or Provider (to be selected in implementation phase).
- **Navigation:** Declarative routing using `go_router` or Flutter named routes.
- **Networking:** HTTP client (`dio` or `http`) targeting the FastAPI REST API.
- **Theme Foundation:** Centralized `AppTheme` defining `ThemeData` based on verified Stitch tokens (`#143F5B` navy, `#147D77` teal, `#F5F8FC` canvas, Inter font, 12px corner radii).

---

## 2. Screen Implementation Mapping

### 1. Onboarding
- **Flutter Route:** `/onboarding`
- **Planned Page / Widget:** `OnboardingPage` (`lib/features/auth/presentation/onboarding_page.dart`)
- **Stitch Screen ID:** `28575c6fffaf44b6ba10080e7320164a`
- **Components to Reuse:** `PrimaryButton`, `SecondaryButton`, `CategoryChip`, `BrandHeader`
- **Data Needed:** Static onboarding copy and category highlights
- **Interaction Behaviour:**
  - "Get Started" navigates to `/auth/register`.
  - "Sign In" navigates to `/auth/sign-in`.
- **Backend Endpoint:** None (Client-side presentation)

---

### 2. Sign In
- **Flutter Route:** `/auth/sign-in`
- **Planned Page / Widget:** `SignInPage` (`lib/features/auth/presentation/sign_in_page.dart`)
- **Stitch Screen ID:** `cbeb998385ed4debb331f4c418dab999`
- **Components to Reuse:** `CustomTextField`, `PasswordTextField`, `PrimaryButton`, `TrustBadge`
- **Data Needed:** User credentials (`email`, `password`)
- **Interaction Behaviour:**
  - Validates `.edu` email format.
  - Toggles password obscuring via eye icon.
  - Submits credentials, stores auth token on success, and navigates to `/home`.
  - "Forgot Password?" routes to `/auth/forgot-password`.
  - "Register as a Student" routes to `/auth/register`.
- **Backend Endpoint:** `TBD` (e.g. `POST /api/v1/auth/login`)

---

### 3. Student Registration
- **Flutter Route:** `/auth/register`
- **Planned Page / Widget:** `RegistrationPage` (`lib/features/auth/presentation/registration_page.dart`)
- **Stitch Screen ID:** `62a50b06ff7e4be9ab43130642b3b160`
- **Components to Reuse:** `CustomTextField`, `PasswordTextField`, `DropdownSelector`, `PrimaryButton`, `CheckboxRow`
- **Data Needed:** `fullName`, `collegeEmail`, `universityId`, `password`, `termsAccepted`
- **Interaction Behaviour:**
  - Validates `.edu` email domain, 8-character password requirement, and password match.
  - Enforces Honor Code checkbox check.
  - Submits registration and navigates to `/auth/verify-email`.
  - Bottom link navigates to `/auth/sign-in`.
- **Backend Endpoint:** `TBD` (e.g. `POST /api/v1/auth/register`)

---

### 4. College Email Verification
- **Flutter Route:** `/auth/verify-email`
- **Planned Page / Widget:** `EmailVerificationPage` (`lib/features/auth/presentation/email_verification_page.dart`)
- **Stitch Screen ID:** `7c4d5eed9f5049de959b38b8f3d99d58`
- **Components to Reuse:** `OtpInputField` (6-digit), `PrimaryButton`, `CountdownTimerWidget`, `TrustBadge`
- **Data Needed:** `email`, 6-digit `verificationCode`
- **Interaction Behaviour:**
  - Auto-focus and auto-advance across the 6 OTP input boxes.
  - Active 45-second countdown for the "Resend Code" button.
  - "Verify & Continue" verifies token, activates account, and routes to `/home`.
  - "Edit email" allows updating destination address.
  - Fallback option to request magic link.
- **Backend Endpoint:** `TBD` (e.g. `POST /api/v1/auth/verify-email`, `POST /api/v1/auth/resend-code`)

---

### 5. Password Recovery
- **Flutter Route:** `/auth/forgot-password`
- **Planned Page / Widget:** `PasswordRecoveryPage` (`lib/features/auth/presentation/password_recovery_page.dart`)
- **Stitch Screen ID:** `37dd1bb9deaa4d4eb8491deba92a90af`
- **Components to Reuse:** `CustomTextField`, `PrimaryButton`, `ConfirmationBanner`
- **Data Needed:** `email`
- **Interaction Behaviour:**
  - Validates email input.
  - "Send Reset Instructions" shows inline success card with resend option and 15-minute expiration notice.
  - "Return to Sign In" navigates to `/auth/sign-in`.
- **Backend Endpoint:** `TBD` (e.g. `POST /api/v1/auth/forgot-password`)

---

### 6. Home Dashboard
- **Flutter Route:** `/home`
- **Planned Page / Widget:** `HomeDashboardPage` (`lib/features/marketplace/presentation/home_dashboard_page.dart`)
- **Stitch Screen ID:** `abe361cf113b4b388f50c9cbc6146eca`
- **Components to Reuse:** `EquipmentCard`, `CategoryCarousel`, `SearchBarField`, `LenderCalloutCard`, `BottomNavBar`
- **Data Needed:** User profile summary, active campus categories, list of recently added equipment
- **Interaction Behaviour:**
  - Tapping search bar navigates to `/search`.
  - Tapping category chip filters items or routes to `/search?category=...`.
  - Tapping equipment card routes to `/equipment/:id`.
  - Tapping "+ Lend Gear" routes to `/listings/edit`.
  - Bottom navigation bar switches core tabs (`/home`, `/search`, `/rentals`, `/profile`).
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/equipment/recent`, `GET /api/v1/categories`)

---

### 7. Equipment Search & Filters
- **Flutter Route:** `/search`
- **Planned Page / Widget:** `EquipmentSearchPage` (`lib/features/marketplace/presentation/equipment_search_page.dart`)
- **Stitch Screen ID:** `522ba4a277ed44c59ee7fc671ffbb23b`
- **Components to Reuse:** `EquipmentCard`, `FilterBottomSheet`, `FilterChipGroup`, `SortDropdown`, `BottomNavBar`
- **Data Needed:** Query string, selected filters (`categories`, `priceMin`, `priceMax`, `condition`, `location`, `availableNow`), sort mode (`lowestPrice`, `highestRated`, `closest`)
- **Interaction Behaviour:**
  - Debounced search query triggers live search.
  - Tapping filter button or chip opens `FilterBottomSheet` modal.
  - Bottom sheet includes price range slider, category multi-select, and location pills.
  - "Apply Filters" updates results count and list; "Clear All" resets filters.
  - Tapping item card routes to `/equipment/:id`.
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/equipment/search`)

---

### 8. Equipment Details
- **Flutter Route:** `/equipment/:id`
- **Planned Page / Widget:** `EquipmentDetailsPage` (`lib/features/marketplace/presentation/equipment_details_page.dart`)
- **Stitch Screen ID:** `f1dc18ccf9724a42b68b00e591516339`
- **Components to Reuse:** `ImageCarousel`, `PricingCard`, `LenderCard`, `ConditionBadge`, `StickyActionDock`
- **Data Needed:** Detailed equipment model (`name`, `category`, `photos`, `dailyRate`, `weeklyRate`, `condition`, `description`, `accessories`, `lender`, `campusHub`, `availabilitySchedule`)
- **Interaction Behaviour:**
  - Swipe/tap image carousel to view all item photos with zoom capability.
  - Bookmark toggle saves item locally/remotely.
  - "Ask Marcus a question" opens in-app chat.
  - Sticky "Request to Borrow" button routes to `/equipment/:id/request`.
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/equipment/{id}`)

---

### 9. Create / Edit Listing
- **Flutter Route:** `/listings/edit`
- **Planned Page / Widget:** `ListingFormPage` (`lib/features/lending/presentation/listing_form_page.dart`)
- **Stitch Screen ID:** `41c8cd516489499bb482156dda9b1564`
- **Components to Reuse:** `ImageUploadSlot`, `CustomTextField`, `DropdownSelector`, `ConditionRadioGroup`, `PricingInputRow`, `StickyActionDock`
- **Data Needed:** Existing listing data (if editing) or new draft object (`name`, `category`, `condition`, `description`, `dailyRate`, `weeklyRate`, `photos`, `pickupHub`, `isAvailable`)
- **Interaction Behaviour:**
  - Photo picker allows selecting up to 5 photos with preview and deletion.
  - Weekly rate recommends a 40–50% discount based on daily rate.
  - Toggle switch changes immediate availability status.
  - "Publish Listing →" / "Save Changes" validates fields, uploads photos, submits to backend, and routes to `/my-listings`.
- **Backend Endpoint:** `TBD` (e.g. `POST /api/v1/listings`, `PUT /api/v1/listings/{id}`)

---

### 10. My Equipment Listings
- **Flutter Route:** `/my-listings`
- **Planned Page / Widget:** `MyListingsPage` (`lib/features/lending/presentation/my_listings_page.dart`)
- **Stitch Screen ID:** `4876ad513789463b958af409f555154d`
- **Components to Reuse:** `LenderStatsCard`, `StatusFilterBar`, `ListingManagementCard`, `BottomNavBar`
- **Data Needed:** Student lender stats (`activeCount`, `termEarnings`, `pendingCount`), list of owned equipment listings
- **Interaction Behaviour:**
  - Filter chips toggle between `All`, `Active`, `Currently Rented`, and `Paused`.
  - Pause/Activate switches change item visibility.
  - "Edit Listing" routes to `/listings/edit?id=...`.
  - "Review" on pending banner routes to `/rentals`.
  - "+ Add New" button opens `/listings/edit`.
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/users/me/listings`, `PATCH /api/v1/listings/{id}/status`)

---

### 11. Rental Request & Booking
- **Flutter Route:** `/equipment/:id/request`
- **Planned Page / Widget:** `RentalRequestPage` (`lib/features/rentals/presentation/rental_request_page.dart`)
- **Stitch Screen ID:** `bfe5954028504205bc4597179c0afd9d`
- **Components to Reuse:** `ItemSummaryHeader`, `DateRangePickerCard`, `HandoffRadioSelector`, `PriceBreakdownCard`, `StickyActionDock`
- **Data Needed:** Equipment summary, selected date range (`startDate`, `endDate`), handoff method (`locker` vs `inPerson`), optional message
- **Interaction Behaviour:**
  - Date cards launch date-time picker and compute loan duration.
  - Automatically calculates daily rate, multi-day discount, campus network fee, and total estimate.
  - "Send Rental Request →" creates booking record and redirects to `/rentals/:id`.
- **Backend Endpoint:** `TBD` (e.g. `POST /api/v1/rentals/request`)

---

### 12. Rental Activity & Bookings
- **Flutter Route:** `/rentals`
- **Planned Page / Widget:** `RentalActivityPage` (`lib/features/rentals/presentation/rental_activity_page.dart`)
- **Stitch Screen ID:** `e1ae92c1b5334d5899e943f9c673449b`
- **Components to Reuse:** `DualRoleSegmentedControl`, `StatusFilterBar`, `RentalActivityCard`, `BottomNavBar`
- **Data Needed:** Lists of rentals for both roles (`borrowing` and `lending`), categorized by status
- **Interaction Behaviour:**
  - Segmented control switches between "Borrowing" and "Lending" lists.
  - Status filter chips filter active, pending, and completed loans.
  - Tapping card opens `/rentals/:id`.
  - "View Handover Code" displays locker access PIN bottom sheet.
  - "Cancel Request" triggers cancellation confirmation dialog.
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/rentals?role=borrower`, `GET /api/v1/rentals?role=lender`)

---

### 13. Rental Details Lifecycle View
- **Flutter Route:** `/rentals/:id`
- **Planned Page / Widget:** `RentalDetailsPage` (`lib/features/rentals/presentation/rental_details_page.dart`)
- **Stitch Screen ID:** `c62c22cbedfa4cb7865a6d810a816154`
- **Components to Reuse:** `LifecycleTrackerWidget`, `CounterpartyCard`, `SmartLockerAccessCard`, `InspectionChecklist`, `StickyActionDock`
- **Data Needed:** Full rental model (`id`, `equipment`, `lender`, `borrower`, `status`, `timeline`, `dates`, `lockerPin`, `barcode`, `financials`, `checklist`)
- **Interaction Behaviour:**
  - 4-step timeline displays current loan progress.
  - Copy button copies locker PIN `8492` to clipboard.
  - QR barcode modal expands for kiosk scanner.
  - Pre-return checklist items toggle completion.
  - Sticky primary button conditionally renders action based on state:
    - *Pending (Lender):* "Approve Request" / "Decline"
    - *Approved (Borrower):* "Unlock Locker 14B"
    - *Active (Borrower):* "Initiate Return at Locker →"
    - *Completed:* "Leave Review ★"
  - "Request Extension" triggers date picker dialog.
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/rentals/{id}`, `POST /api/v1/rentals/{id}/action`)

---

### 14. Notification Centre
- **Flutter Route:** `/notifications`
- **Planned Page / Widget:** `NotificationCentrePage` (`lib/features/notifications/presentation/notification_centre_page.dart`)
- **Stitch Screen ID:** `bb3a18ecd2454b5485856eae0b16125d`
- **Components to Reuse:** `NotificationCard`, `FilterChipGroup`, `BottomNavBar`
- **Data Needed:** List of notification events (`id`, `title`, `body`, `type`, `isRead`, `timestamp`, `actionPayload`)
- **Interaction Behaviour:**
  - Filters alerts by `All`, `Requests`, `Reminders`, and `Updates`.
  - Tapping "Accept/Decline" calls rental state transition.
  - Tapping "View Locker PIN" navigates to `/rentals/:id`.
  - "Mark all as read" clears all unread indicators.
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/notifications`, `PATCH /api/v1/notifications/mark-read`)

---

### 15. Student Profile
- **Flutter Route:** `/profile`
- **Planned Page / Widget:** `StudentProfilePage` (`lib/features/profile/presentation/student_profile_page.dart`)
- **Stitch Screen ID:** `bd355ca586474df9bed233da64280af7`
- **Components to Reuse:** `ProfileHeaderCard`, `TrustMetricsGrid`, `CampusHubCard`, `SettingsListTile`, `BottomNavBar`
- **Data Needed:** Student user model (`name`, `avatarUrl`, `university`, `department`, `graduationYear`, `isEduVerified`, `reputationRating`, `onTimeRate`, `borrowCount`, `listCount`, `preferredHub`)
- **Interaction Behaviour:**
  - Gear icon opens `/settings`.
  - List items navigate to `/my-listings`, `/rentals`, or verification workflows.
  - Preferred hub edit action triggers hub selector modal.
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/users/me`)

---

### 16. Settings
- **Flutter Route:** `/settings`
- **Planned Page / Widget:** `SettingsPage` (`lib/features/settings/presentation/settings_page.dart`)
- **Stitch Screen ID:** `076943b9f57a421f9f5f62ac002ce8bb`
- **Components to Reuse:** `ThemeSelectorCard`, `SettingsSectionCard`, `ToggleSwitchTile`, `DestructiveButton`
- **Data Needed:** User app preferences (`themeMode`, `twoFactorEnabled`, `requestAlerts`, `returnReminders`, `weeklyDigest`, `autoDispatchPin`, `preferredHub`)
- **Interaction Behaviour:**
  - Segmented control toggles app `ThemeMode` (`light`, `dark`, `system`).
  - Switches update notification and security preferences.
  - "Sign Out" displays confirmation dialog, clears secure token cache, and routes to `/auth/sign-in`.
- **Backend Endpoint:** `TBD` (e.g. `GET /api/v1/users/me/preferences`, `PATCH /api/v1/users/me/preferences`, `POST /api/v1/auth/logout`)

---

## 3. Shared Reusable Widget Inventory

| Component Name | File Path | Usage Across Screens |
| :--- | :--- | :--- |
| `PrimaryButton` | `lib/core/widgets/primary_button.dart` | Onboarding, Sign In, Registration, Details, Listing Form, Booking, Settings |
| `CustomTextField` | `lib/core/widgets/custom_text_field.dart` | Sign In, Registration, Listing Form, Search |
| `EquipmentCard` | `lib/core/widgets/equipment_card.dart` | Home Dashboard, Search Results |
| `ListingManagementCard`| `lib/core/widgets/listing_management_card.dart` | My Equipment Listings |
| `RentalActivityCard` | `lib/core/widgets/rental_activity_card.dart` | Rental Activity & Bookings |
| `FilterBottomSheet` | `lib/core/widgets/filter_bottom_sheet.dart` | Equipment Search |
| `StickyActionDock` | `lib/core/widgets/sticky_action_dock.dart` | Equipment Details, Listing Form, Rental Request, Rental Details |
| `BottomNavBar` | `lib/core/widgets/bottom_nav_bar.dart` | Home, Search, Rentals, Profile, Notifications |
| `TrustBadge` | `lib/core/widgets/trust_badge.dart` | Sign In, Details, Profile, Rental Details |
