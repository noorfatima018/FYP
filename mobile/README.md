# RentWise Mobile (Flutter)

Modern Flutter mobile application for **RentWise** – Peer-to-Peer Rental Management Platform with AI Risk Protection.

## Features
- **Splash / Logo Video Animation**: Plays the brand's animated logo once on launch with seamless auto-transition into the authentication flow.
- **Unified Auth Flow**: Toggle seamlessly between Sign In and Sign Up with real-time validation and loading feedback.
- **Riverpod State Management**: Scalable, testable, and reactive state architecture.
- **Design System Consistency**: 1:1 color palette and typography match with the web application (`Plus Jakarta Sans`, Primary Navy, Warm Brown, Cream Canvas).

## Folder Structure
```
mobile/
├── assets/
│   ├── images/               # logo.png
│   ├── videos/               # animate_my_logo.mp4
│   └── icons/                # Vector icons
├── lib/
│   ├── main.dart             # App entry point & ProviderScope
│   ├── core/
│   │   ├── constants/        # AppColors, AppStrings, AppAssets
│   │   ├── theme/            # AppTheme (Plus Jakarta Sans & Design tokens)
│   │   ├── utils/            # Validators & helpers
│   │   └── widgets/          # AppButton, AppTextField, SegmentedPill
│   ├── features/
│   │   ├── splash/           # SplashScreen (single-play logo animation & skip)
│   │   └── auth/             # AuthScreen, SignInForm, SignUpForm, AuthProvider
│   └── routes/
│       └── app_routes.dart   # Route generator & transitions
├── test/                     # Smoke and widget tests
└── pubspec.yaml
```

## Running the App

```bash
cd mobile
flutter run
```
