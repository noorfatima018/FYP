# RentWise Project Memory & Architecture Context

## Overview
**RentWise** is a Next.js-based Peer-to-Peer Rental Management Platform equipped with AI risk assessment and protection features for renting high-value assets.

---

## Technical Stack
- **Framework**: Next.js 16 (App Router with Turbopack)
- **Library**: React 19
- **Styling**: Tailwind CSS v4 + Custom Utilities
- **Language**: TypeScript (`strict: true`)
- **Fonts**: `Plus Jakarta Sans` via `next/font/google`
- **Media**: Animated logo showcase (`.webm` with alpha channel and `.mp4` fallback)

---

## Directory & File Structure
```
web/
├── design.md                 # Design system documentation
├── memory.md                 # Project architecture & state memory
├── public/
│   ├── logo.png              # Primary static logo mark
│   ├── animate_my_logo.webm  # Transparent animated logo video
│   ├── animate_my_logo.mp4   # Fallback animated logo video
│   └── sitemap.xml           # Static XML sitemap
└── src/
    ├── app/
    │   ├── error.tsx         # Global App Router error boundary
    │   ├── globals.css       # Tailwind imports & global styles
    │   ├── layout.tsx        # Root HTML & body layout wrapper
    │   ├── page.tsx          # Root route (renders AuthScreen)
    │   ├── robots.ts         # Dynamic robots.txt metadata handler
    │   ├── sitemap.ts        # Dynamic sitemap generator
    │   ├── login/
    │   │   └── page.tsx      # Sign In page (/login)
    │   └── register/
    │       └── page.tsx      # Sign Up page (/register)
    └── components/
        └── AuthScreen.tsx    # Combined Sign-In & Sign-Up Auth Component
```

---

## Key Customizations & Architectural Notes
1. **Header Minimalism**: The top logo/name headers were intentionally removed from both mobile hero top bar and desktop web view in `AuthScreen.tsx` to maintain a ultra-clean, video-focused authentication flow.
2. **Button Hover Palette**: The primary button hover state is mapped to `#153A5F` (Refined Navy Blue) rather than near-black tones to preserve brand color harmony.
3. **Transparent Video Rendering**: Animated logo video uses `mix-blend-multiply` styling to blend seamlessly into the warm cream container (`#EFE6D5`).
