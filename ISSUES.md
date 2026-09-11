# 📋 TrustRent — Project Issues & Milestones
### Stack: Flutter (Mobile) · Next.js (Web) · Node.js/Express (Backend) · PostgreSQL

This file tracks all project milestones and their associated tasks. Each milestone is a major development phase of the TrustRent platform.

---

## 🗺️ Milestone Overview

| # | Milestone | Platform | Status |
|---|---|---|---|
| M1 | Project Setup & Architecture | All | 🔲 Planned |
| M2 | Design System & Shared UI | Flutter + Next.js | 🔲 Planned |
| M3 | User Authentication & Identity Verification | Flutter + Next.js + Backend | 🔲 Planned |
| M4 | Item Listing & Management | Flutter + Next.js + Backend | 🔲 Planned |
| M5 | Trust Score & Risk Engine | Backend | 🔲 Planned |
| M6 | Dynamic Deposit System | Backend + Flutter + Next.js | 🔲 Planned |
| M7 | Digital Rental Contract | Backend + Flutter + Next.js | 🔲 Planned |
| M8 | Item Condition Evidence System | Flutter + Next.js + Backend | 🔲 Planned |
| M9 | Rental Lifecycle & Return Monitoring | Backend + Flutter + Next.js | 🔲 Planned |
| M10 | Dispute Resolution System | Backend + Flutter + Next.js | 🔲 Planned |
| M11 | Notifications & Alerts | Flutter + Backend + Next.js | 🔲 Planned |
| M12 | Admin Panel | Next.js (Web only) | 🔲 Planned |
| M13 | (Optional) Computer Vision | Backend | 🔲 Planned |
| M14 | Testing, QA & Documentation | All | 🔲 Planned |

---

---

## 🏁 Milestone 1 — Project Setup & Architecture

> **Goal**: Establish the complete technical foundation — monorepo, database schema, backend scaffold, and baseline project structure for Flutter and Next.js.

---

### Issue #1 — Initialize Monorepo & Folder Structure

**Platform**: All  
**Labels**: `setup`

**Description**:  
Create the unified repository with clear folder separation between all three platforms.

```
trustrent/
├── mobile/          ← Flutter app
├── web/             ← Next.js web app
├── backend/         ← Node.js (Express) API
│   ├── src/
│   │   ├── routes/
│   │   ├── controllers/
│   │   ├── services/
│   │   │   ├── risk/
│   │   │   ├── trust/
│   │   │   ├── contracts/
│   │   │   └── evidence/
│   │   ├── middleware/
│   │   └── models/
├── database/        ← Migrations & seed scripts
└── docs/            ← Architecture, FYP report assets
```

**Tasks**:
- [ ] Create GitHub repository with `main` and `develop` branches
- [ ] Set up `.gitignore` for Flutter, Next.js, and Node.js
- [ ] Add `README.md`, `ISSUES.md`, `CONTRIBUTING.md`
- [ ] Configure branch protection rules (PRs required for `main`)
- [ ] Add monorepo `package.json` at root for shared scripts

---

### Issue #2 — Database Schema Design

**Platform**: Backend  
**Labels**: `database` `architecture`

**Description**:  
Design the complete relational schema for PostgreSQL.

**Core Tables**:

| Table | Key Fields |
|---|---|
| `users` | id, name, email, phone, cnic_hash, trust_score, verification_status, created_at |
| `items` | id, owner_id, title, category, value_pkr, risk_tier, daily_rate_pkr, is_available |
| `rental_requests` | id, item_id, renter_id, start_date, end_date, status, risk_score, deposit_required_pkr |
| `rentals` | id, request_id, contract_id, status, actual_return_date |
| `contracts` | id, rental_id, terms_json, owner_signed_at, renter_signed_at |
| `evidence` | id, rental_id, type (pre/post), uploaded_by, file_url, timestamp |
| `disputes` | id, rental_id, raised_by, type, status, resolution, resolution_notes |
| `trust_events` | id, user_id, event_type, delta, new_score, triggered_by_rental_id, timestamp |
| `notifications` | id, user_id, title, body, type, read, created_at |
| `reviews` | id, rental_id, reviewer_id, reviewee_id, rating, comment |

**Tasks**:
- [ ] Draw ER diagram (dbdiagram.io)
- [ ] Write SQL migration files in `database/migrations/`
- [ ] Write seed script with realistic test data
- [ ] Document schema in `docs/database-schema.md`

---

### Issue #3 — Backend API Scaffolding (Node.js + Express)

**Platform**: Backend  
**Labels**: `backend` `setup`

**Description**:  
Bootstrap the Express API server with all middleware, routing, and configuration.

**Tasks**:
- [ ] Initialize Node.js project with TypeScript (`ts-node`, `express`, `prisma` or `pg`)
- [ ] Set up `.env` config (DB URL, JWT secret, cloud storage keys)
- [ ] Configure middleware: CORS, body-parser, helmet, rate-limiter
- [ ] Connect to PostgreSQL (use Prisma ORM or `pg` directly)
- [ ] Create `GET /api/health` endpoint
- [ ] Set up structured error handling and logging (winston)
- [ ] Set up Swagger/OpenAPI docs scaffold at `/api/docs`

---

### Issue #4 — Flutter App Initialization

**Platform**: Flutter (Mobile)  
**Labels**: `flutter` `setup`

**Description**:  
Set up the Flutter project with all dependencies, folder structure, and state management.

**Flutter Packages**:
| Package | Purpose |
|---|---|
| `flutter_riverpod` or `bloc` | State management |
| `dio` | HTTP client |
| `go_router` | Navigation/routing |
| `shared_preferences` | Local storage (tokens) |
| `flutter_secure_storage` | Secure token storage |
| `image_picker` | Camera/gallery access |
| `firebase_messaging` | Push notifications |
| `flutter_local_notifications` | Local notification display |
| `cached_network_image` | Image caching |
| `intl` | Date/number formatting |

**Folder Structure**:
```
mobile/lib/
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── network/      ← Dio client + interceptors
├── features/
│   ├── auth/
│   ├── items/
│   ├── rentals/
│   ├── risk/
│   ├── contracts/
│   ├── evidence/
│   ├── disputes/
│   └── profile/
└── main.dart
```

**Tasks**:
- [ ] Initialize Flutter project with null safety
- [ ] Install all required packages (`pubspec.yaml`)
- [ ] Set up folder structure (feature-first architecture)
- [ ] Configure Dio with base URL and JWT interceptor
- [ ] Set up `go_router` with named routes for all screens
- [ ] Set up `Riverpod` providers (or Bloc cubits) scaffold
- [ ] Configure app theme (colors, fonts, spacing)
- [ ] Test run on Android emulator and iOS simulator

---

### Issue #5 — Next.js Web App Initialization

**Platform**: Next.js (Web)  
**Labels**: `nextjs` `setup`

**Description**:  
Set up the Next.js project with TypeScript, routing, state management, and API client.

**Packages**:
| Package | Purpose |
|---|---|
| `next` + `typescript` | Framework |
| `tailwindcss` or CSS Modules | Styling |
| `zustand` or `react-query` + `axios` | State + data fetching |
| `next-auth` | Authentication session management |
| `react-hook-form` + `zod` | Forms + validation |
| `react-hot-toast` | Notifications |
| `lucide-react` | Icons |
| `recharts` | Charts (admin dashboard) |

**Folder Structure**:
```
web/
├── app/                  ← Next.js App Router
│   ├── (auth)/           ← Login, Register, Verify
│   ├── (main)/
│   │   ├── dashboard/
│   │   ├── items/
│   │   ├── rentals/
│   │   ├── profile/
│   │   └── disputes/
│   └── admin/            ← Admin panel routes
├── components/
│   ├── ui/               ← Button, Input, Card, Badge
│   ├── risk/             ← RiskScoreCard, RiskBadge
│   ├── rentals/          ← RentalTimeline, ContractViewer
│   └── evidence/         ← EvidenceUploader, ImageCompare
├── lib/
│   ├── api.ts            ← Axios instance with interceptors
│   └── hooks/            ← Custom React hooks
└── types/                ← TypeScript interfaces
```

**Tasks**:
- [ ] Initialize Next.js with TypeScript and App Router
- [ ] Install and configure all packages
- [ ] Set up Axios client with JWT auth interceptor
- [ ] Set up `next-auth` session provider
- [ ] Configure global CSS / Tailwind design tokens
- [ ] Set up route groups for `(auth)`, `(main)`, and `admin`
- [ ] Test development server

---

---

## 🎨 Milestone 2 — Design System & Shared UI

> **Goal**: Build the visual design system for both Flutter and Next.js before building features, so all UI is consistent.

---

### Issue #6 — Flutter Design System

**Platform**: Flutter  
**Labels**: `flutter` `design`

**Description**:  
Define the complete visual design system used throughout the Flutter app.

**Design Tokens**:
```dart
// Colors
primaryColor: Color(0xFF1A73E8)       // Trust blue
dangerColor: Color(0xFFE53935)        // High risk red
warningColor: Color(0xFFFB8C00)       // Medium risk orange
successColor: Color(0xFF43A047)       // Low risk green
backgroundDark: Color(0xFF0F172A)     // Dark surface
surfaceColor: Color(0xFF1E293B)       // Card surface
```

**Tasks**:
- [ ] Define `AppColors`, `AppTypography`, `AppSpacing` in `core/theme/`
- [ ] Create `AppTheme` with `ThemeData` (light + dark)
- [ ] Build reusable widgets:
  - `AppButton` (primary, secondary, danger variants)
  - `AppTextField` (with validation states)
  - `AppCard` (standard card container)
  - `RiskBadge` (green/orange/red pill)
  - `TrustScoreGauge` (animated circular indicator)
  - `VerificationBadge` (email/phone/CNIC status icons)
  - `StatusChip` (rental status indicator)
  - `AppBottomNav` (5-tab navigation bar)
- [ ] Build splash screen and onboarding screens
- [ ] Document widget library in `docs/flutter-widgets.md`

---

### Issue #7 — Next.js Design System

**Platform**: Next.js  
**Labels**: `nextjs` `design`

**Description**:  
Build the shared component library and design system for the web application.

**Tasks**:
- [ ] Define CSS variables / Tailwind config for brand colors, typography, spacing
- [ ] Build base UI components:
  - `Button` (primary, secondary, destructive, outline variants)
  - `Input`, `Textarea`, `Select` (with error states)
  - `Card`, `CardHeader`, `CardBody`
  - `Badge` (status colors)
  - `RiskScoreCard` — displays risk %, label, recommended deposit
  - `TrustScoreMeter` — animated horizontal progress bar
  - `VerificationStatus` — icon row showing email/phone/CNIC status
  - `Alert` (info, success, warning, error)
  - `Modal` / `Dialog`
  - `Skeleton` loaders
- [ ] Set up responsive layout: `Sidebar + TopNav` for desktop, hamburger for mobile
- [ ] Set up `<RootLayout>` with session provider, toast provider
- [ ] Create landing/marketing page (`/`) for the platform

---

---

## 🔐 Milestone 3 — User Authentication & Identity Verification

> **Goal**: Users can register, log in, and complete multi-step identity verification on both platforms.

---

### Issue #8 — Auth API Endpoints

**Platform**: Backend  
**Labels**: `auth` `backend`

**Tasks**:
- [ ] `POST /api/auth/register` — create user, send email OTP
- [ ] `POST /api/auth/login` — return JWT access + refresh token
- [ ] `POST /api/auth/logout` — invalidate refresh token
- [ ] `POST /api/auth/refresh` — issue new access token from refresh
- [ ] `POST /api/auth/verify-email` — validate email OTP
- [ ] `POST /api/auth/verify-phone` — validate SMS OTP (Twilio or local SMS)
- [ ] `POST /api/users/verify-cnic` — accept CNIC image upload, store hash
- [ ] Implement bcrypt password hashing
- [ ] Implement JWT middleware for protected routes
- [ ] Rate-limit OTP endpoints (max 5 attempts)

---

### Issue #9 — Flutter Auth Screens

**Platform**: Flutter  
**Labels**: `flutter` `auth`

**Screens to build**:
- [ ] **Splash Screen** — logo animation → redirect to login or home
- [ ] **Register Screen** — name, email, phone, password + confirm
- [ ] **Login Screen** — email/password, "Forgot Password" link
- [ ] **Email OTP Screen** — 6-digit OTP input with resend timer
- [ ] **Phone OTP Screen** — SMS OTP input
- [ ] **Verification Hub Screen** — shows email ✅ / phone ✅ / CNIC ⏳ status
- [ ] **CNIC Upload Screen** — camera/gallery for front + back photo, upload button
- [ ] All screens use Riverpod for state, Dio for API calls
- [ ] Handle loading, error, and success states with proper UX

---

### Issue #10 — Next.js Auth Pages

**Platform**: Next.js  
**Labels**: `nextjs` `auth`

**Pages to build**:
- [ ] `/register` — registration form with client-side validation (react-hook-form + zod)
- [ ] `/login` — login form, `next-auth` credentials provider
- [ ] `/verify/email` — OTP entry page
- [ ] `/verify/phone` — OTP entry page
- [ ] `/verify/cnic` — CNIC image uploader (drag-and-drop + file picker)
- [ ] `/verify` — verification status hub
- [ ] Protect routes with `next-auth` middleware (`middleware.ts`)
- [ ] Show verification badge status on all auth-gated pages

---

### Issue #11 — User Profile API & Pages

**Platform**: Backend + Flutter + Next.js  
**Labels**: `profile`

**Tasks**:
- [ ] `GET /api/users/me` — fetch current user profile
- [ ] `PUT /api/users/me` — update name, profile photo
- [ ] `GET /api/users/:id/trust-score` — public trust score
- [ ] `GET /api/users/:id/reviews` — reviews received
- [ ] Flutter: Profile screen with trust gauge, verification badges, rental history tabs
- [ ] Next.js: `/profile` page with same information in web layout
- [ ] Profile photo upload (Firebase Storage / Cloudinary)

---

---

## 📦 Milestone 4 — Item Listing & Management

> **Goal**: Owners can list items. Renters can browse, search, and view item details on both platforms.

---

### Issue #12 — Item API Endpoints

**Platform**: Backend  
**Labels**: `backend` `items`

**Tasks**:
- [ ] `POST /api/items` — create item (owner only)
- [ ] `PUT /api/items/:id` — update item (owner only)
- [ ] `DELETE /api/items/:id` — soft delete item
- [ ] `GET /api/items` — paginated list with query filters (category, city, value range, availability)
- [ ] `GET /api/items/:id` — item detail with owner public profile
- [ ] Upload up to 8 item photos to cloud storage
- [ ] Auto-assign `risk_tier` based on `value_pkr`:
  - Tier 1: < 5,000 PKR
  - Tier 2: 5,000–50,000 PKR
  - Tier 3: > 50,000 PKR (requires renter CNIC)

---

### Issue #13 — Flutter Item Screens

**Platform**: Flutter  
**Labels**: `flutter` `items`

**Screens**:
- [ ] **Home / Browse Screen** — item grid with search bar and category filters
- [ ] **Item Detail Screen** — photo carousel, description, owner card, risk tier badge, "Request Rental" button
- [ ] **My Listings Screen** — owner's listed items with edit/delete
- [ ] **Add/Edit Item Screen** — form with image picker (multi-image), category, price, value fields
- [ ] **Search Screen** — full-text + filter search with results

---

### Issue #14 — Next.js Item Pages

**Platform**: Next.js  
**Labels**: `nextjs` `items`

**Pages**:
- [ ] `/items` — browsable item grid with sidebar filters (SSR for SEO)
- [ ] `/items/[id]` — item detail page (SSR) with photo gallery, owner info, risk tier badge
- [ ] `/my-listings` — owner's dashboard for managing their items
- [ ] `/my-listings/new` — create item form
- [ ] `/my-listings/[id]/edit` — edit item form
- [ ] Drag-and-drop image upload component with preview and reorder

---

---

## 🧮 Milestone 5 — Trust Score & Risk Engine

> **Goal**: The core academic contribution. The backend computes a dynamic risk score per transaction and maintains an evolving trust score per user.

---

### Issue #15 — Trust Score Engine (Backend)

**Platform**: Backend  
**Labels**: `backend` `risk-engine` `core`

**Description**:  
Every user has a trust score (0–100) that updates after every behavioral event.

**Scoring Table**:
| Event | Delta |
|---|---|
| Email verified | +5 |
| Phone verified | +5 |
| CNIC verified | +10 |
| First rental completed | +15 |
| Rental returned on time | +10 |
| Positive review received (4–5★) | +5 |
| Late return | -10 |
| Damage claim against user | -20 |
| Dispute filed against user | -15 |
| Dispute resolved against user | -25 |
| Cancellation by renter | -5 |
| Dispute resolved in user's favor | +5 |

**Tasks**:
- [ ] Create `TrustScoreService` with `applyEvent(userId, eventType)` method
- [ ] Score clamped between 0–100
- [ ] All events logged to `trust_events` table with `delta` and `new_score`
- [ ] Expose `GET /api/users/:id/trust-score` (public, rounded to nearest 5)
- [ ] Expose `GET /api/users/:id/trust-events` (private, full history)
- [ ] Write unit tests for all 11 event types
- [ ] Document in `docs/trust-score.md`

---

### Issue #16 — Transaction Risk Scoring Engine (Backend)

**Platform**: Backend  
**Labels**: `backend` `risk-engine` `core`

**Description**:  
When a rental request is submitted, compute a risk score (0–100%) for that specific transaction.

**Risk Factor Weights**:
| Factor | Max Impact |
|---|---|
| Renter trust score (inverse) | 30 pts |
| Item value tier | 25 pts |
| Rental duration (longer = higher risk) | 15 pts |
| Account age (newer = higher risk) | 10 pts |
| CNIC not verified | 10 pts |
| Past disputes | 10 pts |

**Output**:
```json
{
  "risk_score": 34,
  "risk_label": "Medium",
  "risk_color": "orange",
  "recommended_deposit_pkr": 30000,
  "max_recommended_days": 14,
  "flags": ["short_account_age", "no_cnic"],
  "action": "proceed_with_verification",
  "blocked": false
}
```

**Action Thresholds**:
| Risk % | Action |
|---|---|
| 0–30 | ✅ Auto-approve |
| 31–60 | ⚠️ Require extra verification step |
| 61–80 | 🔴 Require CNIC + higher deposit |
| 81–100 | 🚫 Block — suggest shorter duration or lower value item |

**Tasks**:
- [ ] Implement `RiskScoringEngine` service
- [ ] Integrate into `POST /api/rental-requests` — compute and store score before saving
- [ ] Expose `GET /api/rental-requests/:id/risk` — fetch risk result
- [ ] Write unit tests for all threshold combinations
- [ ] Document algorithm in `docs/risk-engine.md`

---

### Issue #17 — Risk Score UI (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `risk-engine`

**Description**:  
After a renter fills in rental details (dates, duration), show a risk analysis screen before they confirm the request.

**Screens**:
- [ ] **Risk Analysis Screen** — animated risk gauge (0–100%), color-coded label, flags list, recommended deposit
- [ ] **Blocked Screen** — shown when `action = blocked`, explains why and offers alternatives
- [ ] **Verification Gate Screen** — shown for medium-risk, prompts missing verification steps
- [ ] Renter must tap "I understand, proceed" to confirm after seeing risk
- [ ] Risk card also shown on owner's side when reviewing a request

---

### Issue #18 — Risk Score UI (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `risk-engine`

**Description**:  
Equivalent risk display on the web, shown during rental request flow.

**Components**:
- [ ] `RiskScoreCard` — animated score bar, color-coded label, flags with icons
- [ ] `BlockedRentalAlert` — alert component explaining blocking reason
- [ ] `VerificationPrompt` — inline prompt to complete missing verifications
- [ ] Risk summary shown in rental request review step (multi-step form)

---

---

## 💰 Milestone 6 — Dynamic Deposit System

> **Goal**: Deposit is calculated per rental based on item value and renter risk — not a flat rate.

---

### Issue #19 — Deposit Calculator (Backend)

**Platform**: Backend  
**Labels**: `backend` `deposits`

**Formula**:
```
base_rate = 0.10 (Tier 1) | 0.15 (Tier 2) | 0.20 (Tier 3)
base_deposit = item_value_pkr × base_rate
risk_multiplier = 1.0 (low) | 1.5 (medium) | 2.5 (high)
final_deposit = base_deposit × risk_multiplier
```

**Deposit Lifecycle States**:
`pending` → `held` → `released` | `partially_forfeited` | `fully_forfeited`

**Tasks**:
- [ ] `DepositCalculatorService` with `calculate(itemValue, riskLevel)` method
- [ ] Deposit amount included in risk score response
- [ ] `deposit_status` tracked in `rentals` table
- [ ] `PATCH /api/rentals/:id/deposit-status` — admin only
- [ ] Notify both parties on deposit status change
- [ ] Write unit tests for all tier × risk combinations

---

### Issue #20 — Deposit Display (Flutter + Next.js)

**Platform**: Flutter + Next.js  
**Labels**: `flutter` `nextjs` `deposits`

**Tasks**:
- [ ] Flutter: Show deposit amount prominently on rental request confirmation screen
- [ ] Flutter: Deposit status chip on rental detail screen (color-coded)
- [ ] Next.js: Deposit amount in rental request review step
- [ ] Next.js: Deposit status timeline on rental detail page
- [ ] Both: Show deposit breakdown (item value × rate × multiplier)

---

---

## 📝 Milestone 7 — Digital Rental Contract

> **Goal**: Both parties sign a digital contract before the rental activates. It is immutable once signed.

---

### Issue #21 — Contract Generation & Signing API

**Platform**: Backend  
**Labels**: `backend` `contracts`

**Contract Contains**:
- Item name, description, value (PKR)
- Owner and renter verified names + IDs
- Rental start & end dates, daily rate
- Deposit amount held
- Late return penalty (2% of item value per day, configurable)
- Damage policy (minor / major / total loss thresholds)
- Loss or theft reporting procedure (must report within 24h)
- Platform dispute process reference

**Tasks**:
- [ ] `POST /api/contracts/generate/:rental_request_id` — auto-generate contract JSON
- [ ] `POST /api/contracts/:id/sign` — record signature (owner or renter, timestamp)
- [ ] Contract locked (read-only) after both sign
- [ ] `GET /api/contracts/:id` — fetch contract for a rental
- [ ] Generate PDF view of the contract (use `pdfkit` or `puppeteer`)
- [ ] Rental status moves to `contract_signed` after both sign

---

### Issue #22 — Contract UI (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `contracts`

**Screens**:
- [ ] **Contract Review Screen** — scrollable contract with all terms
- [ ] "Sign" button only enables after scroll reaches bottom
- [ ] Show both parties' signing status (owner ✅ / renter ⏳)
- [ ] After both sign — animated confirmation + rental activates
- [ ] **Contract Detail Screen** — viewable throughout rental lifecycle
- [ ] Download as PDF option

---

### Issue #23 — Contract UI (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `contracts`

**Pages/Components**:
- [ ] `/rentals/[id]/contract` — full contract viewer page
- [ ] Scroll-to-bottom gate before sign button activates
- [ ] Signing status bar (shows owner / renter signed states)
- [ ] PDF download button (opens generated PDF)
- [ ] Confirmation modal after signing

---

---

## 📸 Milestone 8 — Item Condition Evidence System

> **Goal**: Photo/video evidence of item condition is captured and stored before and after every rental.

---

### Issue #24 — Evidence Upload API

**Platform**: Backend  
**Labels**: `backend` `evidence`

**Tasks**:
- [ ] `POST /api/evidence` — upload evidence file (multipart/form-data)
  - Fields: `rental_id`, `type` (pre_rental/post_rental), `uploaded_by`
- [ ] Store files in Firebase Storage or Cloudinary
- [ ] Store metadata (file_url, uploader, timestamp, type) in `evidence` table
- [ ] `GET /api/evidence/:rental_id` — fetch all evidence for a rental
- [ ] Maximum 10 files per evidence upload
- [ ] Support image (JPEG, PNG, HEIC) and short video (MP4, max 60s)
- [ ] Limit file size: images 10MB, videos 100MB

---

### Issue #25 — Evidence Upload (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `evidence`

**Screens**:
- [ ] **Pre-Rental Evidence Screen (Owner)** — multi-image picker from camera/gallery, upload all at once
- [ ] **Receipt Confirmation Screen (Renter)** — "I have received the item" + option to add own photos
- [ ] **Return Evidence Screen (Renter)** — upload photos before physical return
- [ ] **Return Confirmation Screen (Owner)** — upload received-condition photos
- [ ] **Evidence Gallery Screen** — view before/after side-by-side for a rental
- [ ] Show upload progress indicator
- [ ] Compress images before upload (`flutter_image_compress`)

---

### Issue #26 — Evidence Upload (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `evidence`

**Pages/Components**:
- [ ] `/rentals/[id]/evidence/upload` — drag-and-drop multi-file uploader
- [ ] Before/after evidence comparison view (`ImageCompare` slider component)
- [ ] Evidence gallery grid on rental detail page
- [ ] File type validation and size limit enforcement on frontend

---

### Issue #27 — (Optional) Computer Vision Damage Detection

**Platform**: Backend  
**Labels**: `backend` `computer-vision` `optional`

**Description**:  
After post-rental evidence is uploaded, run an image comparison to flag potential damage.

**Tasks**:
- [ ] Python microservice (FastAPI) that accepts two image URLs and returns a damage confidence score
- [ ] Use OpenCV structural similarity (SSIM) or a fine-tuned CNN
- [ ] Call from Node.js backend after post-rental evidence is uploaded
- [ ] Store result in `evidence_analysis` table
- [ ] Flag rental for admin review if confidence > 0.6
- [ ] Show result in admin dispute panel
- [ ] Add "AI-assisted analysis — not conclusive" disclaimer on all CV outputs

---

---

## ⏱️ Milestone 9 — Rental Lifecycle & Return Monitoring

> **Goal**: The system tracks every rental from creation to return, with automated state transitions and alerts.

---

### Issue #28 — Rental State Machine (Backend)

**Platform**: Backend  
**Labels**: `backend` `rentals`

**States**:
```
requested
  → approved (owner accepts)
  → contract_signed (both signed)
  → evidence_uploaded (owner uploads pre photos)
  → active (renter confirms receipt)
  → return_initiated (renter uploads return evidence)
  → completed (owner confirms return, deposit released)
  → overdue (past due date, not returned)
  → escalated (overdue 3+ days, dispute eligible)
  → disputed
  → cancelled
```

**Tasks**:
- [ ] Implement `RentalStateMachine` with validated transitions
- [ ] Log every state change in `rental_events` audit table
- [ ] `PATCH /api/rentals/:id/status` — trigger state transition
- [ ] `GET /api/rentals/:id/timeline` — full event history with timestamps
- [ ] Reject invalid transitions with descriptive error

---

### Issue #29 — Return Monitoring Cron Job (Backend)

**Platform**: Backend  
**Labels**: `backend` `jobs`

**Schedule**:
| Time | Action |
|---|---|
| Due date - 48h | Send "returning soon" reminder notification |
| Due date - 24h | Send "due tomorrow" reminder |
| Due date (T+0) | Send "due today" alert |
| T + 1 day | Mark rental `overdue`, apply -10 trust event |
| T + 3 days | Mark `escalated`, notify both parties, enable dispute |
| T + 7 days | Auto-flag for admin review |

**Tasks**:
- [ ] Set up `node-cron` job running daily at midnight
- [ ] `ReturnMonitoringJob` checks all active rentals
- [ ] Apply state transitions and trust events automatically
- [ ] Trigger push + email notifications at each stage

---

### Issue #30 — Rental Management Screens (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `rentals`

**Screens**:
- [ ] **My Rentals Screen** — tabs: Active, Pending, Completed, Disputes
- [ ] **Rental Detail Screen** — full timeline, contract link, evidence gallery, deposit status, action buttons
- [ ] **Rental Request Screen** — date picker, duration, shows real-time risk score
- [ ] **Owner Requests Screen** — incoming requests with renter risk card, approve/reject

---

### Issue #31 — Rental Management Pages (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `rentals`

**Pages**:
- [ ] `/rentals` — tabbed list (as renter / as owner)
- [ ] `/rentals/[id]` — detail page with timeline, evidence, contract, deposit
- [ ] `/rentals/[id]/request` — multi-step rental request form (dates → risk review → deposit → confirm)
- [ ] `/owner/requests` — incoming requests dashboard with renter risk summaries

---

---

## ⚖️ Milestone 10 — Dispute Resolution System

> **Goal**: A structured process for raising and resolving conflicts, using all platform-collected evidence.

---

### Issue #32 — Dispute API

**Platform**: Backend  
**Labels**: `backend` `disputes`

**Tasks**:
- [ ] `POST /api/disputes` — file dispute (rental_id, type, description)
- [ ] `GET /api/disputes/:id` — dispute detail with linked evidence + contract
- [ ] `GET /api/disputes` — list disputes (filtered by user or admin)
- [ ] `PATCH /api/disputes/:id/resolve` — admin only: set resolution + notes
- [ ] Auto-apply trust score impact after resolution (see Issue #15)
- [ ] Notify both parties on filing and resolution

---

### Issue #33 — Dispute Screens (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `disputes`

**Screens**:
- [ ] **File Dispute Screen** — dispute type selector, description field, attach additional evidence
- [ ] **My Disputes Screen** — list of open and resolved disputes
- [ ] **Dispute Detail Screen** — timeline, evidence viewer, contract summary, status, resolution notes
- [ ] Status badges: `Open` 🔴, `Under Review` 🟡, `Resolved` ✅

---

### Issue #34 — Dispute Pages (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `disputes`

**Pages**:
- [ ] `/disputes/new?rental=[id]` — dispute filing form
- [ ] `/disputes` — user's disputes list
- [ ] `/disputes/[id]` — dispute detail with before/after evidence viewer, contract, timeline

---

---

## 🔔 Milestone 11 — Notifications & Alerts

> **Goal**: Users receive timely notifications on both mobile (push) and web (in-app + email).

---

### Issue #35 — Notification API

**Platform**: Backend  
**Labels**: `backend` `notifications`

**Notification Events**:
- Rental request received (owner)
- Rental approved / rejected (renter)
- Contract ready to sign
- Evidence upload reminder
- Rental due in 48h / 24h / overdue
- Dispute filed
- Dispute resolved
- Trust score milestone (e.g., unlocked high-value rentals)
- Review received

**Tasks**:
- [ ] `NotificationService` dispatches all events
- [ ] Store all notifications in `notifications` table
- [ ] `GET /api/notifications` — paginated, unread first
- [ ] `PATCH /api/notifications/:id/read` — mark read
- [ ] `PATCH /api/notifications/read-all`
- [ ] Integrate FCM for push (mobile)
- [ ] Integrate email templates (SendGrid / nodemailer)

---

### Issue #36 — Flutter Notifications

**Platform**: Flutter  
**Labels**: `flutter` `notifications`

**Tasks**:
- [ ] Integrate `firebase_messaging` for FCM push
- [ ] Handle foreground and background push messages
- [ ] `flutter_local_notifications` for in-app banners
- [ ] **Notifications Screen** — list with unread badge, tap to navigate to related screen
- [ ] Bell icon in AppBar with unread count badge
- [ ] Deep link from notification to correct screen (go_router)

---

### Issue #37 — Next.js Notifications

**Platform**: Next.js  
**Labels**: `nextjs` `notifications`

**Tasks**:
- [ ] Notification dropdown in top nav with unread count badge
- [ ] `/notifications` page — full list with read/unread states
- [ ] Poll for new notifications every 30s (or use WebSocket if time allows)
- [ ] Toast notifications for real-time in-session events

---

---

## 🛠️ Milestone 12 — Admin Panel (Next.js Web Only)

> **Goal**: Platform administrators can manage users, monitor rentals, review disputes, and audit trust activity.

---

### Issue #38 — Admin Dashboard

**Platform**: Next.js  
**Labels**: `nextjs` `admin`

**Tasks**:
- [ ] `/admin` — dashboard with key metrics:
  - Total users (+ new this week)
  - Active rentals
  - Open disputes
  - High-risk transactions flagged
  - Trust events today
- [ ] Charts: new user signups (7d), rental volume (30d), dispute rate (recharts)
- [ ] Quick links to dispute queue, flagged users

---

### Issue #39 — Admin User Management

**Platform**: Next.js  
**Labels**: `nextjs` `admin`

**Tasks**:
- [ ] `/admin/users` — paginated user table with search and filters
- [ ] `/admin/users/[id]` — user detail: profile, trust score timeline, rental history, trust events log
- [ ] Admin actions: suspend account, reset trust score override, manually verify CNIC
- [ ] CNIC review queue: list of pending CNIC uploads with approve/reject

---

### Issue #40 — Admin Dispute Review Panel

**Platform**: Next.js  
**Labels**: `nextjs` `admin` `disputes`

**Tasks**:
- [ ] `/admin/disputes` — dispute queue sorted by severity
- [ ] `/admin/disputes/[id]` — full dispute view:
  - Before/after image comparison slider
  - Contract terms panel
  - Communication timeline
  - Risk score at time of rental
  - CV damage analysis result (if available)
- [ ] Resolution form: select outcome, enter notes, confirm
- [ ] Auto-applies trust score impacts on resolution

---

### Issue #41 — Admin Auth & Role Management

**Platform**: Next.js  
**Labels**: `nextjs` `admin` `auth`

**Roles**:
| Role | Access |
|---|---|
| `super_admin` | Full access |
| `support_agent` | Disputes, read users |
| `cnic_reviewer` | CNIC queue only |

**Tasks**:
- [ ] Separate admin login at `/admin/login`
- [ ] 2FA with TOTP (authenticator app)
- [ ] Role-based route protection middleware
- [ ] Admin activity log (who did what + timestamp)

---

---

## 🤖 Milestone 13 — (Optional) Computer Vision — Damage Detection

> **Goal**: Automated image comparison to assist dispute reviewers in detecting visual damage. Stretch goal — implement only after all other milestones.

---

### Issue #42 — Python CV Microservice

**Platform**: Backend (separate Python service)  
**Labels**: `python` `computer-vision` `optional`

**Tasks**:
- [ ] Set up FastAPI microservice (`/cv-service`)
- [ ] `POST /analyze` — accepts two image URLs, returns `{ damage_score: 0.72, regions: [...] }`
- [ ] Use OpenCV SSIM for pixel-level diff as baseline
- [ ] Optional upgrade: pre-trained object detection model (YOLOv8 or EfficientDet) for specific damage categories
- [ ] Containerize with Docker for easy deployment
- [ ] Integrate with Node.js backend via internal HTTP call
- [ ] Store results in `evidence_analysis` table

---

---

## 🧪 Milestone 14 — Testing, QA & Documentation

> **Goal**: Ensure the full system is reliable, tested, and documented for FYP submission and presentation.

---

### Issue #43 — Backend Tests

**Platform**: Backend  
**Labels**: `testing` `backend`

**Tasks**:
- [ ] Unit tests for `TrustScoreService` — all 11 event types
- [ ] Unit tests for `RiskScoringEngine` — all factor combinations
- [ ] Unit tests for `DepositCalculatorService`
- [ ] Unit tests for `RentalStateMachine` — all valid and invalid transitions
- [ ] Integration tests for all REST endpoints (use Supertest + Jest)
- [ ] Target: ≥ 70% code coverage
- [ ] Set up GitHub Actions CI to run tests on every PR

---

### Issue #44 — Flutter Tests

**Platform**: Flutter  
**Labels**: `testing` `flutter`

**Tasks**:
- [ ] Widget tests for `RiskBadge`, `TrustScoreGauge`, `AppButton`, `RiskAnalysisScreen`
- [ ] Integration test: full rental request flow (create request → see risk → confirm)
- [ ] Integration test: evidence upload flow
- [ ] Run on Android emulator in CI

---

### Issue #45 — Next.js Tests

**Platform**: Next.js  
**Labels**: `testing` `nextjs`

**Tasks**:
- [ ] Component tests for `RiskScoreCard`, `ContractViewer`, `EvidenceCompare`
- [ ] E2E tests with Playwright:
  - Register → verify → browse items → request rental → risk screen → sign contract
  - File dispute → admin resolves → trust score updated
- [ ] Lighthouse audit: score ≥ 90 on performance and accessibility

---

### Issue #46 — FYP Documentation

**Platform**: All  
**Labels**: `documentation`

**Tasks**:
- [ ] `docs/architecture.md` — system architecture diagram + explanation
- [ ] `docs/trust-score.md` — full scoring model with examples
- [ ] `docs/risk-engine.md` — risk algorithm, factors, thresholds, rationale
- [ ] `docs/deposit-system.md` — formula, examples, deposit states
- [ ] `docs/api-reference.md` — all endpoints with request/response examples
- [ ] `docs/database-schema.md` — ER diagram + table definitions
- [ ] `docs/flutter-screens.md` — annotated screen list
- [ ] FYP report outline (Chapter 1–6 structure)
- [ ] Demo walkthrough script

---

### Issue #47 — Seed Data & Demo Setup

**Platform**: All  
**Labels**: `demo`

**Tasks**:
- [ ] Seed 10+ users with varied trust scores (new, established, suspended)
- [ ] Seed 20+ items across all 3 risk tiers
- [ ] Seed 5+ completed rentals with full trust event history
- [ ] Seed 2 open disputes with before/after evidence
- [ ] Seed 1 high-risk blocked transaction example
- [ ] Create admin account with `super_admin` role
- [ ] Document setup in `docs/demo-setup.md`

---

## 📊 Complete Milestone Summary

| Milestone | Issues | Core Deliverable | Platforms |
|---|---|---|---|
| M1 | #1–5 | Foundation, DB, Flutter init, Next.js init | All |
| M2 | #6–7 | Design system, component library | Flutter + Next.js |
| M3 | #8–11 | Auth, OTP, CNIC, profiles | All |
| M4 | #12–14 | Item listings, browse, search | All |
| **M5** | **#15–18** | **Risk engine + Trust engine ← FYP core** | **Backend + Both** |
| M6 | #19–20 | Dynamic deposits | All |
| M7 | #21–23 | Digital contracts + signing | All |
| M8 | #24–27 | Evidence upload + optional CV | All |
| M9 | #28–31 | Rental lifecycle + return monitoring | All |
| M10 | #32–34 | Dispute system | All |
| M11 | #35–37 | Notifications (push, email, in-app) | All |
| M12 | #38–41 | Admin panel | Next.js only |
| M13 | #42 | CV damage detection (optional) | Backend |
| M14 | #43–47 | Testing, QA, docs, seed data | All |
