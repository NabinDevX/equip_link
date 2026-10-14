# EquipLink — Stitch Screen Manifest (Phase 5 Audit & Handoff)

**Project ID:** `7305517365938937763`  
**Design System Asset ID:** `assets/6753531371765945936`  
**Audit Status:** Fully Verified — 16 of 16 Requirements Mapped & Verified (+ 1 Brand Asset)  
**Target Platform:** Mobile (Flutter / Dart)  

---

## 1. Verified Screen Inventory & Route Mapping

| # | Requirement Name | Stitch Screen Title | Stitch Screen ID | Intended Flutter Route | Status | Dimensions |
|---|------------------|---------------------|------------------|------------------------|:------:|:----------:|
| 1 | **Onboarding** | `EquipLink - Mobile Onboarding` | `28575c6fffaf44b6ba10080e7320164a` | `/onboarding` | **Verified** | 780x1768 |
| 2 | **Sign In** | `EquipLink - Student Sign In` | `cbeb998385ed4debb331f4c418dab999` | `/auth/sign-in` | **Verified** | 780x1768 |
| 3 | **Student Registration** | `EquipLink - Student Registration` | `62a50b06ff7e4be9ab43130642b3b160` | `/auth/register` | **Verified** | 2560x2048 |
| 4 | **College Email Verification** | `EquipLink - Email Verification` | `7c4d5eed9f5049de959b38b8f3d99d58` | `/auth/verify-email` | **Verified** | 780x1768 |
| 5 | **Password Recovery** | `EquipLink - Password Recovery` | `37dd1bb9deaa4d4eb8491deba92a90af` | `/auth/forgot-password` | **Verified** | 780x1768 |
| 6 | **Home Dashboard** | `EquipLink - Campus Home Dashboard` | `abe361cf113b4b388f50c9cbc6146eca` | `/home` | **Verified** | 780x2364 |
| 7 | **Equipment Search & Filters** | `EquipLink - Equipment Search & Filter` | `522ba4a277ed44c59ee7fc671ffbb23b` | `/search` | **Verified** | 780x2034 |
| 8 | **Equipment Details** | `EquipLink - Equipment Details` | `f1dc18ccf9724a42b68b00e591516339` | `/equipment/:id` | **Verified** | 780x3266 |
| 9 | **Create / Edit Listing** | `EquipLink - Create & Edit Listing` | `41c8cd516489499bb482156dda9b1564` | `/listings/edit` | **Verified** | 780x3288 |
| 10 | **My Equipment Listings** | `EquipLink - My Equipment Listings` | `4876ad513789463b958af409f555154d` | `/my-listings` | **Verified** | 780x2892 |
| 11 | **Rental Request** | `EquipLink - Rental Request & Booking` | `bfe5954028504205bc4597179c0afd9d` | `/equipment/:id/request` | **Verified** | 780x2426 |
| 12 | **Rental Activity** | `EquipLink - Rental Activity & Bookings` | `e1ae92c1b5334d5899e943f9c673449b` | `/rentals` | **Verified** | 780x2596 |
| 13 | **Rental Details** | `EquipLink - Rental Details #EQ-8841` | `c62c22cbedfa4cb7865a6d810a816154` | `/rentals/:id` | **Verified** | 780x3604 |
| 14 | **Notification Centre** | `EquipLink - Notification Centre` | `bb3a18ecd2454b5485856eae0b16125d` | `/notifications` | **Verified** | 780x2126 |
| 15 | **Student Profile** | `EquipLink - Student Profile` | `bd355ca586474df9bed233da64280af7` | `/profile` | **Verified** | 780x2728 |
| 16 | **Settings** | `EquipLink - Settings` | `076943b9f57a421f9f5f62ac002ce8bb` | `/settings` | **Verified** | 780x3080 |

*(Companion Logo Asset: `b267484930b24f09bbfce19b824a4430` — "EquipLink Logo Badge")*

---

## 2. Screen Specifications & Interaction Details

### 1. Onboarding (`28575c6fffaf44b6ba10080e7320164a`)
- **Route:** `/onboarding`
- **Key Elements:** Branded app bar, collegiate gear exchange vector hero illustration, headline "Borrow Smart. Lend Easy.", academic discipline pills (Lab & Science, Cameras, Calculators, STEM), and full-width "Get Started" CTA with "Sign In" anchor.
- **Interactions:** "Get Started" navigates to `/auth/register`; "Sign In" navigates to `/auth/sign-in`.

### 2. Sign In (`cbeb998385ed4debb331f4c418dab999`)
- **Route:** `/auth/sign-in`
- **Key Elements:** College Email (.edu) input, secure password field with visibility eye toggle, "Forgot Password?" link, high-contrast navy "Sign In" button, and campus network trust badge.
- **Interactions:** Validation of .edu email; password toggle state; "Sign In" navigates to `/home`; "Forgot Password" to `/auth/forgot-password`; bottom anchor to `/auth/register`.

### 3. Student Registration (`62a50b06ff7e4be9ab43130642b3b160`)
- **Route:** `/auth/register`
- **Key Elements:** Full Name, .edu College Email with requirement badge, University dropdown selector, Password with 8-character indicator, Confirm Password with match check, and Honor Code checkbox.
- **Interactions:** Form validation across fields; terms check requirement; "Continue to Verification →" navigates to `/auth/verify-email`.

### 4. College Email Verification (`7c4d5eed9f5049de959b38b8f3d99d58`)
- **Route:** `/auth/verify-email`
- **Key Elements:** Verification shield icon, email pill (`alex.rivera@stanford.edu`) with inline "Edit" trigger, 6-digit numeric OTP code input slots with active focus, resend countdown timer (0:45), and magic link fallback.
- **Interactions:** Auto-advancing OTP digits; resend countdown timer reset; "Verify & Continue" completes auth and routes to `/home`.

### 5. Password Recovery (`37dd1bb9deaa4d4eb8491deba92a90af`)
- **Route:** `/auth/forgot-password`
- **Key Elements:** Lock-and-refresh reset graphic, .edu email input, "Send Reset Instructions" primary CTA, and an integrated inline confirmation banner showing link expiration and resend link.
- **Interactions:** Email submission triggers inline success confirmation banner; "Return to Sign In" navigates to `/auth/sign-in`.

### 6. Home Dashboard (`abe361cf113b4b388f50c9cbc6146eca`)
- **Route:** `/home`
- **Key Elements:** Personalized greeting ("Hi, Alex 👋"), verified avatar, notification bell with unread dot, search entry bar pill, academic category carousel, "+ Lend Gear" banner, and recently listed gear cards (TI-84 CE, Rigol Oscilloscope, Sony Alpha, Fluke Multimeter).
- **Interactions:** Search bar tap opens `/search`; category taps filter discovery; gear card taps navigate to `/equipment/:id`; "+ Lend Gear" routes to `/listings/edit`; bottom nav switches between core tabs.

### 7. Equipment Search & Filters (`522ba4a277ed44c59ee7fc671ffbb23b`)
- **Route:** `/search`
- **Key Elements:** Multi-term search bar with clear button, results count ("18 items found"), sort dropdown ("Lowest Price"), active filter chips, and slide-up Filter Bottom Sheet Modal with categories, price slider ($0–$50/day), condition checkboxes, campus pickup hubs, and immediate availability toggle.
- **Interactions:** Live query filtering; bottom sheet toggle; filter chip dismiss; card tap opens `/equipment/:id`.

### 8. Equipment Details (`f1dc18ccf9724a42b68b00e591516339`)
- **Route:** `/equipment/:id`
- **Key Elements:** Top bar with back button and bookmark/share actions, Fluke 117 Multimeter lab photo gallery with "1 / 4" indicator, transparent pricing card ($6/day, $22/week) with $0 deposit guarantee, academic description and accessories checklist, verified lender profile (Marcus T. ★ 4.9) with inquiry chat trigger, and sticky bottom "Request to Borrow" CTA bar.
- **Interactions:** Photo swipe/zoom; "Ask Marcus" initiates chat; sticky "Request to Borrow" navigates to `/equipment/:id/request`.

### 9. Create / Edit Listing (`41c8cd516489499bb482156dda9b1564`)
- **Route:** `/listings/edit`
- **Key Elements:** Single reusable form for new item publishing or editing. Photo uploader with primary cover card and dashed "+ Add Photos" slot, item name, category dropdown, condition radio chips, description with character counter, daily and weekly rates, $0 deposit default, campus pickup hub selector, and immediate availability toggle switch.
- **Interactions:** Photo picker and deletion; rate discount auto-calculation; form validation; sticky "Publish Listing →" creates/updates item and redirects to `/my-listings`.

### 10. My Equipment Listings (`4876ad513789463b958af409f555154d`)
- **Route:** `/my-listings`
- **Key Elements:** Lender performance summary ($68 earned, 3 active items, 2 pending requests), status chips ("All", "Active", "Currently Rented", "Paused"), listing management cards with status pills, edit shortcuts, pause toggles, and urgent request review alerts ("1 New Rental Request Waiting").
- **Interactions:** Status filtering; pause/activate toggles; "Edit Listing" opens `/listings/edit`; review banner links to `/rentals`.

### 11. Rental Request & Booking (`bfe5954028504205bc4597179c0afd9d`)
- **Route:** `/equipment/:id/request`
- **Key Elements:** Gear and lender recap, interactive pickup and return date cards with 4-day loan badge, contactless locker vs in-person handoff radio selection, optional lender message input, and itemized cost breakdown ($24.00 base, -$4.00 discount, $1.50 campus fee, $21.50 total) with deferred charge notice.
- **Interactions:** Date picker modal; handoff method toggle; sticky "Send Rental Request →" submits booking and navigates to `/rentals/:id`.

### 12. Rental Activity & Bookings (`e1ae92c1b5334d5899e943f9c673449b`)
- **Route:** `/rentals`
- **Key Elements:** Segmented control toggling between "Borrowing (2)" and "Lending (2)" views, horizontal status filter chips (All, Active, Pending, Completed, Cancelled), and role-aware cards for active loans with progress bars and countdowns, pending lender reviews, and completed loans with review actions.
- **Interactions:** Segment toggle; status filtering; card tap opens `/rentals/:id`; "View Handover Code" triggers locker PIN display; "Cancel Request" with confirmation dialog.

### 13. Rental Details Lifecycle View (`c62c22cbedfa4cb7865a6d810a816154`)
- **Route:** `/rentals/:id`
- **Key Elements:** 4-step horizontal lifecycle timeline tracker (Requested → Approved → Handover → Return Due), gear overview with countdown alert, lender profile card with message trigger, Campus Smart Locker 14B card with digital return PIN (`8 4 9 2`) and QR barcode pass, pre-return accessories checklist, and sticky bottom actions ("Initiate Return at Locker →", "Request Extension").
- **Interactions:** Copy PIN to clipboard; return checklist toggles; "Initiate Return" prompts locker return confirmation; "Request Extension" triggers date picker dialog.

### 14. Notification Centre (`bb3a18ecd2454b5485856eae0b16125d`)
- **Route:** `/notifications`
- **Key Elements:** Back button, "Mark all as read" action, filter chips (All, Requests, Reminders, Updates), and distinct alert cards with teal/amber unread indicators and inline actions (Accept/Decline rental request, View Locker Return PIN).
- **Interactions:** Filter chips; "Accept/Decline" calls rental state transitions; "View Locker PIN" navigates to `/rentals/:id`; "Mark all as read" clears unread badges.

### 15. Student Profile (`bd355ca586474df9bed233da64280af7`)
- **Route:** `/profile`
- **Key Elements:** Profile photo, Stanford student affiliation, verified .edu shield badge, 4-metric peer trust grid (★ 4.9 rating, 100% on-time, 8 loans, 3 listed), default campus pickup hub card, and management shortcuts with chevrons to My Listings, Rental Activity, Verification, and Settings.
- **Interactions:** Top-right gear icon opens `/settings`; list items navigate to their respective screens; avatar tap triggers photo upload.

### 16. Settings (`076943b9f57a421f9f5f62ac002ce8bb`)
- **Route:** `/settings`
- **Key Elements:** Segmented 3-option theme picker (Light [active], Dark, System), account and security controls with 2FA toggle, push/email notification switches for requests and return reminders, default campus pickup hub selector, Honor Code policy and help center links, and a prominent destructive "Sign Out" button.
- **Interactions:** Theme selection updates app theme; toggles switch settings locally and remotely; "Sign Out" triggers confirmation dialog and redirects to `/auth/sign-in`.

---

## 3. Tool Artifact Retrieval Capabilities & Limitations

- **Accessible via MCP:**
  - Screen IDs, Resource names, and titles.
  - Rendered mobile screenshots via Google Usercontent URLs (`downloadUrl`).
  - Compiled HTML/CSS code via contribution storage URLs.
  - Dimensions, aspect ratios, and device form factors.
- **Known Limitations:**
  - Raw interactive DOM trees, component-level ASTs, and Figma vector node hierarchies are not directly returned as structured JSON by the Stitch MCP schema. Visual fidelity and tokens must be mapped from the HTML/CSS payloads and verified design system definitions into native Flutter widgets.
