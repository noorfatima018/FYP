# 📋 RentWise — Project Issues & Milestones
### Stack: Flutter (Mobile) · Next.js (Web) · Supabase (Database + Auth + Storage + Edge Functions)

This file tracks all project milestones and their associated tasks. Each milestone is a major development phase of the RentWise platform.

> **Supabase replaces**: PostgreSQL server, REST API server (Node.js/Express), Firebase Auth, Firebase Storage, and WebSocket server — all in one managed platform.

---

## 🗺️ Milestone Overview

| # | Milestone | Platform | Status |
|---|---|---|---|
| M1 | Project Setup & Architecture | All | 🔲 Planned |
| M2 | Design System & Shared UI | Flutter + Next.js | 🔲 Planned |
| M3 | Supabase Auth & Identity Verification | Flutter + Next.js + Supabase | 🔲 Planned |
| M4 | Item Listing & Management | Flutter + Next.js + Supabase | 🔲 Planned |
| M5 | Trust Score & Risk Engine | Supabase Edge Functions | 🔲 Planned |
| M6 | Dynamic Deposit System | Supabase Edge Functions + Flutter + Next.js | 🔲 Planned |
| M7 | Digital Rental Contract | Supabase Edge Functions + Flutter + Next.js | 🔲 Planned |
| M8 | Item Condition Evidence System | Supabase Storage + Flutter + Next.js | 🔲 Planned |
| M9 | Rental Lifecycle & Return Monitoring | Supabase pg_cron + Flutter + Next.js | 🔲 Planned |
| M10 | Dispute Resolution System | Supabase + Flutter + Next.js | 🔲 Planned |
| M11 | Realtime Notifications & Alerts | Supabase Realtime + FCM + Flutter + Next.js | 🔲 Planned |
| M12 | Admin Panel | Next.js (Web only) | 🔲 Planned |
| M13 | (Optional) Computer Vision | Python FastAPI microservice | 🔲 Planned |
| M14 | Testing, QA & Documentation | All | 🔲 Planned |

---

---

## 🏁 Milestone 1 — Project Setup & Architecture

> **Goal**: Establish the complete technical foundation — monorepo structure, Supabase project initialization, database schema, Flutter app scaffold, and Next.js app scaffold.

---

### Issue #1 — Initialize Monorepo & Folder Structure

**Platform**: All  
**Labels**: `setup`

**Folder Structure**:
```
RentWise/
├── mobile/                  ← Flutter app
│   ├── lib/
│   │   ├── core/            ← Theme, constants, Supabase client
│   │   └── features/        ← auth, items, rentals, risk, disputes
│   └── pubspec.yaml
├── web/                     ← Next.js web app + admin panel
│   ├── app/
│   │   ├── (auth)/
│   │   ├── (main)/
│   │   └── admin/
│   ├── components/
│   ├── lib/supabase/        ← Browser + server Supabase clients
│   └── types/
├── supabase/                ← Supabase project config (committed to Git)
│   ├── functions/           ← Edge Functions (Deno/TypeScript)
│   │   ├── risk-score/
│   │   ├── trust-event/
│   │   ├── deposit-calc/
│   │   ├── contract-gen/
│   │   └── return-monitor/
│   ├── migrations/          ← SQL migration files (versioned)
│   └── seed.sql
└── docs/
```

**Tasks**:
- [ ] Create GitHub repository with `main` and `develop` branches
- [ ] Set up `.gitignore` for Flutter, Next.js, Supabase CLI, and Deno
- [ ] Add `README.md`, `ISSUES.md`, `CONTRIBUTING.md`
- [ ] Configure branch protection rules (PRs required for `main`)
- [ ] Install Supabase CLI globally (`npm install -g supabase`)

---

### Issue #2 — Supabase Project Initialization

**Platform**: Supabase  
**Labels**: `supabase` `setup`

**Description**:  
Create and configure the Supabase project. This is the backbone of the entire platform — it provides the database, auth, storage, edge functions, and realtime in one place.

**Tasks**:
- [ ] Create project at [supabase.com](https://supabase.com) — note Project URL and `anon` + `service_role` keys
- [ ] Run `supabase init` in repo root to scaffold local config
- [ ] Run `supabase link --project-ref <project-id>` to link local to remote
- [ ] Store keys in `.env.local` (web) and `--dart-define` / `.env` (mobile) — **never commit keys**
- [ ] Add `.env.example` with placeholder key names
- [ ] Enable the following Supabase extensions in dashboard:
  - `pg_cron` — scheduled jobs (return monitoring)
  - `uuid-ossp` — UUID generation for all primary keys
  - `pgcrypto` — CNIC hash storage

---

### Issue #3 — Database Schema & Migrations

**Platform**: Supabase (PostgreSQL)  
**Labels**: `supabase` `database`

**Description**:  
Write all SQL migrations to create the complete database schema. Migrations live in `supabase/migrations/` and are version-controlled.

**Core Tables**:

| Table | Key Fields |
|---|---|
| `users` (extends auth.users) | id, name, phone, cnic_hash, trust_score, verification_status, created_at |
| `items` | id, owner_id, title, category, value_pkr, risk_tier, daily_rate_pkr, is_available, photos_urls |
| `rental_requests` | id, item_id, renter_id, start_date, end_date, status, risk_score, deposit_required_pkr, risk_json |
| `rentals` | id, request_id, contract_id, status, deposit_status, actual_return_date |
| `contracts` | id, rental_id, terms_json, owner_signed_at, renter_signed_at |
| `evidence` | id, rental_id, type (pre/post), uploaded_by, storage_path, timestamp |
| `disputes` | id, rental_id, raised_by, dispute_type, status, resolution, resolution_notes |
| `trust_events` | id, user_id, event_type, delta, new_score, triggered_by_rental_id, timestamp |
| `notifications` | id, user_id, title, body, type, read, metadata_json, created_at |
| `reviews` | id, rental_id, reviewer_id, reviewee_id, rating, comment |
| `rental_events` | id, rental_id, from_status, to_status, triggered_by, timestamp |

**Tasks**:
- [ ] Write migration `001_initial_schema.sql` with all tables
- [ ] Write migration `002_rls_policies.sql` with Row Level Security policies for every table
- [ ] Write migration `003_indexes.sql` for performance (foreign keys, search fields)
- [ ] Write migration `004_pg_cron_jobs.sql` for scheduled return monitoring
- [ ] Run `supabase db push` to apply migrations
- [ ] Draw ER diagram and save to `docs/database-schema.md`

---

### Issue #4 — Row Level Security (RLS) Policies

**Platform**: Supabase  
**Labels**: `supabase` `security`

**Description**:  
RLS is Supabase's primary security layer. Every table must have policies defined so users can only access their own data. This is critical — without it, any authenticated user can read all data.

**Key RLS Rules**:
| Table | Read | Write |
|---|---|---|
| `users` | Own row only (private fields) · public fields visible to all authenticated users | Own row only |
| `items` | All authenticated users | Owner only |
| `rental_requests` | Renter or item owner | Renter (insert) · owner (approve/reject) |
| `rentals` | Renter or owner of item | Edge Functions via `service_role` only |
| `contracts` | Renter or owner | Edge Functions via `service_role` only |
| `evidence` | Renter or owner | Renter or owner |
| `disputes` | Parties involved · admins | Parties involved (insert) · admins (resolve) |
| `trust_events` | Own rows only | Edge Functions via `service_role` only |
| `notifications` | Own rows only | Edge Functions via `service_role` only |
| `reviews` | All authenticated | Reviewer (insert once per rental) |

**Tasks**:
- [ ] Enable RLS on every table (`ALTER TABLE x ENABLE ROW LEVEL SECURITY`)
- [ ] Write `SELECT`, `INSERT`, `UPDATE`, `DELETE` policies per table
- [ ] Create `admin` role using Supabase custom claims (JWT metadata)
- [ ] Admin policies: full access to all tables
- [ ] Test all policies using Supabase dashboard Policy Editor and test accounts
- [ ] Document all policies in `docs/rls-policies.md`

---

### Issue #5 — Flutter App Initialization

**Platform**: Flutter  
**Labels**: `flutter` `setup`

**Flutter Packages**:
| Package | Purpose |
|---|---|
| `supabase_flutter` | Supabase client (auth, DB queries, storage, realtime) |
| `go_router` | Navigation & deep linking |
| `flutter_riverpod` | State management |
| `firebase_messaging` | FCM push notifications (Supabase doesn't do push natively) |
| `flutter_local_notifications` | Show local notification banners |
| `image_picker` | Camera & gallery access for evidence upload |
| `cached_network_image` | Cache images from Supabase Storage |
| `flutter_image_compress` | Compress images before upload |
| `intl` | Date/number formatting |
| `flutter_secure_storage` | Store Supabase session tokens securely |

**Folder Structure**:
```
mobile/lib/
├── core/
│   ├── constants/         ← Supabase URL, anon key, route names
│   ├── theme/             ← AppColors, AppTypography, AppTheme
│   ├── utils/
│   └── supabase/          ← Supabase client singleton + helpers
├── features/
│   ├── auth/              ← Login, register, OTP, CNIC
│   ├── items/             ← Browse, detail, my listings
│   ├── rentals/           ← Request, manage, timeline
│   ├── risk/              ← Risk score display, gates
│   ├── contracts/         ← Review, sign, view
│   ├── evidence/          ← Upload, gallery, compare
│   ├── disputes/          ← File, view, resolve
│   ├── notifications/     ← Notification center
│   └── profile/           ← Trust score, history, settings
└── main.dart
```

**Tasks**:
- [ ] Initialize Flutter project with null safety enabled
- [ ] Add all packages to `pubspec.yaml`
- [ ] Initialize Supabase in `main.dart`:
  ```dart
  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
  ```
- [ ] Set up `go_router` with all named routes
- [ ] Set up Riverpod `ProviderScope` at root
- [ ] Configure app theme and typography
- [ ] Test on Android emulator + iOS simulator

---

### Issue #6 — Next.js App Initialization

**Platform**: Next.js  
**Labels**: `nextjs` `setup`

**Packages**:
| Package | Purpose |
|---|---|
| `@supabase/supabase-js` | Supabase browser client |
| `@supabase/ssr` | Server-side Supabase client for Next.js middleware + SSR |
| `react-hook-form` + `zod` | Forms + validation |
| `zustand` | Client state management |
| `@tanstack/react-query` | Server state / data fetching |
| `recharts` | Charts (admin dashboard) |
| `react-hot-toast` | Toast notifications |
| `lucide-react` | Icons |
| `next` + `typescript` | Framework |

**Supabase Client Setup**:
```
web/lib/supabase/
├── client.ts        ← Browser client (for Client Components)
├── server.ts        ← Server client (for Server Components + Actions)
└── middleware.ts    ← Session refresh middleware
```

**Tasks**:
- [ ] Initialize Next.js with TypeScript and App Router
- [ ] Install all packages
- [ ] Create browser + server Supabase clients in `lib/supabase/`
- [ ] Set up `middleware.ts` to refresh Supabase session on every request
- [ ] Set up route groups: `(auth)/`, `(main)/`, `admin/`
- [ ] Configure global CSS / Tailwind design tokens
- [ ] Create root layout with providers (QueryClient, Toaster)
- [ ] Test dev server

---

---

## 🎨 Milestone 2 — Design System & Shared UI

> **Goal**: Build a consistent visual design system for both Flutter and Next.js before any feature screens.

---

### Issue #7 — Flutter Design System

**Platform**: Flutter  
**Labels**: `flutter` `design`

**Design Tokens**:
```dart
primaryColor:    Color(0xFF1A73E8)   // Trust blue
dangerColor:     Color(0xFFE53935)   // High risk red
warningColor:    Color(0xFFFB8C00)   // Medium risk orange
successColor:    Color(0xFF43A047)   // Low risk green
backgroundDark:  Color(0xFF0F172A)   // Dark background
surfaceColor:    Color(0xFF1E293B)   // Card surfaces
```

**Reusable Widgets to Build**:
- [ ] `AppButton` — primary, secondary, danger, outlined variants
- [ ] `AppTextField` — with label, hint, error state
- [ ] `AppCard` — standard elevated card
- [ ] `RiskBadge` — `Low` (green) · `Medium` (orange) · `High` (red) pill
- [ ] `TrustScoreGauge` — animated circular indicator (0–100)
- [ ] `VerificationBadge` — email ✅ / phone ✅ / CNIC ✅ icon row
- [ ] `StatusChip` — rental status pill (color-coded)
- [ ] `AppBottomNav` — 5-tab bottom navigation
- [ ] `LoadingOverlay` — full-screen loading indicator
- [ ] `EmptyState` — illustration + message for empty lists
- [ ] Splash screen with animated logo

---

### Issue #8 — Next.js Design System

**Platform**: Next.js  
**Labels**: `nextjs` `design`

**Base Components to Build**:
- [ ] `Button` — primary, secondary, destructive, ghost, outline variants
- [ ] `Input`, `Textarea`, `Select` — with error + helper states
- [ ] `Card`, `CardHeader`, `CardContent`, `CardFooter`
- [ ] `Badge` — status color variants
- [ ] `RiskScoreCard` — score bar, color-coded label, flags, deposit
- [ ] `TrustScoreMeter` — animated horizontal bar (0–100)
- [ ] `VerificationStatus` — icon row (email / phone / CNIC)
- [ ] `Alert` — info, success, warning, error
- [ ] `Modal` / `Dialog` — accessible, keyboard-navigable
- [ ] `Skeleton` — loading placeholders
- [ ] `DataTable` — paginated, sortable (for admin)
- [ ] Responsive layout: `Sidebar + TopNav` (desktop) · hamburger (mobile)
- [ ] Marketing landing page (`/`) with hero, features, CTA

---

---

## 🔐 Milestone 3 — Supabase Auth & Identity Verification

> **Goal**: Full user authentication and multi-step identity verification using Supabase Auth, with profile data stored in the `users` table linked to `auth.users`.

---

### Issue #9 — Supabase Auth Configuration

**Platform**: Supabase  
**Labels**: `supabase` `auth`

**Description**:  
Configure Supabase Auth to support email OTP, phone OTP, and create the `users` profile table automatically when a new auth user is created.

**Tasks**:
- [ ] Enable Email provider with OTP (passwordless) in Supabase Auth settings
- [ ] Enable Phone provider (SMS via Twilio — connect in Supabase dashboard)
- [ ] Create `users` table with `id` referencing `auth.users(id)`
- [ ] Write `on_auth_user_created` database trigger:
  ```sql
  CREATE OR REPLACE FUNCTION handle_new_user()
  RETURNS TRIGGER AS $$
  BEGIN
    INSERT INTO public.users (id, email, name)
    VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'name');
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql SECURITY DEFINER;
  ```
- [ ] Set up custom JWT claims for admin role using Supabase Auth hooks
- [ ] Configure email templates in Supabase dashboard (OTP, welcome)
- [ ] Set OTP expiry to 10 minutes, max attempts to 5

---

### Issue #10 — Flutter Auth Screens

**Platform**: Flutter  
**Labels**: `flutter` `auth`

**Screens**:
- [ ] **Splash Screen** — check `supabase.auth.currentSession`, redirect to home or login
- [ ] **Register Screen** — name, email, phone → calls `supabase.auth.signUp()`
- [ ] **Login Screen** — email OTP flow → `supabase.auth.signInWithOtp(email:)`
- [ ] **Email OTP Screen** — 6-digit input → `supabase.auth.verifyOtp(email:, token:, type: email)`
- [ ] **Phone OTP Screen** — SMS 6-digit input → `supabase.auth.verifyOtp(phone:, token:, type: sms)`
- [ ] **Verification Hub Screen** — shows completion status for email / phone / CNIC
- [ ] **CNIC Upload Screen** — capture front + back with `image_picker`, compress, upload to Supabase Storage bucket `cnic-uploads/{user_id}/`, store hash in `users` table
- [ ] Handle session persistence across app restarts via `supabase_flutter`'s built-in session management

---

### Issue #11 — Next.js Auth Pages

**Platform**: Next.js  
**Labels**: `nextjs` `auth`

**Pages**:
- [ ] `/register` — name, email, phone form → calls `supabase.auth.signUp()` from Server Action
- [ ] `/login` — email input → `supabase.auth.signInWithOtp({email})` (magic link / OTP)
- [ ] `/verify/email` — OTP code entry → `supabase.auth.verifyOtp()`
- [ ] `/verify/phone` — SMS OTP entry
- [ ] `/verify/cnic` — file uploader (drag-and-drop) → uploads to Supabase Storage, stores hash
- [ ] `/verify` — verification status hub with progress steps
- [ ] Set up `middleware.ts` to protect all `(main)/*` and `admin/*` routes
- [ ] Redirect unauthenticated users to `/login`
- [ ] Handle Supabase auth callback at `/auth/callback` (OAuth / magic link redirects)

---

### Issue #12 — User Profile

**Platform**: Flutter + Next.js + Supabase  
**Labels**: `profile`

**Supabase Queries**:
```sql
-- Get own profile
SELECT * FROM users WHERE id = auth.uid();

-- Get public profile (another user)
SELECT name, trust_score, verification_status, created_at FROM users WHERE id = $1;
```

**Tasks**:
- [ ] Flutter: Profile screen — name, photo, trust gauge, verification badges, rental history tabs
- [ ] Flutter: Edit profile screen — update name + photo (upload to Storage `avatars/{user_id}`)
- [ ] Next.js: `/profile` page — same layout adapted for web
- [ ] Next.js: `/profile/edit` — form with Server Action calling Supabase update
- [ ] Both: Subscribe to own `users` row via Supabase Realtime for live trust score updates

---

---

## 📦 Milestone 4 — Item Listing & Management

> **Goal**: Owners list items. Renters browse and search. All data lives in Supabase with Storage for images.

---

### Issue #13 — Items Table & Storage

**Platform**: Supabase  
**Labels**: `supabase` `items`

**Tasks**:
- [ ] Create `item-images` Storage bucket (public read, auth write)
- [ ] RLS: only item owner can upload to their folder `item-images/{item_id}/`
- [ ] Add full-text search index on `items(title, description)` using PostgreSQL `tsvector`
- [ ] Add database function for nearby items (if location added later)
- [ ] Write RLS policies: all authenticated users can `SELECT`, only owner can `INSERT/UPDATE/DELETE`

**Item Risk Tier** (auto-assigned by trigger):
```sql
risk_tier = CASE
  WHEN value_pkr < 5000 THEN 'low'
  WHEN value_pkr BETWEEN 5000 AND 50000 THEN 'medium'
  ELSE 'high'
END
```

---

### Issue #14 — Flutter Item Screens

**Platform**: Flutter  
**Labels**: `flutter` `items`

**Screens**:
- [ ] **Home / Browse Screen** — item grid using `supabase.from('items').select()`, search bar, category chips
- [ ] **Item Detail Screen** — photo carousel (from Supabase Storage URLs), description, owner trust card, risk tier badge, "Request Rental" CTA
- [ ] **My Listings Screen** — filtered query `items?owner_id=eq.{uid}`
- [ ] **Add Item Screen** — form + multi-image picker → upload each to Storage → save URLs array in `items.photo_urls`
- [ ] **Edit Item Screen** — pre-filled form, update via `supabase.from('items').update()`
- [ ] **Search Screen** — full-text search using `items?title=ilike.*{query}*`

---

### Issue #15 — Next.js Item Pages

**Platform**: Next.js  
**Labels**: `nextjs` `items`

**Pages**:
- [ ] `/items` — SSR item grid with sidebar filters (category, price, tier), SEO-optimized
- [ ] `/items/[id]` — SSR item detail with photo gallery, owner card, risk tier, "Request Rental" button
- [ ] `/my-listings` — client-side owner dashboard
- [ ] `/my-listings/new` — create form with drag-and-drop image uploader → Supabase Storage
- [ ] `/my-listings/[id]/edit` — edit form
- [ ] Image reorder + delete from Storage on edit

---

---

## 🧮 Milestone 5 — Trust Score & Risk Engine

> **Goal**: The core FYP contribution. All logic lives in Supabase Edge Functions — serverless TypeScript functions running on Deno at the edge.

---

### Issue #16 — Trust Score Edge Function

**Platform**: Supabase Edge Functions  
**Labels**: `supabase` `edge-functions` `core`

**Function**: `supabase/functions/trust-event/index.ts`

**Description**:  
Called whenever a trust-impacting event occurs. Reads the current score, applies the delta, writes the event, and updates the user row — all in a single database transaction.

**Scoring Table**:
| Event Type | Delta |
|---|---|
| `email_verified` | +5 |
| `phone_verified` | +5 |
| `cnic_verified` | +10 |
| `first_rental_completed` | +15 |
| `on_time_return` | +10 |
| `positive_review` | +5 |
| `late_return` | -10 |
| `damage_claim` | -20 |
| `dispute_opened_against` | -15 |
| `dispute_lost` | -25 |
| `cancellation_by_renter` | -5 |
| `dispute_won` | +5 |

**Function signature**:
```typescript
// POST /functions/v1/trust-event
// Body: { userId: string, eventType: TrustEventType, rentalId?: string }
// Auth: service_role key (internal calls only)
```

**Tasks**:
- [ ] Create Edge Function `trust-event`
- [ ] Read current `trust_score` from `users` table
- [ ] Calculate `new_score = clamp(current + delta, 0, 100)`
- [ ] Insert into `trust_events` (event_type, delta, new_score, rental_id, timestamp)
- [ ] Update `users.trust_score = new_score`
- [ ] Use database transaction (`BEGIN/COMMIT`) to ensure atomicity
- [ ] Deploy: `supabase functions deploy trust-event`
- [ ] Write unit tests with Deno test runner
- [ ] Document all events in `docs/trust-score.md`

---

### Issue #17 — Risk Scoring Edge Function

**Platform**: Supabase Edge Functions  
**Labels**: `supabase` `edge-functions` `core`

**Function**: `supabase/functions/risk-score/index.ts`

**Description**:  
Called when a rental request is submitted. Computes a 0–100 risk score from user and transaction signals, returns the full risk result, and stores it in `rental_requests.risk_json`.

**Risk Factors**:
| Factor | Scoring Logic |
|---|---|
| Renter trust score | `30 × (1 - trust_score/100)` |
| Item value tier | low=0, medium=15, high=25 |
| Rental duration | `min(duration_days / 2, 15)` |
| Account age (days) | `age < 7 → +10, age < 30 → +5, else 0` |
| CNIC not verified | `+10` |
| Open disputes | `disputes × 5` (max 10) |

**Output JSON**:
```typescript
{
  risk_score: number,        // 0–100
  risk_label: "Low" | "Medium" | "High" | "Blocked",
  risk_color: "green" | "orange" | "red",
  recommended_deposit_pkr: number,
  max_recommended_days: number,
  flags: string[],           // ["short_account_age", "no_cnic", ...]
  action: "approve" | "verify" | "restrict" | "block",
  blocked: boolean
}
```

**Action Thresholds**:
| Score | Action |
|---|---|
| 0–30 | `approve` — auto-proceed |
| 31–60 | `verify` — prompt missing verification |
| 61–80 | `restrict` — require CNIC + higher deposit |
| 81–100 | `block` — reject, suggest alternatives |

**Tasks**:
- [ ] Create Edge Function `risk-score`
- [ ] Fetch renter's `trust_score`, `created_at`, `verification_status` from `users`
- [ ] Fetch item `value_pkr`, `risk_tier` from `items`
- [ ] Count open disputes against renter from `disputes`
- [ ] Compute final score and output JSON
- [ ] Store result in `rental_requests.risk_json`
- [ ] Deploy: `supabase functions deploy risk-score`
- [ ] Write unit tests covering all threshold combinations
- [ ] Document algorithm in `docs/risk-engine.md`

---

### Issue #18 — Risk Score UI (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `risk-engine`

**Screens**:
- [ ] **Rental Request Screen** — date picker → on confirm, call `risk-score` Edge Function via Supabase invoke
- [ ] **Risk Analysis Screen** — animated risk gauge, color-coded label, flags list, recommended deposit, action button
- [ ] **Blocked Screen** — shown when `action = block`, explains reason, suggests alternatives
- [ ] **Verification Gate Screen** — for medium/high risk, links to missing verification steps
- [ ] Owner sees renter's risk card when reviewing incoming requests

---

### Issue #19 — Risk Score UI (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `risk-engine`

**Components + Pages**:
- [ ] `RiskScoreCard` — animated score bar, label badge, flags with icons, deposit amount
- [ ] `BlockedRentalAlert` — explains blocking reason, suggests alternatives
- [ ] `VerificationGatePrompt` — inline prompt to complete missing verifications
- [ ] Multi-step rental request form: step 1 (dates) → step 2 (risk review) → step 3 (confirm)
- [ ] Invoke `risk-score` Edge Function: `supabase.functions.invoke('risk-score', { body: {...} })`

---

---

## 💰 Milestone 6 — Dynamic Deposit System

> **Goal**: Deposit is calculated per rental by a Supabase Edge Function — not a flat rate.

---

### Issue #20 — Deposit Calculator Edge Function

**Platform**: Supabase Edge Functions  
**Labels**: `supabase` `edge-functions` `deposits`

**Function**: `supabase/functions/deposit-calc/index.ts`

**Formula**:
```typescript
const baseRates = { low: 0.10, medium: 0.15, high: 0.20 };
const riskMultipliers = { Low: 1.0, Medium: 1.5, High: 2.5 };

const baseDeposit = itemValuePkr * baseRates[riskTier];
const finalDeposit = Math.ceil(baseDeposit * riskMultipliers[riskLabel]);
```

**Deposit Lifecycle States** (stored in `rentals.deposit_status`):
```
pending → held → released
                → partially_forfeited
                → fully_forfeited
```

**Tasks**:
- [ ] Create Edge Function `deposit-calc` (can be called inside `risk-score`)
- [ ] Result included in risk score output and stored in `rental_requests.deposit_required_pkr`
- [ ] `deposit_status` updated by admin via Supabase dashboard or admin panel
- [ ] Database trigger: send notification when `deposit_status` changes
- [ ] Write unit tests for all tier × risk level combinations

---

### Issue #21 — Deposit Display (Flutter + Next.js)

**Platform**: Flutter + Next.js  
**Labels**: `flutter` `nextjs` `deposits`

**Tasks**:
- [ ] Flutter: Deposit breakdown widget on rental request confirmation screen
- [ ] Flutter: Deposit status chip on rental detail screen (color by state)
- [ ] Next.js: Deposit amount + breakdown in rental request review step
- [ ] Next.js: Deposit status timeline card on `/rentals/[id]`
- [ ] Both: Show formula breakdown (e.g., "Rs. 100,000 × 20% × 1.5x risk = Rs. 30,000")

---

---

## 📝 Milestone 7 — Digital Rental Contract

> **Goal**: Both parties sign a digital contract generated by a Supabase Edge Function. Once signed, the contract record is immutable.

---

### Issue #22 — Contract Generator Edge Function

**Platform**: Supabase Edge Functions  
**Labels**: `supabase` `edge-functions` `contracts`

**Function**: `supabase/functions/contract-gen/index.ts`

**Description**:  
Called when both parties agree to proceed. Generates a structured JSON contract from rental data and stores it in the `contracts` table.

**Contract Contains**:
- Item name, description, value (PKR)
- Owner and renter verified names + user IDs
- Rental start & end dates, daily rate
- Deposit amount held (from deposit-calc)
- Late return penalty: 2% of item value per day (configurable)
- Damage policy thresholds
- Loss/theft reporting procedure (must report within 24h)
- Platform dispute resolution reference
- Generated timestamp + contract version

**Tasks**:
- [ ] Create Edge Function `contract-gen`
- [ ] Fetch all required data from `rental_requests`, `items`, `users`
- [ ] Build `terms_json` object with all contract fields
- [ ] Insert into `contracts` table, link to `rental_request_id`
- [ ] Signing: update `owner_signed_at` or `renter_signed_at` via direct Supabase update (with RLS)
- [ ] After both sign: database trigger sets `rentals.status = 'contract_signed'`
- [ ] Immutability: RLS policy blocks all `UPDATE` on `contracts` once both timestamps are set
- [ ] Generate a human-readable PDF view (using `jspdf` in Next.js or `pdf` Dart package in Flutter)
- [ ] Deploy: `supabase functions deploy contract-gen`

---

### Issue #23 — Contract UI (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `contracts`

**Screens**:
- [ ] **Contract Review Screen** — scrollable contract with all terms rendered from `terms_json`
- [ ] "Sign" FAB only enabled after reaching the end of the scroll
- [ ] Show both parties' signing status with timestamps
- [ ] After both sign: animated success confirmation + rental status updates via Realtime
- [ ] **Contract Detail Screen** — viewable at any point in rental lifecycle
- [ ] PDF download / share button

---

### Issue #24 — Contract UI (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `contracts`

**Pages/Components**:
- [ ] `/rentals/[id]/contract` — contract viewer page
- [ ] Scroll-to-bottom gate before sign button activates
- [ ] `ContractSigningStatus` component — shows owner/renter signed states with timestamps
- [ ] Realtime subscription: update UI when other party signs without page refresh
- [ ] PDF download button (client-side PDF generation from `terms_json`)
- [ ] Confirmation modal after signing

---

---

## 📸 Milestone 8 — Item Condition Evidence System

> **Goal**: Photo/video evidence is captured and stored in Supabase Storage before and after every rental.

---

### Issue #25 — Evidence Storage Setup

**Platform**: Supabase Storage  
**Labels**: `supabase` `storage` `evidence`

**Storage Buckets**:
| Bucket | Access | Path Pattern |
|---|---|---|
| `item-images` | Public read | `item-images/{item_id}/{filename}` |
| `cnic-uploads` | Private (owner + admin only) | `cnic-uploads/{user_id}/{front\|back}` |
| `evidence` | Private (rental parties only) | `evidence/{rental_id}/{pre\|post}/{uploader_id}/{filename}` |
| `avatars` | Public read | `avatars/{user_id}` |

**Tasks**:
- [ ] Create all Storage buckets with correct access rules
- [ ] Write Storage RLS policies (Supabase Storage uses its own policy system)
- [ ] Evidence bucket: only renter or item owner can read/write for their rental
- [ ] `evidence` table: stores `storage_path`, `type` (pre/post), `uploaded_by`, `timestamp`
- [ ] Max file size limits: images 10MB, videos 100MB (set in bucket config)

---

### Issue #26 — Evidence Upload (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `evidence`

**Screens**:
- [ ] **Pre-Rental Evidence Screen (Owner)** — multi-image picker, compress with `flutter_image_compress`, upload to `evidence/{rental_id}/pre/`, insert metadata row
- [ ] **Receipt Confirmation Screen (Renter)** — "I received the item" button + optional photos
- [ ] **Return Evidence Screen (Renter)** — upload return condition photos
- [ ] **Return Confirmation Screen (Owner)** — upload received-state photos
- [ ] **Evidence Gallery Screen** — side-by-side before/after grid fetched from Supabase Storage
- [ ] Upload progress indicator per file
- [ ] Show upload errors with retry option

---

### Issue #27 — Evidence Upload (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `evidence`

**Pages/Components**:
- [ ] `/rentals/[id]/evidence/upload` — drag-and-drop multi-file uploader, direct upload to Supabase Storage using `supabase.storage.from('evidence').upload()`
- [ ] `ImageCompareSlider` — before/after comparison slider component
- [ ] Evidence gallery grid on rental detail page
- [ ] File type and size validation on frontend before upload

---

### Issue #28 — (Optional) Computer Vision Damage Detection

**Platform**: Python FastAPI Microservice  
**Labels**: `python` `computer-vision` `optional`

**Description**:  
A separate Python FastAPI service that accepts two Supabase Storage image URLs and returns a damage confidence score. Called from a Supabase Edge Function after post-rental evidence upload.

**Tasks**:
- [ ] Set up FastAPI service at `/cv-service`
- [ ] `POST /analyze` — accepts `{pre_url, post_url}`, returns `{damage_score: 0.72, regions: [...]}`
- [ ] Use OpenCV SSIM as baseline; optionally upgrade to YOLOv8 fine-tuned on damage
- [ ] Deploy as a separate service (Docker container)
- [ ] Call from Supabase Edge Function via HTTP after post-rental upload
- [ ] Store result in `evidence_analysis` table
- [ ] Flag rental for admin review if `damage_score > 0.6`
- [ ] Show "AI-assisted analysis — not conclusive" disclaimer in all UI

---

---

## ⏱️ Milestone 9 — Rental Lifecycle & Return Monitoring

> **Goal**: A validated state machine governs rental progression. Supabase `pg_cron` jobs automate overdue detection and notifications.

---

### Issue #29 — Rental State Machine

**Platform**: Supabase (PostgreSQL triggers + Edge Functions)  
**Labels**: `supabase` `rentals`

**States**:
```
requested
  → approved (owner accepts)
  → contract_signed (both signed — trigger from contracts table)
  → evidence_uploaded (owner uploads pre photos)
  → active (renter confirms receipt)
  → return_initiated (renter uploads return evidence)
  → completed (owner confirms return)
  → overdue (pg_cron job: past due date, not returned)
  → escalated (pg_cron job: overdue 3+ days)
  → disputed
  → cancelled
```

**Tasks**:
- [ ] Write PostgreSQL function `transition_rental_status(rental_id, new_status)` that validates transitions
- [ ] Log every transition into `rental_events` (from_status, to_status, triggered_by, timestamp)
- [ ] Database trigger: on `rentals.status` change, call `trust-event` Edge Function for relevant events (e.g., `completed` → `on_time_return`)
- [ ] Expose Supabase RPC: `supabase.rpc('transition_rental_status', {...})`
- [ ] Document all valid transitions in `docs/rental-state-machine.md`

---

### Issue #30 — Return Monitoring with pg_cron

**Platform**: Supabase (pg_cron extension)  
**Labels**: `supabase` `pg_cron` `jobs`

**Description**:  
Schedule daily cron jobs using Supabase's built-in `pg_cron` extension. These jobs check for approaching and overdue rentals, update statuses, and queue notifications.

**Cron Jobs**:
```sql
-- Run daily at 08:00 UTC
SELECT cron.schedule('return-monitor', '0 8 * * *',
  $$SELECT net.http_post(
    url := 'https://<project>.supabase.co/functions/v1/return-monitor',
    headers := '{"Authorization": "Bearer <service_role_key>"}'
  )$$
);
```

**Return Monitor Edge Function** (`supabase/functions/return-monitor/index.ts`):
| Condition | Action |
|---|---|
| `due_date - NOW() = 2 days` | Queue "returning soon" notification |
| `due_date - NOW() = 1 day` | Queue "due tomorrow" notification |
| `due_date = TODAY` | Queue "due today" notification |
| `due_date + 1 day < NOW()` | Set `status = overdue`, call `trust-event(late_return)` |
| `due_date + 3 days < NOW()` | Set `status = escalated`, notify both parties |
| `due_date + 7 days < NOW()` | Flag for admin review |

**Tasks**:
- [ ] Create Edge Function `return-monitor`
- [ ] Register `pg_cron` job in `supabase/migrations/004_pg_cron_jobs.sql`
- [ ] Edge Function queries all active + overdue rentals, applies logic
- [ ] Batch-insert notifications for all affected rentals
- [ ] Apply trust score events for late returns
- [ ] Test by temporarily setting `due_date` to the past in dev environment

---

### Issue #31 — Rental Screens (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `rentals`

**Screens**:
- [ ] **My Rentals Screen** — tabs: Active, Pending, Completed, Disputes — queries with Riverpod + Supabase
- [ ] **Rental Detail Screen** — full status timeline (from `rental_events`), contract link, evidence gallery, deposit status, action buttons
- [ ] **Rental Request Screen** — date picker → invoke `risk-score` → show Risk Analysis Screen → confirm
- [ ] **Owner Requests Screen** — incoming requests with renter risk card, approve/reject actions
- [ ] Subscribe to `rentals` Realtime channel for live status updates

---

### Issue #32 — Rental Pages (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `rentals`

**Pages**:
- [ ] `/rentals` — tabbed list (as renter / as owner) with status filters
- [ ] `/rentals/[id]` — detail: timeline, evidence, contract, deposit status, action buttons
- [ ] `/rentals/new?item=[id]` — multi-step form: dates → risk review → deposit → confirm
- [ ] `/owner/requests` — incoming requests with renter risk summaries
- [ ] Supabase Realtime subscription on `/rentals/[id]` for live status changes

---

---

## ⚖️ Milestone 10 — Dispute Resolution System

> **Goal**: A structured dispute process backed by all platform-collected evidence and resolved through the admin panel.

---

### Issue #33 — Disputes Table & Logic

**Platform**: Supabase  
**Labels**: `supabase` `disputes`

**Tasks**:
- [ ] `disputes` table with RLS: only parties involved can insert; admin can update resolution
- [ ] `POST` via `supabase.from('disputes').insert()` — file a dispute
- [ ] Database trigger on `disputes.status` change: call `trust-event` Edge Function
- [ ] On resolution `renter_liable`: call `trust-event(dispute_lost)` for renter
- [ ] On resolution `owner_liable`: call `trust-event(dispute_won)` for renter (restore some score)
- [ ] Update `rentals.deposit_status` based on resolution outcome
- [ ] Notify both parties via notification system

---

### Issue #34 — Dispute Screens (Flutter)

**Platform**: Flutter  
**Labels**: `flutter` `disputes`

**Screens**:
- [ ] **File Dispute Screen** — select type (dropdown), describe issue, optionally attach photos (upload to `evidence` bucket, type `dispute_evidence`)
- [ ] **My Disputes Screen** — list with status chips
- [ ] **Dispute Detail Screen** — timeline, before/after evidence viewer, contract summary, status, resolution notes (when resolved)

---

### Issue #35 — Dispute Pages (Next.js)

**Platform**: Next.js  
**Labels**: `nextjs` `disputes`

**Pages**:
- [ ] `/disputes/new?rental=[id]` — dispute type + description form
- [ ] `/disputes` — user's disputes list
- [ ] `/disputes/[id]` — detail page with `ImageCompareSlider`, contract summary, timeline, resolution card

---

---

## 🔔 Milestone 11 — Realtime Notifications & Alerts

> **Goal**: Users receive instant in-app notifications via Supabase Realtime, plus push notifications (mobile) and email alerts.

---

### Issue #36 — Notification System (Supabase)

**Platform**: Supabase  
**Labels**: `supabase` `notifications`

**Description**:  
All notifications are written to the `notifications` table. Supabase Realtime broadcasts inserts to subscribed clients instantly — no polling needed.

**Notification Events**:
| Event | Recipient |
|---|---|
| Rental request received | Owner |
| Rental approved / rejected | Renter |
| Contract ready to sign | Both |
| Evidence upload reminder | Owner (pre) / Renter (post) |
| Due in 48h / 24h | Renter |
| Rental overdue | Both |
| Dispute filed | Other party |
| Dispute resolved | Both |
| Trust score milestone | User |
| Review received | User |

**Tasks**:
- [ ] All events insert into `notifications` table via Edge Functions or database triggers
- [ ] `notifications` table has RLS: users read only their own rows
- [ ] `GET` notifications: `supabase.from('notifications').select().eq('user_id', uid).order('created_at', {ascending: false})`
- [ ] Mark read: `supabase.from('notifications').update({read: true}).eq('id', notifId)`

---

### Issue #37 — Flutter Realtime Notifications

**Platform**: Flutter  
**Labels**: `flutter` `notifications` `realtime`

**Tasks**:
- [ ] Subscribe to `notifications` Realtime channel on app start:
  ```dart
  supabase.from('notifications')
    .stream(primaryKey: ['id'])
    .eq('user_id', userId)
    .listen((data) => notificationProvider.update(data));
  ```
- [ ] Show in-app banner using `flutter_local_notifications` when new notification arrives in foreground
- [ ] **Notifications Screen** — list with unread/read states, tap to navigate deep link
- [ ] Bell icon in AppBar with unread count badge (Riverpod provider)
- [ ] FCM push for background/terminated app notifications (backend inserts → Edge Function calls FCM)

---

### Issue #38 — Next.js Realtime Notifications

**Platform**: Next.js  
**Labels**: `nextjs` `notifications` `realtime`

**Tasks**:
- [ ] Subscribe to `notifications` Realtime channel in root layout:
  ```typescript
  supabase.channel('notifications')
    .on('postgres_changes', { event: 'INSERT', table: 'notifications', filter: `user_id=eq.${uid}` }, handler)
    .subscribe()
  ```
- [ ] Toast notification popup for new inserts while user is on-site
- [ ] Notification bell dropdown in top nav with unread count badge
- [ ] `/notifications` page — full list with read/unread states, mark all read button

---

### Issue #39 — Email Notifications

**Platform**: Supabase Edge Functions  
**Labels**: `supabase` `edge-functions` `email`

**Tasks**:
- [ ] Use Supabase built-in email (or connect SendGrid in Supabase dashboard → SMTP settings)
- [ ] Edge Function `send-email` triggered for: rental approved, overdue, dispute filed, dispute resolved
- [ ] HTML email templates for each event type
- [ ] Never send more than 3 emails per day per user (throttle in Edge Function)

---

---

## 🛠️ Milestone 12 — Admin Panel (Next.js Web Only)

> **Goal**: Administrators can manage the platform — users, disputes, CNIC reviews, and trust events — using a secure web-only admin interface.

---

### Issue #40 — Admin Authentication & Roles

**Platform**: Supabase + Next.js  
**Labels**: `supabase` `nextjs` `admin` `auth`

**Description**:  
Admins are identified by a custom JWT claim (`role: admin`) set via a Supabase Auth hook.

**Roles**:
| Role | Access |
|---|---|
| `super_admin` | Full access |
| `support_agent` | Disputes + read users |
| `cnic_reviewer` | CNIC upload queue only |

**Tasks**:
- [ ] Set custom claim via Supabase Auth hook (`auth.users` → JWT metadata)
- [ ] Write RLS policies that check `auth.jwt() ->> 'role' = 'admin'`
- [ ] Next.js middleware: protect all `/admin/*` routes, check JWT role claim
- [ ] Admin login at `/admin/login` (separate from user login — service role or magic link)
- [ ] Activity log: every admin action writes to `admin_audit_log` table

---

### Issue #41 — Admin Dashboard

**Platform**: Next.js  
**Labels**: `nextjs` `admin`

**Tasks**:
- [ ] `/admin` — dashboard with metric cards:
  - Total users / new this week
  - Active rentals / overdue rentals
  - Open disputes / resolved this week
  - High-risk transactions flagged
- [ ] Charts using `recharts`: user signups (7d), rental volume (30d), dispute rate (30d)
- [ ] Query metrics using Supabase Server Components (no client-side fetching for admin data)

---

### Issue #42 — Admin User Management

**Platform**: Next.js  
**Labels**: `nextjs` `admin`

**Tasks**:
- [ ] `/admin/users` — paginated user table with search (full-text on name/email)
- [ ] `/admin/users/[id]` — user detail: profile, trust score chart (from `trust_events`), rental history, active disputes
- [ ] Admin actions: suspend account (set `users.status = 'suspended'`), manually verify CNIC, override trust score
- [ ] CNIC review queue `/admin/cnic-queue` — view uploaded images from Storage, approve or reject

---

### Issue #43 — Admin Dispute Review Panel

**Platform**: Next.js  
**Labels**: `nextjs` `admin` `disputes`

**Tasks**:
- [ ] `/admin/disputes` — dispute queue sorted by date, filtered by status
- [ ] `/admin/disputes/[id]` — full dispute review:
  - `ImageCompareSlider` — before vs. after evidence
  - Contract terms panel (from `contracts.terms_json`)
  - Rental timeline (from `rental_events`)
  - Risk score at time of transaction (from `rental_requests.risk_json`)
  - CV damage analysis result (if available)
- [ ] Resolution form: select outcome → enter notes → submit → auto-applies trust events + deposit update
- [ ] Both parties notified via notification system on resolution

---

---

## 🤖 Milestone 13 — (Optional) Computer Vision — Damage Detection

> **Goal**: A standalone Python service that compares before/after evidence images to assist dispute resolution. Stretch goal — only implement after all other milestones are complete.

---

### Issue #44 — Python CV Microservice

**Platform**: Python (FastAPI)  
**Labels**: `python` `computer-vision` `optional`

**Tasks**:
- [ ] Set up FastAPI service with `/analyze` endpoint
- [ ] Accept `{ pre_image_url, post_image_url }` — download from Supabase Storage signed URLs
- [ ] OpenCV SSIM comparison as baseline → return `damage_score` (0.0–1.0) + diff image
- [ ] Optional: YOLOv8 or EfficientDet fine-tuned on damaged vs. undamaged items
- [ ] Containerize with Docker (`Dockerfile` + `docker-compose.yml`)
- [ ] Supabase Edge Function calls this service via HTTP after post-rental evidence upload
- [ ] Store result in `evidence_analysis` table (rental_id, damage_score, diff_image_url, model_version)
- [ ] Add "AI-assisted — for reference only, not a legal determination" disclaimer everywhere results appear

---

---

## 🧪 Milestone 14 — Testing, QA & Documentation

> **Goal**: Reliable, tested, and fully documented system for FYP submission and panel presentation.

---

### Issue #45 — Supabase Edge Function Tests

**Platform**: Supabase (Deno)  
**Labels**: `testing` `supabase`

**Tasks**:
- [ ] `trust-event` unit tests: all 12 event types, clamping at 0 and 100
- [ ] `risk-score` unit tests: all factor combinations, all threshold outcomes
- [ ] `deposit-calc` unit tests: all tier × risk level combinations (9 cases)
- [ ] `contract-gen` unit tests: contract JSON structure validation
- [ ] `return-monitor` unit tests: mock rental states + date assertions
- [ ] Use Deno test runner (`deno test`) and `supabase functions serve` for local testing

---

### Issue #46 — Flutter Tests

**Platform**: Flutter  
**Labels**: `testing` `flutter`

**Tasks**:
- [ ] Widget tests: `RiskBadge`, `TrustScoreGauge`, `AppButton`, `StatusChip`
- [ ] Widget test: `RiskAnalysisScreen` renders correct color and label for each risk level
- [ ] Integration test: full rental request flow (select item → pick dates → see risk → confirm)
- [ ] Integration test: evidence upload flow (pick images → compress → upload → see gallery)
- [ ] Run on Android emulator in GitHub Actions CI

---

### Issue #47 — Next.js Tests

**Platform**: Next.js  
**Labels**: `testing` `nextjs`

**Tasks**:
- [ ] Component tests (Vitest + Testing Library): `RiskScoreCard`, `ContractViewer`, `ImageCompareSlider`
- [ ] Playwright E2E:
  - Register → verify email → browse items → request rental → risk screen → sign contract
  - File dispute → admin resolves → trust score updated
- [ ] Lighthouse audit: ≥ 90 performance, ≥ 90 accessibility on main pages

---

### Issue #48 — FYP Documentation

**Platform**: All  
**Labels**: `documentation`

**Tasks**:
- [ ] `docs/architecture.md` — architecture diagram + layer-by-layer explanation
- [ ] `docs/trust-score.md` — full scoring model with worked examples
- [ ] `docs/risk-engine.md` — algorithm, factors, thresholds, rationale
- [ ] `docs/deposit-system.md` — formula with examples for all 9 combinations
- [ ] `docs/rls-policies.md` — all Row Level Security policies explained
- [ ] `docs/rental-state-machine.md` — state diagram + valid transitions
- [ ] `docs/edge-functions.md` — all Edge Functions: inputs, outputs, side effects
- [ ] `docs/flutter-screens.md` — annotated screen list with navigation map
- [ ] FYP report chapter structure outline
- [ ] Demo walkthrough script for panel presentation

---

### Issue #49 — Seed Data & Demo Setup

**Platform**: Supabase  
**Labels**: `demo`

**Tasks**:
- [ ] Write `supabase/seed.sql` with:
  - 10+ users with varied trust scores (new user, 3 rentals, suspended, perfect score)
  - 20+ items across all 3 risk tiers
  - 5+ completed rentals with full `trust_events` history
  - 2 open disputes with pre/post evidence metadata
  - 1 example of a blocked high-risk transaction (with risk JSON)
  - 1 `super_admin` user
- [ ] Run `supabase db seed` to populate dev database
- [ ] Upload sample evidence images to Storage buckets via seed script
- [ ] Document setup in `docs/demo-setup.md`

---

## 📊 Complete Milestone Summary

| Milestone | Issues | Core Deliverable | Platforms |
|---|---|---|---|
| M1 | #1–6 | Monorepo, Supabase init, DB schema, RLS, Flutter init, Next.js init | All |
| M2 | #7–8 | Design system, component library | Flutter + Next.js |
| M3 | #9–12 | Supabase Auth, OTP, CNIC, profiles | All |
| M4 | #13–15 | Item listings, browse, search | All |
| **M5** | **#16–19** | **Risk engine + Trust engine (Edge Functions) ← FYP core** | **Supabase + Both** |
| M6 | #20–21 | Dynamic deposits (Edge Function + UI) | All |
| M7 | #22–24 | Digital contracts + immutable signing | All |
| M8 | #25–28 | Evidence storage + optional CV | All |
| M9 | #29–32 | State machine + pg_cron return monitoring | All |
| M10 | #33–35 | Dispute system | All |
| M11 | #36–39 | Realtime notifications + FCM push + email | All |
| M12 | #40–43 | Admin panel + CNIC queue + dispute review | Next.js only |
| M13 | #44 | CV damage detection (optional Python service) | Python |
| M14 | #45–49 | Testing, QA, docs, seed data | All |
