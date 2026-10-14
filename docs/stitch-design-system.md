# EquipLink — Stitch Design System (Audit & Reference)

**Project ID:** `7305517365938937763`  
**Design System Asset ID:** `assets/6753531371765945936`  
**Brand Identity:** EquipLink — Borrow Smart. Lend Easy.  

---

## 1. Design Token Taxonomy

### Verified Stitch Core Tokens (Extracted directly from Stitch Design System)

| Token Key | Verified Hex | Stitch Role | Mobile Usage in EquipLink |
| :--- | :--- | :--- | :--- |
| `primary` | `#143F5B` (`#002940` deep) | Primary Brand Accent | App headers, primary CTA buttons, high-contrast active tabs |
| `primary_container` | `#143F5B` / `#ADD3F6` | Primary Container | Featured cards, prominent hero banners |
| `secondary` | `#147D77` (`#006B65`) | Secondary Accent | Interactive chips, accent actions, quick filters |
| `secondary_container` | `#99F2EA` (`#96EFE7`) | Accent Tint Container | Soft badge containers, active filter indicators |
| `tertiary` | `#10B981` (`#5A5B85` sys) | Affirmative / Verified | Verified student shield badges, approved loan statuses |
| `background` | `#F5F8FC` (`#FAF8FF`) | Base Canvas | Page background for all mobile flows |
| `surface` | `#FFFFFF` (`#F7FAFE`) | Card & Sheet Surface | Form containers, equipment listing cards, modal sheets |
| `surface_container` | `#E8EFF5` / `#EAEDFF` | Input / Sub-surface | Search input background, disabled field containers |
| `on_surface` | `#0F172A` (`#131B2E`) | Text Primary | High-contrast headers, equipment titles, prices |
| `on_surface_variant` | `#475569` (`#576067`) | Text Secondary | Metadata, categories, subtitles, helper labels |
| `outline` | `#CBD5E1` (`#737C83`) | Border / Hairlines | Input borders, card dividers (1px solid) |
| `outline_variant` | `#E2E8F0` (`#AAB3BB`) | Subtle Border | Container borders, subtle card edges |
| `error` | `#BA1A1A` (`#A83836`) | Destructive / Error | Validation errors, cancel actions, sign out button |

### Proposed Fallback Tokens (App-Level Extensions Not Explicit in Stitch Theme)

| Token Name | Proposed Value | Status | Purpose & Application |
| :--- | :--- | :---: | :--- |
| `warning_amber` | `#F59E0B` | *Proposed Fallback* | Pending approval badges, return countdowns under 48 hours |
| `warning_container` | `#FEF3C7` | *Proposed Fallback* | Background container for pending/urgent alerts |
| `locker_accent` | `#0284C7` | *Proposed Fallback* | Smart campus locker PIN cards & IoT indicator |
| `dark_background` | `#101923` | *Proposed Fallback* | Optional high-contrast dark theme canvas |
| `dark_surface` | `#1E293B` | *Proposed Fallback* | Optional high-contrast dark theme card surface |

---

## 2. Typography Scale (Inter)

All typography uses the **Inter** sans-serif font family:

| Style Token | Font Size | Weight | Line Height | Letter Spacing | Target Elements |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `headline-xl` | 28px–32px | Bold (700) | 36px | -0.02em | Onboarding hero, primary screen headers |
| `headline-lg` | 22px–24px | Semi-Bold (600)| 30px | -0.015em | Top bar titles, section major titles |
| `headline-md` | 18px–20px | Semi-Bold (600)| 26px | -0.01em | Equipment titles, card group headers |
| `headline-sm` | 16px | Semi-Bold (600)| 22px | 0.0em | Subheadings, card titles |
| `body-lg` | 16px | Regular (400) | 24px | 0.0em | Equipment descriptions, long-form content |
| `body-md` | 14px | Regular (400) | 20px | 0.0em | Standard input text, list subtitles |
| `body-sm` | 12px | Regular (400) | 16px | 0.0em | Captions, timestamps, helper notices |
| `label-lg` | 14px | Semi-Bold (600)| 20px | 0.01em | Primary & secondary button text |
| `label-md` | 12px | Medium (500) | 16px | 0.01em | Filter chips, tab labels |
| `label-sm` | 11px | Semi-Bold (600)| 14px | 0.04em | Status pills, condition badges |

---

## 3. Spacing & Elevation System

- **Base Layout Grid:** 8pt base grid with a 4pt micro-adjustment subgrid.
- **Outer Canvas Margins:** 16px (`1rem`) horizontal padding for portrait mobile layouts.
- **Card Padding:** 16px inner padding across cards, sheets, and modals.
- **Corner Radii (`roundness`):**
  - Buttons & Inputs: `12px` (`rounded-xl`)
  - Content Cards & Modals: `12px` (`rounded-xl`)
  - Status Pills & Category Chips: `9999px` (Full pill shape)
- **Elevations (Shadows):**
  - Level 1 (Cards): `box-shadow: 0 1px 3px rgba(20, 63, 91, 0.04), 0 1px 2px rgba(20, 63, 91, 0.02)`
  - Level 2 (Active / Bottom Sheets): `box-shadow: 0 4px 6px -1px rgba(20, 63, 91, 0.08)`
  - Level 3 (Sticky Action Bars): `box-shadow: 0 -4px 12px rgba(20, 63, 91, 0.06)`

---

## 4. Reusable Mobile Component Patterns

### Equipment Card Pattern
- **Dimensions / Container:** White surface, 12px radius, 1px `#E2E8F0` border, soft elevation.
- **Thumbnail:** 72x72px or 80x80px rounded-lg squircle gear thumbnail on left.
- **Content:** Title in `headline-sm`, Category & Condition pills, Daily & Weekly rate breakdown in `primary`, Campus pickup hub pin, and Lender rating badge (e.g. `Marcus T. · ★ 4.9`).

### Sticky Bottom Action Bar Pattern
- **Docking:** Fixed at bottom with `bg-white/95 backdrop-blur`, 1px top border `#E2E8F0`, 16px horizontal padding.
- **Layout:** Pricing/summary recap on left + full-width primary CTA button on right (height ≥ 48px, 12px radius, deep navy fill `#143F5B`, white text).

### Verification Badge Pattern
- **Structure:** Shield or check icon + uppercase or title-case text in `tertiary` (`#10B981`) or `secondary` (`#147D77`).
- **Institutional Context:** Represents verified `.edu` college student standing and signed Campus Honor Code agreement.
