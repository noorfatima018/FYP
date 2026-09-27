# RentWise Design System & Aesthetics Guidelines

## Overview
RentWise is a modern, high-trust Peer-to-Peer Rental Management Platform equipped with AI risk protection. The UI/UX is built to convey trust, warmth, elegance, and effortless clarity.

---

## 1. Color Palette

| Token | Hex Value | Description & Usage |
| :--- | :--- | :--- |
| **Primary Navy** | `#0A2947` | Primary brand color, dominant headers, primary solid buttons, key text |
| **Warm Brown Accent** | `#8B5E3C` | Secondary accent, brand wordmark ("Wise"), input field labels & icon accents |
| **Cream Canvas** | `#EFE6D5` | Right-side video canvas background, mobile top hero section |
| **Light Warm Sand** | `#F3E7D5` | Segmented pill container background, subtle inner container shadows |
| **Hover Navy** | `#153A5F` | Interactive primary button hover state (rich vibrant navy glow) |
| **Pure White** | `#FFFFFF` | Form container background, input field background, active pill background |
| **Muted Text / Border** | `#E3D7C2` / `gray-200` | Subtle container borders and divider lines |

---

## 2. Typography

- **Font Family**: `Plus Jakarta Sans` (Google Font)
- **Hierarchy**:
  - **H1 Headings**: 32px – 36px (`text-3xl` to `text-[2.25rem]`), Bold (`font-bold`), Tracking Tight (`tracking-tight`), `#0A2947`
  - **Field Labels**: 11px (`text-[11px]`), Semibold (`font-semibold`), Uppercase feel/leading none, `#8B5E3C`
  - **Button Text**: 14px – 16px (`text-sm` / `text-base`), Bold (`font-bold`), White / `#0A2947`
  - **Body / Subtext**: 14px (`text-sm`), Semibold, `#0A2947`

---

## 3. Component Design Rules

### Segmented Pill Switcher
- Background: `#F3E7D5` with soft inner shadow.
- Active State: Pure white background `#FFFFFF`, `#0A2947` text with subtle drop shadow.
- Inactive State: Transparent background, `#8B5E3C` text, smooth hover transition.

### Input Fields
- Outer Pill: Soft rounded border (`rounded-2xl`), white background.
- Left Icon Circle: Soft brown tint background (`#8B5E3C`/10) with brown SVG icon.
- Focus State: Warm brown border (`#8B5E3C`) with subtle focus ring (`ring-2 ring-[#8B5E3C]/15`).

### Primary Buttons
- Geometry: Fully rounded (`rounded-full`), padded (`py-4 px-6`).
- Color: Solid `#0A2947` primary navy.
- Hover Effect: Vibrant `#153A5F` navy elevation without turning dark/black.
- Active Feedback: Micro-scaling (`active:scale-[0.99]`).

---

## 4. Mobile & Responsive Layout

- **Mobile View (< 1024px)**:
  - Top header features the rounded cream hero section (`#EFE6D5`) displaying the seamless transparent animated video.
  - Clean form section directly below with comfortable touch targets.
- **Desktop View (≥ 1024px)**:
  - 50/50 dual-column split layout.
  - Left column houses the authentication form centered vertically.
  - Right column houses the full-height organic canvas with curved background waves and seamless looping video showcase.
