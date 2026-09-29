# RentWise Mobile Design System & Guidelines

## Overview
RentWise Mobile is built in **Flutter** with design tokens and UX consistency matching the web platform. The app is crafted to convey trust, clarity, warmth, and modern elegance.

---

## 1. Color Palette

| Token | Hex Value / Flutter Color | Usage |
| :--- | :--- | :--- |
| **Primary Navy** | `#0A2947` / `AppColors.navyPrimary` | Primary solid buttons, dominant headers, key text |
| **Warm Brown Accent** | `#8B5E3C` / `AppColors.brownAccent` | Field labels, icon accents, active focus rings, links |
| **Cream Canvas** | `#EFE6D5` / `AppColors.creamCanvas` | Splash background & top hero curved container |
| **Cream Page Background** | `#FAF6EE` / `AppColors.creamBg` | App body background |
| **Light Warm Sand** | `#F3E7D5` / `AppColors.sandContainer` | Segmented pill background |
| **Hover / Accent Navy** | `#153A5F` / `AppColors.navyHover` | Button tap & highlight elevation |
| **Pure White** | `#FFFFFF` / `AppColors.white` | Form fields, active pill background |
| **Muted Border** | `#E3D7C2` / `AppColors.borderMuted` | Input borders & container dividers |

---

## 2. Typography
- **Font**: `Plus Jakarta Sans` via `google_fonts` package.
- **Headings**: Bold, letter-spacing `-0.8`, `AppColors.navyPrimary`.
- **Labels**: 11px uppercase feel, Bold, `AppColors.brownAccent`.
- **Buttons**: 15px Bold, White text.

---

## 3. Screen Flows

### 1. Splash / Logo Animation Screen (`SplashScreen`)
- Plays `assets/videos/animate_my_logo.mp4` once on the cream canvas (`#EFE6D5`).
- Includes a top-right "Skip" action.
- Automatically transitions using a smooth fade and subtle upward slide into the **AuthScreen** when the animation finishes.

### 2. Authentication Screen (`AuthScreen`)
- **Top Curved Hero**: Features brand asset on `#EFE6D5` backdrop.
- **Segmented Pill**: Interactive tab toggle between `Sign In` and `Sign Up`.
- **Custom Text Fields**: Rounded borders (`16px`), circular icon indicators, warm brown focus glow.
- **Action Button**: Primary Navy pill button with micro-press physics and loading indicator.
- **State Management**: Powered by **Riverpod** (`authProvider`).
