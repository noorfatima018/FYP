# 📋 RentWise — Project Issues & Milestones

> **Department of Computer Science — Faculty of Computing & IT — University of Gujrat**  
> *Final Year Project Development Backlog & Milestone Tracking*  
> **Tech Stack**: Flutter (Mobile) · Next.js 14 (Web) · Supabase (PostgreSQL + Auth + Storage + RLS) · Python (Scikit-Learn / XGBoost / NLP)

---

## 🗺️ Milestone Roadmap Overview

| # | Milestone Title | Main Deliverables | Lead | Status |
|---|---|---|---|---|
| **M1** | **Requirements & Planning** | Use cases, system architecture, data flow diagrams, initial backlog | All Members | 🔲 Planned |
| **M2** | **UI/UX Design** | Figma interactive prototypes, mobile & web screen designs, design tokens | Noor Fatima | 🔲 Planned |
| **M3** | **Backend Foundation** | Database schema, authentication/authorization, storage buckets, RLS policies | Imtishal Abid | 🔲 Planned |
| **M4** | **Core Mobile Development** | Flutter app: renter & owner flows, listings, search, booking, agreements, evidence | Areeba Arif | 🔲 Planned |
| **M5** | **Web Development** | Next.js web app: Owner Dashboard & Admin Dashboard | Noor Fatima & Imtishal Abid | 🔲 Planned |
| **M6** | **Core AI** | Python ML risk prediction (Random Forest / XGBoost), explainable risk factors, API | Areeba Arif | 🔲 Planned |
| **M7** | **Secondary AI** | Natural-language recommendations, AI Rental Assistant interface & NLP engine | Areeba Arif & Noor Fatima | 🔲 Planned |
| **M8** | **Optional AI** | NLP review & dispute analysis, computer vision damage detection microservice | Areeba Arif | 🔲 Planned |
| **M9** | **Testing & Integration** | System testing, integration checks, usability testing, performance tuning | Imtishal Abid | 🔲 Planned |
| **M10** | **Finalization** | System deployment, final FYP report, presentation slides, live demonstration | All Members | 🔲 Planned |

---

## 👥 Team Work Division & Responsibility Matrix

| Group Member | Roll Number | Role | Primary Responsibilities |
|---|---|---|---|
| **Areeba Arif** | `23021519-068` | Core Developer, Mobile & AI Engineer | Flutter architecture, mobile app development, core rental workflows, ML risk prediction & explainability (Python/XGBoost), personalized asset recommendation, AI Rental Assistant, AI evaluation, technical integration. |
| **Noor Fatima** | `23021519-007` | UI/UX Designer & Frontend Developer | UI/UX research, Figma screen design & prototyping, mobile UI implementation, Next.js web app frontend, Owner Dashboard, responsive layout, AI feature interface integration, usability testing. |
| **Imtishal Abid** | `23021519-176` | Backend, Admin & Quality Engineer | Supabase schema design & migrations, Auth & role-based access, Storage buckets & security RLS policies, Admin Dashboard, backend transaction services, evidence/dispute management, system integration testing, deployment & documentation support. |

---

---

## 🏁 Milestone 1 — Requirements & Planning

> **Deliverables**: Detailed functional requirements, use case specifications, system architecture diagrams, database entity relationship diagram (ERD), project repository setup, and development backlog.  
> **Lead**: All Team Members

---

### Issue #1 — Repository Initialization & Directory Structure Setup
**Lead**: Imtishal Abid  
**Labels**: `setup` `architecture` `m1`

**Description**:  
Establish the complete monorepo/multi-directory project layout for the Flutter mobile app, Next.js web app, Python AI service, Supabase database configuration, and documentation folder.

**Tasks & Minor Details**:
- [ ] Initialize Git repository with `main` and `develop` feature branches.
- [ ] Configure `.gitignore` rules for Flutter build artifacts (`build/`, `.dart_tool/`), Next.js (`.next/`, `node_modules/`), Python (`__pycache__/`, `.venv/`), and environment files (`.env*`).
- [ ] Set up root project folders:
  - `mobile/` — Flutter application scaffold
  - `web/` — Next.js 14 Web application scaffold
  - `ai_service/` — Python FastAPI microservice scaffold
  - `supabase/` — Supabase CLI config, migrations, and seeds
  - `docs/` — Specifications, architecture diagrams, and FYP draft chapters
- [ ] Add license file and comprehensive `README.md` with project specifications.
- [ ] Configure branch protection rules requiring code review for merges to `main`.

---

### Issue #2 — System Architecture & Data Flow Specification
**Lead**: Areeba Arif & Imtishal Abid  
**Labels**: `architecture` `documentation` `m1`

**Description**:  
Define the high-level application architecture and data flow between the Flutter mobile app, Next.js web app, Supabase PostgreSQL backend, and Python AI service.

**Tasks & Minor Details**:
- [ ] Create detailed application architecture diagram (Flutter <-> Supabase <-> Python AI Service <-> Next.js Web).
- [ ] Document data flow for key workflows:
  - User registration & identity verification flow
  - Asset listing & inventory publishing flow
  - Rental booking request & risk evaluation sequence
  - Contract signing & pre/post evidence submission sequence
  - Dispute filing & admin resolution flow
- [ ] Define API contract specification (REST JSON format) for Python AI microservice endpoints:
  - `POST /api/v1/risk/predict`
  - `POST /api/v1/recommend`
  - `POST /api/v1/assistant/query`
- [ ] Commit architecture document and sequence diagrams to `docs/architecture.md`.

---

### Issue #3 — User Roles, Use Cases & Requirement Specification
**Lead**: Noor Fatima  
**Labels**: `requirements` `documentation` `m1`

**Description**:  
Formulate functional and non-functional requirements and draft comprehensive use case specifications for Renters, Asset Owners, and Platform Administrators.

**Tasks & Minor Details**:
- [ ] Draft Functional Requirement Specifications (FRS) covering:
  - Auth & Profile Management (FR-01 to FR-05)
  - Asset Listing & Search (FR-06 to FR-10)
  - Rental Booking & Contracts (FR-11 to FR-15)
  - Pre/Post Rental Evidence (FR-16 to FR-18)
  - Risk Assessment & AI Features (FR-19 to FR-23)
  - Dispute Resolution & Admin Control (FR-24 to FR-28)
- [ ] Document Use Case Diagrams and write detailed specifications for:
  - UC-01: Rent High-Value Asset
  - UC-02: List Asset for Rent
  - UC-03: Evaluate Transaction Risk
  - UC-04: Submit Pre-Rental Evidence
  - UC-05: Resolve Dispute as Administrator
- [ ] Save detailed requirements matrix in `docs/requirements.md`.

---

---

## 🎨 Milestone 2 — UI/UX Design

> **Deliverables**: Comprehensive Figma design system, wireframes, high-fidelity UI prototypes for mobile (renter & owner) and web (owner dashboard & admin panel), and interactive user flows.  
> **Lead**: Noor Fatima

---

### Issue #4 — Design System & Visual Style Guide
**Lead**: Noor Fatima  
**Labels**: `design` `figma` `m2`

**Description**:  
Establish a cohesive visual design system in Figma specifying color palettes, typography hierarchy, UI components, iconography, elevation shadows, and status color codes.

**Tasks & Minor Details**:
- [ ] Define color tokens:
  - Primary Trust Blue: `#1A73E8`
  - Deep Navy Surface: `#0F172A` / `#1E293B`
  - Low Risk Green: `#2E7D32` / `#4CAF50`
  - Medium Risk Orange: `#EF6C00` / `#FF9800`
  - High Risk Red: `#C62828` / `#F44336`
  - Neutral Grays: `#F8FAFC`, `#E2E8F0`, `#64748B`
- [ ] Select Google Font family (`Inter` or `Plus Jakarta Sans`) and define font scale hierarchy (Display, H1-H4, Body-1/2, Caption, Button).
- [ ] Design reusable UI components in Figma:
  - Primary, secondary, and outline buttons with hover/press states
  - Form inputs, search fields, date pickers, drop-zone file uploaders
  - Risk badge chips, trust score gauge rings, verification status icons
  - Rental status timeline step indicators
- [ ] Document design tokens in `docs/design_system.md`.

---

### Issue #5 — Mobile App UI Screens (Flutter Figma Prototypes)
**Lead**: Noor Fatima  
**Labels**: `design` `mobile` `figma` `m2`

**Description**:  
Create high-fidelity interactive screens in Figma for both Renter and Owner mobile experiences.

**Tasks & Minor Details**:
- [ ] **Renter Experience Screens**:
  - Splash & Onboarding Carousel
  - Login & Register (Email/Phone OTP entry screens)
  - Identity Verification Screen (CNIC document capture UI)
  - Home & Category Browse Screen with search bar and filter bottom sheet
  - Item Detail Screen (Photo slider, owner trust score card, specs tab, pricing, Request button)
  - Rental Request Modal (Date range selector, estimated cost, dynamic deposit estimate)
  - Transaction Risk Score Breakdown Sheet (Renter view)
  - Digital Rental Contract Review & E-Sign Screen
  - Pre-Rental Handover Photo Upload & Inspection Screen
  - Active Rental Status Timeline Screen
  - Post-Rental Return Photo Upload Screen
  - Review & Rating Dialog
  - AI Rental Assistant Chat Overlay UI
- [ ] **Owner Mobile Screens**:
  - Owner Profile & Balance Overview
  - Add New Asset Wizard (Category, specs, daily rate, deposit requirement, photo uploader)
  - My Listings Management Screen (Active, Paused, Unavailable toggles)
  - Incoming Rental Request Screen (Renter profile preview, risk indicator, Approve/Decline actions)
  - Handover Confirmation & Pre-Condition Media Upload Screen
- [ ] Link screens into interactive Figma prototype for usability testing.

---

### Issue #6 — Web Dashboard UI Screens (Next.js Owner & Admin Figma Prototypes)
**Lead**: Noor Fatima  
**Labels**: `design` `web` `figma` `m2`

**Description**:  
Design responsive desktop layouts in Figma for the Owner Web Dashboard and Administrator Panel.

**Tasks & Minor Details**:
- [ ] **Owner Web Dashboard**:
  - Sidebar Navigation & Header bar
  - Inventory Grid & Management Table (Asset status, daily rates, quick edit)
  - Rental Requests Queue (Filter by status, view renter details, inspect risk factors)
  - Active Rentals & Return Schedule Calendar
  - Financial Earnings & Deposit Overview
- [ ] **Admin Panel Screens**:
  - Admin Metric Cards Overview (Total Users, Active Rentals, High-Risk Flags, Open Disputes)
  - User Management Table with verification status badges and suspension actions
  - CNIC Verification Queue (Document reviewer modal with zoom and approve/reject actions)
  - Asset Listing Moderation Grid
  - Platform Transaction Monitor & Risk-Flagged Request List
  - Dispute Resolution Hub (Side-by-side evidence photo comparator, contract viewer, resolution decision form)

---

---

## 🗄️ Milestone 3 — Backend Foundation

> **Deliverables**: Complete Supabase PostgreSQL schema, Row Level Security (RLS) policies, database triggers, Storage buckets for media/documents, and Authentication integration.  
> **Lead**: Imtishal Abid

---

### Issue #7 — PostgreSQL Database Schema & Migration Scripts
**Lead**: Imtishal Abid  
**Labels**: `backend` `supabase` `database` `m3`

**Description**:  
Design and implement the version-controlled SQL migration scripts for all database tables, foreign key relationships, indexes, and ENUM types in Supabase.

**Tables & Schema Details**:
- [ ] Create ENUM types:
  - `user_role`: `renter`, `owner`, `admin`
  - `verification_status`: `unverified`, `pending`, `verified`, `rejected`
  - `risk_level`: `low`, `medium`, `high`
  - `rental_status`: `requested`, `approved`, `rejected`, `contract_signed`, `active`, `return_initiated`, `completed`, `overdue`, `disputed`, `cancelled`
  - `dispute_status`: `open`, `under_review`, `resolved_renter_liable`, `resolved_owner_liable`, `dismissed`
- [ ] Write Migration `001_initial_schema.sql`:
  - `profiles`: `id (UUID -> auth.users)`, `full_name`, `phone`, `role`, `cnic_hash`, `verification_status`, `trust_score (default 50)`, `avatar_url`, `created_at`
  - `assets`: `id`, `owner_id (FK)`, `title`, `description`, `category`, `specifications (JSONB)`, `value_pkr`, `daily_rate_pkr`, `deposit_pkr`, `is_available`, `images (TEXT[])`, `created_at`
  - `rental_requests`: `id`, `asset_id (FK)`, `renter_id (FK)`, `start_date`, `end_date`, `total_price_pkr`, `estimated_deposit_pkr`, `status`, `risk_score`, `risk_level`, `risk_factors (JSONB)`, `created_at`
  - `rental_agreements`: `id`, `rental_request_id (FK)`, `terms_text`, `owner_signed_at`, `renter_signed_at`, `agreed_deposit_pkr`, `created_at`
  - `condition_evidence`: `id`, `rental_request_id (FK)`, `uploader_id (FK)`, `stage ('pre_rental' | 'post_rental')`, `image_urls (TEXT[])`, `notes`, `created_at`
  - `reviews`: `id`, `rental_request_id (FK)`, `reviewer_id (FK)`, `reviewee_id (FK)`, `rating (1-5)`, `comment`, `created_at`
  - `disputes`: `id`, `rental_request_id (FK)`, `raised_by (FK)`, `issue_category`, `description`, `evidence_urls (TEXT[])`, `status`, `admin_notes`, `resolved_at`, `created_at`
- [ ] Add performance database indexes on `assets(category)`, `assets(owner_id)`, `rental_requests(renter_id, status)`, and `profiles(role)`.

---

### Issue #8 — Row Level Security (RLS) Policies & Database Triggers
**Lead**: Imtishal Abid  
**Labels**: `backend` `supabase` `security` `m3`

**Description**:  
Configure strict Row Level Security (RLS) policies on every table so users can only view and modify data authorized for their role.

**Tasks & Minor Details**:
- [ ] Enable RLS on all tables (`ALTER TABLE x ENABLE ROW LEVEL SECURITY;`).
- [ ] Write RLS policies for `profiles`:
  - Public read for basic fields (`full_name`, `avatar_url`, `trust_score`, `verification_status`).
  - Owner user write only to their own row (`auth.uid() = id`).
  - Admin full read/write access.
- [ ] Write RLS policies for `assets`:
  - Public read for all available assets.
  - Owner write/update/delete for own assets (`auth.uid() = owner_id`).
- [ ] Write RLS policies for `rental_requests`:
  - Renter read own requests (`auth.uid() = renter_id`).
  - Owner read requests for their assets (`auth.uid() = asset.owner_id`).
  - Renter create request (`auth.uid() = renter_id`).
  - Owner update status (`approved`, `rejected`).
- [ ] Write RLS policies for `disputes`:
  - Parties involved (renter/owner) can view and create disputes for their rentals.
  - Only Admin can update dispute status and resolution notes.
- [ ] Create automated trigger `on_auth_user_created` to insert a row into `profiles` whenever a new user registers.

---

### Issue #9 — Supabase Auth & Storage Bucket Configuration
**Lead**: Imtishal Abid  
**Labels**: `backend` `supabase` `auth` `storage` `m3`

**Description**:  
Set up Supabase Authentication services and secure storage buckets for user avatars, asset images, identity documents (CNIC), and condition evidence media.

**Tasks & Minor Details**:
- [ ] Configure Supabase Auth providers:
  - Email & Password registration
  - Email OTP / Magic link verification
  - Phone number SMS OTP authentication
- [ ] Create Storage Buckets in Supabase:
  - `asset-images` (Public read, authenticated owner upload)
  - `avatars` (Public read, authenticated user upload)
  - `cnic-documents` (Private access, authenticated user upload to own folder, admin read access)
  - `condition-evidence` (Private access, renter & owner of transaction read/write)
- [ ] Write Storage RLS security policies restricting bucket access based on user UUID path patterns (`cnic-documents/{user_id}/*`).
- [ ] Set max file size limits (10MB for photos, 50MB for video evidence clips).

---

---

## 📱 Milestone 4 — Core Mobile Development

> **Deliverables**: Cross-platform Flutter mobile application implementing full renter and owner workflows, asset discovery, booking, digital contract signing, condition evidence upload, and ratings.  
> **Lead**: Areeba Arif

---

### Issue #10 — Flutter App Architecture, Navigation & Theme System
**Lead**: Areeba Arif  
**Labels**: `mobile` `flutter` `architecture` `m4`

**Description**:  
Establish the Flutter mobile application structure, state management solution (Riverpod), navigation routes (`go_router`), design system components, and Supabase client integration.

**Tasks & Minor Details**:
- [ ] Scaffold Flutter project with clear feature-first package structure:
  - `lib/core/` (theme, constants, network, utils, supabase_client)
  - `lib/features/auth/`
  - `lib/features/assets/`
  - `lib/features/rentals/`
  - `lib/features/contracts/`
  - `lib/features/evidence/`
  - `lib/features/disputes/`
- [ ] Implement `AppTheme` with custom light and dark color schemes matching Figma specifications.
- [ ] Configure `Riverpod` providers for auth state, current user profile, and active rental subscriptions.
- [ ] Configure `go_router` with route guards redirecting unauthenticated users to `/login` and unverified users to `/verify-identity`.
- [ ] Initialize `Supabase.initialize(url: ..., anonKey: ...)` in `main.dart`.

---

### Issue #11 — Authentication & Identity Verification Screens (Flutter)
**Lead**: Areeba Arif & Noor Fatima  
**Labels**: `mobile` `flutter` `auth` `m4`

**Description**:  
Develop user onboarding, registration, login (Email/Phone OTP), and CNIC identity upload screens.

**Tasks & Minor Details**:
- [ ] Implement Onboarding Carousel screen with project introduction slides.
- [ ] Build Login & Registration screen supporting Email + Password and Phone OTP workflows.
- [ ] Create OTP Entry widget with 6-digit pin input and auto-resend timer.
- [ ] Build **Identity Verification Hub**:
  - Displays verification status pill (Unverified / Pending / Verified).
  - CNIC Front & Back image capture screen using `image_picker` or camera package.
  - Image preview, crop, and upload to Supabase private `cnic-documents` storage bucket.
  - Updates profile `verification_status = 'pending'`.
- [ ] Build User Profile screen showing trust score gauge, active role, completed rental count, and edit profile option.

---

### Issue #12 — Asset Search, Filtering & Detail Screens (Flutter)
**Lead**: Areeba Arif & Noor Fatima  
**Labels**: `mobile` `flutter` `assets` `m4`

**Description**:  
Implement asset browsing, search bar, category filtering, and high-value asset detail view.

**Tasks & Minor Details**:
- [ ] Build Home screen with search bar, category icon horizontal list (Cameras, Laptops, Projectors, Gaming, Tools), and featured assets grid.
- [ ] Implement Asset Search & Filter sheet allowing filtering by:
  - Category
  - Daily rental rate range (PKR)
  - Availability date window
  - Minimum owner trust score
- [ ] Build **Asset Detail Screen**:
  - Image carousel slider with thumbnail indicator
  - Asset title, category, description, and specifications key-value table
  - Owner profile card (name, avatar, trust score badge, response rate)
  - Pricing breakdown card (daily rate + deposit requirement)
  - "Request Rental" primary floating action bar
- [ ] Connect screens to Supabase `assets` table queries.

---

### Issue #13 — Rental Request, Booking & Agreement Signing Workflows (Flutter)
**Lead**: Areeba Arif  
**Labels**: `mobile` `flutter` `rentals` `contracts` `m4`

**Description**:  
Develop the renter request submission modal, risk confirmation dialog, digital rental contract review, and digital signature workflow.

**Tasks & Minor Details**:
- [ ] Build **Rental Request Modal**:
  - Interactive calendar date range picker (`start_date` to `end_date`)
  - Real-time calculation of rental duration, total cost, and required deposit
  - Submit request -> Triggers risk prediction API call -> Displays risk indicator summary
- [ ] Build **Renter & Owner Rental Request Management Tabs**:
  - Renter "My Rentals" list (Requested, Approved, Active, Completed, Cancelled)
  - Owner "Incoming Requests" list with renter profile and risk score badge
  - Owner Approve / Decline actions
- [ ] Build **Digital Rental Agreement Screen**:
  - Renders terms text: asset specs, dates, pricing, late return penalty clause, damage policy
  - Interactive "Slide to Agree & Sign" widget
  - Updates `rental_agreements` table (`renter_signed_at` / `owner_signed_at`)
  - Updates rental request status to `contract_signed`

---

### Issue #14 — Pre/Post Condition Evidence & Returns Workflow (Flutter)
**Lead**: Areeba Arif  
**Labels**: `mobile` `flutter` `evidence` `m4`

**Description**:  
Build the pre-rental handover evidence capture, post-rental return evidence upload, and ratings/reviews screens.

**Tasks & Minor Details**:
- [ ] Build **Pre-Rental Evidence Screen (Owner & Renter)**:
  - Camera capture interface for recording item condition photos/videos prior to handover
  - Condition notes text field (noting pre-existing scratches, accessories included)
  - Upload media to Supabase `condition-evidence/pre_rental/` bucket
  - "Confirm Handover & Start Rental" action -> Status changes to `active`
- [ ] Build **Post-Rental Return Evidence Screen**:
  - Renter uploads photos upon returning asset
  - Owner inspects asset and uploads return verification media to `condition-evidence/post_rental/` bucket
  - "Confirm Return & Complete Rental" action -> Status changes to `completed`
- [ ] Build **Rating & Review Dialog**:
  - 5-star rating bar + written review comment
  - Submits review to Supabase `reviews` table
- [ ] Build **Dispute Filing Screen**:
  - Category selector (Damage, Late Return, Missing Item, Unfair Deposit Claim)
  - Description box and evidence photo uploader -> Submits to `disputes` table

---

---

## 💻 Milestone 5 — Web Development

> **Deliverables**: Next.js 14 web application featuring Owner Inventory & Request Dashboard and Administrator Risk, Verification & Dispute Panel.  
> **Lead**: Noor Fatima & Imtishal Abid

---

### Issue #15 — Next.js Application Scaffold, Auth Guards & Layout System
**Lead**: Noor Fatima & Imtishal Abid  
**Labels**: `web` `nextjs` `architecture` `m5`

**Description**:  
Setup Next.js 14 project with App Router, TypeScript, Tailwind CSS, Supabase SSR client (`@supabase/ssr`), and role-based route middleware.

**Tasks & Minor Details**:
- [ ] Scaffold Next.js project with App Router structure:
  - `app/(auth)/` (login, register, reset-password)
  - `app/(owner)/` (inventory, requests, active-rentals, earnings)
  - `app/(admin)/` (overview, users, cnic-queue, transactions, disputes)
- [ ] Configure `@supabase/ssr` server and browser client utilities.
- [ ] Build Next.js `middleware.ts` protecting routes:
  - `/owner/*` requires authenticated user with role `owner` or `renter`
  - `/admin/*` requires authenticated user with custom claim/role `admin`
- [ ] Create responsive dashboard shell component (Sidebar, Top Navigation, User Dropdown, Notifications bell).

---

### Issue #16 — Owner Web Dashboard Features (Next.js)
**Lead**: Noor Fatima  
**Labels**: `web` `nextjs` `owner` `m5`

**Description**:  
Implement web interfaces for asset owners to manage listings, inspect incoming rental requests with renter risk details, track active rentals, and view earnings.

**Tasks & Minor Details**:
- [ ] Build **Inventory Management Page (`/owner/inventory`)**:
  - Asset data table displaying thumbnail, title, category, daily rate, deposit, availability toggle
  - Add New Asset Modal with multi-photo uploader and specification key-value editor
  - Edit & Delete asset actions
- [ ] Build **Rental Requests Queue Page (`/owner/requests`)**:
  - Card view of incoming rental requests
  - Renter profile popup: name, verification status, trust score badge, past rental count
  - Integrated Risk Assessment Card showing predicted risk score and explainable risk factors
  - Approve & Decline button actions
- [ ] Build **Active Rentals & Return Tracking Page (`/owner/rentals`)**:
  - Status timeline for active rentals
  - Pre/post evidence gallery viewer
  - Handover and Return confirmation actions
- [ ] Build **Earnings Summary Card Widget**: Shows total revenue earned and deposit holds.

---

### Issue #17 — Administrator Panel & CNIC Verification Queue (Next.js)
**Lead**: Imtishal Abid & Noor Fatima  
**Labels**: `web` `nextjs` `admin` `m5`

**Description**:  
Develop the web admin panel for system overview metrics, identity verification review, user moderation, and listing management.

**Tasks & Minor Details**:
- [ ] Build **Admin Overview Page (`/admin`)**:
  - Metric summary cards: Total Registered Users, Active Listings, Active Rentals, Flagged High-Risk Transactions, Open Disputes
  - System activity audit log table
- [ ] Build **CNIC Verification Queue (`/admin/cnic-queue`)**:
  - Table of users with `verification_status = 'pending'`
  - Document reviewer modal displaying user details, full-size CNIC Front & Back images with pan/zoom tools
  - Approve action -> Sets profile `verification_status = 'verified'`, awards trust bonus
  - Reject action -> Prompts for rejection reason, sets status to `rejected`, notifies user
- [ ] Build **User Management Page (`/admin/users`)**:
  - User search & filter table (by role, status, trust score)
  - Suspend / Unsuspend user actions
- [ ] Build **Listing Moderation Page (`/admin/listings`)**: Moderation table to remove inappropriate asset listings.

---

### Issue #18 — Admin Dispute Resolution Hub & Transaction Monitor (Next.js)
**Lead**: Imtishal Abid  
**Labels**: `web` `nextjs` `admin` `disputes` `m5`

**Description**:  
Create the specialized admin dispute resolution workspace featuring side-by-side evidence comparison, rental contract terms inspection, and admin override controls.

**Tasks & Minor Details**:
- [ ] Build **Platform Transaction Monitor (`/admin/transactions`)**:
  - Real-time list of all platform rental transactions
  - High-risk transaction filter highlight
- [ ] Build **Dispute Resolution Hub (`/admin/disputes/[id]`)**:
  - Case overview: Renter vs Owner details, rental dates, asset info, claimed issue category
  - Side-by-side **Condition Evidence Image Comparator**: Displays pre-rental handover photos directly next to post-rental return photos
  - Rental Agreement Viewer: Full contract text and timestamped signature logs
  - Transaction Timeline Log: History of request, approval, handover, return, and dispute submission events
  - **Admin Resolution Control Panel**:
    - Decision selector: `Resolve in Renter's Favor`, `Resolve in Owner's Favor`, `Split Deposit`, `Dismiss Dispute`
    - Financial deposit allocation input fields
    - Mandatory Admin Resolution Rationale text box
    - Submit Resolution Action -> Updates `disputes` table, adjusts user trust scores, notifies both parties.

---

---

## 🤖 Milestone 6 — Core AI

> **Deliverables**: Python FastAPI ML microservice for transaction risk prediction using Random Forest or XGBoost models, Explainable AI (XAI) factor generator, and API integration with Supabase/Flutter/Next.js.  
> **Lead**: Areeba Arif

---

### Issue #19 — Dataset Preparation, Feature Engineering & Risk Labeling
**Lead**: Areeba Arif  
**Labels**: `ai` `python` `machine-learning` `m6`

**Description**:  
Prepare training/evaluation dataset, engineer domain-specific transaction risk features, and define risk calculation baseline logic.

**Tasks & Minor Details**:
- [ ] Build synthetic and annotated rental transaction dataset containing user, asset, and request attributes:
  - Renter features: `account_age_days`, `verification_status_code`, `trust_score`, `completed_rentals_count`, `late_returns_count`, `disputes_count`, `avg_rating_given`
  - Owner features: `owner_trust_score`, `owner_completed_rentals`
  - Asset features: `asset_value_pkr`, `asset_category_risk_index`, `daily_rate_pkr`
  - Transaction features: `rental_duration_days`, `value_to_deposit_ratio`, `is_first_time_renter_with_owner`
- [ ] Define target risk score variable `risk_score` (0.00 to 1.00) and risk tier label:
  - Low Risk: `0.00 <= score < 0.35`
  - Medium Risk: `0.35 <= score < 0.65`
  - High Risk: `0.65 <= score <= 1.00`
- [ ] Perform train/test split (80/20) and save preprocessed feature pipeline using `joblib`.
- [ ] Commit dataset preparation script to `ai_service/scripts/prepare_dataset.py`.

---

### Issue #20 — ML Transaction Risk Prediction Model Training & Evaluation
**Lead**: Areeba Arif  
**Labels**: `ai` `python` `machine-learning` `m6`

**Description**:  
Train, evaluate, and hyperparameter-tune Machine Learning classification models (Random Forest and XGBoost) for transaction risk prediction.

**Tasks & Minor Details**:
- [ ] Train baseline Random Forest Classifier and XGBoost Classifier on training dataset.
- [ ] Perform hyperparameter optimization using Grid Search / Random Search (`max_depth`, `n_estimators`, `learning_rate`, `subsample`).
- [ ] Evaluate model performance metrics:
  - Classification Accuracy
  - Precision, Recall, and F1-Score per risk tier
  - ROC-AUC Curve analysis
- [ ] Select best performing model (XGBoost / Random Forest) and export trained model binary to `ai_service/models/risk_model.joblib`.
- [ ] Document model architecture, feature weights, and evaluation benchmarks in `docs/ml_risk_model_report.md`.

---

### Issue #21 — Explainable AI (XAI) Risk Factor Generator
**Lead**: Areeba Arif  
**Labels**: `ai` `python` `explainable-ai` `m6`

**Description**:  
Implement an Explainable AI module using feature contribution analysis (SHAP or model feature importance) to translate model predictions into human-readable risk factors.

**Tasks & Minor Details**:
- [ ] Integrate SHAP (SHapley Additive exPlanations) or TreeExplainer into risk inference pipeline.
- [ ] Convert raw numerical feature attribution values into plain English risk explanations:
  - Example (+) risk drivers: *"Renter account is less than 7 days old"*, *"Asset value exceeds 150,000 PKR"*, *"Renter has 1 prior late return"*
  - Example (-) risk mitigators: *"Renter identity is fully verified with CNIC"*, *"High user trust score (85/100)"*
- [ ] Format output JSON to include top 3 risk factors, recommended safety action (`auto_approve`, `require_cnic`, `increase_deposit`, `admin_review`), and suggested deposit adjustment multiplier.
- [ ] Save module under `ai_service/explainability/risk_explainer.py`.

---

### Issue #22 — Python FastAPI Microservice & API Integration
**Lead**: Areeba Arif & Imtishal Abid  
**Labels**: `ai` `python` `fastapi` `backend` `m6`

**Description**:  
Expose the trained risk model and XAI factor generator via a lightweight Python FastAPI HTTP service for consumption by Supabase, Flutter, and Next.js.

**Tasks & Minor Details**:
- [ ] Setup FastAPI application in `ai_service/app.py` with CORS middleware.
- [ ] Create endpoint `POST /api/v1/risk/predict`:
  - Request Body: JSON payload containing renter ID, asset ID, rental dates, and pricing.
  - Fetches or accepts user/asset feature vector.
  - Executes ML model inference.
  - Generates SHAP explainable risk factors.
  - Returns JSON response:
    ```json
    {
      "risk_score": 0.42,
      "risk_level": "medium",
      "risk_factors": [
        "High asset monetary value (120,000 PKR)",
        "Renter completed fewer than 3 rentals",
        "Identity verified via CNIC (-15% risk mitigation)"
      ],
      "recommended_action": "require_deposit",
      "recommended_deposit_pkr": 25000
    }
    ```
- [ ] Add Dockerfile for containerizing `ai_service`.
- [ ] Integrate API call inside Flutter booking request flow and Next.js Owner Request review page.

---

---

## 💡 Milestone 7 — Secondary AI

> **Deliverables**: Personalized Asset Recommendation engine based on natural-language renter requirements and interactive conversational AI Rental Assistant interface.  
> **Lead**: Areeba Arif & Noor Fatima

---

### Issue #23 — Personalized Asset Recommendation Engine
**Lead**: Areeba Arif  
**Labels**: `ai` `python` `recommendation` `m7`

**Description**:  
Develop an intelligent recommendation module that accepts natural-language user search requirements, parses intent and specifications, and scores available rental assets.

**Tasks & Minor Details**:
- [ ] Implement NLP query parser in `ai_service/recommendation/recommender.py`:
  - Extracts key entities from query text: target category (e.g., "DSLR camera"), maximum budget per day, rental dates, and key features (e.g., "4K video recording", "lightweight projector").
- [ ] Build hybrid recommendation scoring function combining:
  - Text similarity match between user prompt and asset title/description/specifications
  - Price compatibility score
  - Asset availability check
  - Owner reputation & trust score weighting
- [ ] Expose FastAPI endpoint `POST /api/v1/recommend`:
  - Input: `{ "user_query": "Need a high resolution camera for a weekend wedding shoot under 5000/day", "user_id": "..." }`
  - Output: Ranked list of recommended asset IDs with similarity scores and match reasons.
- [ ] Integrate recommendation carousel widget on Flutter Home Screen and Next.js Renter Browse page.

---

### Issue #24 — Conversational AI Rental Assistant Interface & Engine
**Lead**: Areeba Arif & Noor Fatima  
**Labels**: `ai` `python` `nlp` `mobile` `m7`

**Description**:  
Implement an interactive conversational AI Rental Assistant capable of understanding user queries regarding asset search, rental policies, risk explanations, and contract steps.

**Tasks & Minor Details**:
- [ ] Develop NLP / LLM conversation handler in `ai_service/assistant/assistant_engine.py`:
  - Handles intent categories: `search_assets`, `check_availability`, `explain_risk_score`, `contract_help`, `dispute_policy_faq`
  - Integrates structured system prompt and knowledge context regarding RentWise platform rules.
- [ ] Expose FastAPI endpoint `POST /api/v1/assistant/chat`:
  - Input: `{ "session_id": "...", "user_message": "How does the rental deposit work for laptops?" }`
  - Output: Natural language response with contextual links/action buttons (e.g., "View Verification Hub").
- [ ] Build **AI Rental Assistant UI Widget in Flutter**:
  - Floating action bot button on main screens
  - Expandable chat window with animated message bubbles, typing indicator, and quick prompt chips ("Find Cameras", "Explain My Risk Score", "How to Return Item")
- [ ] Connect Flutter UI to `assistant/chat` endpoint.

---

---

## 🔮 Milestone 8 — Optional AI

> **Deliverables**: NLP Review & Dispute sentiment analysis and prototype Computer Vision (CV) physical damage detection microservice module.  
> **Lead**: Areeba Arif

---

### Issue #25 — NLP Review & Dispute Analysis Module
**Lead**: Areeba Arif  
**Labels**: `ai` `python` `nlp` `optional` `m8`

**Description**:  
Build an optional NLP analysis service that scans user review text and dispute descriptions for sentiment intensity, complaint categorization, and admin escalation flagging.

**Tasks & Minor Details**:
- [ ] Implement text sentiment and classification pipeline using Python NLTK / TextBlob / Transformers in `ai_service/nlp/dispute_analyzer.py`.
- [ ] Categorize text into complaint buckets: `damaged_equipment`, `late_return`, `unresponsive_user`, `payment_dispute`, `fake_listing`.
- [ ] Detect high-urgency keywords (e.g., "stolen", "stole", "broken", "police", "fraud") -> Set `escalation_flag = true`.
- [ ] Expose endpoint `POST /api/v1/nlp/analyze-dispute`.
- [ ] Display sentiment badge and automated complaint tags inside Next.js Admin Dispute Resolution Hub.

---

### Issue #26 — Computer Vision Damage Detection Microservice (Prototype)
**Lead**: Areeba Arif  
**Labels**: `ai` `python` `computer-vision` `optional` `m8`

**Description**:  
Develop a stretch-goal prototype microservice that compares pre-rental and post-rental asset photos to highlight structural changes, surface scratches, or damage.

**Tasks & Minor Details**:
- [ ] Implement image alignment and structural diff module using OpenCV (`cv2`) image processing (SSIM — Structural Similarity Index Measure) in `ai_service/cv/damage_detector.py`.
- [ ] Endpoint `POST /api/v1/cv/detect-damage`:
  - Accepts `pre_rental_image_url` and `post_rental_image_url`.
  - Downloads images, normalizes dimensions and orientation.
  - Computes SSIM score and generates bounding box heatmap over detected visual differences.
  - Returns `{ "similarity_score": 0.82, "potential_damage_detected": true, "diff_heatmap_url": "..." }`.
- [ ] Render visual difference heatmap overlay in Admin Dispute Resolution view with explicit disclaimer: *"AI-assisted visual comparison — for administrative reference only."*

---

---

## 🧪 Milestone 9 — Testing & Integration

> **Deliverables**: Comprehensive system testing, unit tests for backend and AI components, integration testing between Flutter/Next.js/Supabase/Python AI, usability testing, and performance optimization.  
> **Lead**: Imtishal Abid & Team

---

### Issue #27 — Database & Backend Security Unit Testing
**Lead**: Imtishal Abid  
**Labels**: `testing` `supabase` `security` `m9`

**Description**:  
Verify PostgreSQL database queries, foreign key constraints, RLS policy enforcement, and Supabase storage bucket permissions.

**Tasks & Minor Details**:
- [ ] Write SQL test scripts testing RLS policy isolation:
  - Verify user A cannot read/modify user B's CNIC documents.
  - Verify renters can only view public fields of other user profiles.
  - Verify owners cannot edit rental requests belonging to other owners.
- [ ] Test database triggers: `on_auth_user_created` profile creation.
- [ ] Validate foreign key CASCADE / RESTRICT rules on asset deletion with active rentals.

---

### Issue #28 — Flutter Mobile App Testing & Device Validation
**Lead**: Areeba Arif  
**Labels**: `testing` `flutter` `mobile` `m9`

**Description**:  
Conduct unit, widget, and integration testing on the Flutter mobile app across Android emulators and iOS simulators.

**Tasks & Minor Details**:
- [ ] Write Flutter unit tests for Riverpod providers and model JSON deserialization (`asset_model_test.dart`, `risk_score_test.dart`).
- [ ] Write Widget tests for core components:
  - `RiskBadge` displays correct background colors for Low, Medium, High risk tiers
  - `TrustScoreGauge` renders correct percentage arc
  - `AppButton` handles disabled and loading states
- [ ] Perform end-to-end manual walkthrough tests on Android & iOS emulators:
  - Full registration -> CNIC upload -> Asset browse -> Rental request -> Contract sign -> Pre/post evidence upload flow.

---

### Issue #29 — Next.js Web App & API Integration Testing
**Lead**: Noor Fatima & Imtishal Abid  
**Labels**: `testing` `web` `nextjs` `m9`

**Description**:  
Test web dashboard responsiveness, Next.js server actions, middleware route guards, and Python AI API integration.

**Tasks & Minor Details**:
- [ ] Test middleware route guards: Attempt unauthorized browser access to `/admin` without admin JWT claim -> Verify redirect to login.
- [ ] Test cross-browser responsive layout on Chrome, Firefox, Safari, and mobile web viewport widths.
- [ ] Test Python AI service integration:
  - Verify `POST /api/v1/risk/predict` handles missing feature defaults gracefully without server crash.
  - Verify error fallback UI when AI microservice is offline (falls back to rule-based risk calculation).

---

### Issue #30 — System Usability Evaluation & Bug Fixes
**Lead**: Noor Fatima & Team  
**Labels**: `testing` `usability` `bugs` `m9`

**Description**:  
Conduct usability testing sessions with representative users (renters and owners) to collect feedback and resolve UI/UX friction points and software bugs.

**Tasks & Minor Details**:
- [ ] Prepare System Usability Scale (SUS) evaluation questionnaire focusing on:
  - Ease of discovering assets
  - Clarity of Risk Score and Explainable Risk Factors
  - Directness of Digital Contract Signing
  - Convenience of Pre/Post Photo Evidence upload
- [ ] Log identified UI/UX defects into issue tracking log.
- [ ] Execute bug fixing sprint addressing high-priority UI alignment, formatting, and performance defects.

---

---

## 🎓 Milestone 10 — Finalization

> **Deliverables**: Full system deployment, finalized FYP project report, presentation slide deck, seed dataset, and live project demonstration.  
> **Lead**: All Team Members

---

### Issue #31 — System Deployment & Cloud Hosting Setup
**Lead**: Imtishal Abid & Areeba Arif  
**Labels**: `deployment` `devops` `m10`

**Description**:  
Deploy the production backend instance on Supabase Cloud, host the Next.js web app on Vercel, host the Python AI FastAPI microservice on Render / Railway / Docker container, and generate Android APK build.

**Tasks & Minor Details**:
- [ ] Link local Supabase project to production Supabase Cloud project (`supabase link`).
- [ ] Apply all SQL migrations (`supabase db push`) and configure production Auth settings and Storage bucket permissions.
- [ ] Deploy Next.js Web App to **Vercel**:
  - Configure environment variables (`NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`).
  - Verify custom domain and SSL certificate.
- [ ] Deploy Python AI Microservice (`ai_service`) to Render / Railway Docker container:
  - Set production environment variables and CORS origins.
  - Verify health check endpoint `GET /health`.
- [ ] Build Flutter Android APK release binary (`flutter build apk --release`) for device testing and demonstration.

---

### Issue #32 — Seed Dataset & Live Demo Setup
**Lead**: Imtishal Abid  
**Labels**: `demo` `seed` `m10`

**Description**:  
Prepare realistic seed dataset in PostgreSQL and Supabase Storage to ensure smooth, realistic data presentation during live evaluation panel demo.

**Tasks & Minor Details**:
- [ ] Populate `supabase/seed.sql` with rich demo data:
  - 10 pre-configured user accounts with varied roles, verification statuses, and trust scores (e.g., Unverified Renter, High-Trust Owner, Admin).
  - 15 high-value asset listings (DSLR Cameras, MacBooks, 4K Projectors, PlayStation 5, Laser Measuring Tools) with high-res photos and full specifications.
  - 5 historical rental transactions with signed contracts, pre/post evidence photos, ratings, and reviews.
  - 2 sample active disputes with side-by-side evidence ready for admin resolution demo.
- [ ] Seed storage buckets with sample CNIC cards, item images, and evidence media.
- [ ] Draft step-by-step Live Demo Script for FYP panel presentation.

---

### Issue #33 — FYP Final Documentation, Report & Slide Deck Preparation
**Lead**: All Team Members  
**Labels**: `documentation` `fyp-report` `m10`

**Description**:  
Compile the final Final Year Project (FYP) report according to University of Gujrat formatting guidelines, and prepare the final presentation slide deck.

**Tasks & Minor Details**:
- [ ] Compile FYP Report Chapters:
  - **Chapter 1**: Introduction, Problem Statement, Objectives, Scope
  - **Chapter 2**: Literature Review & Competitive Analysis
  - **Chapter 3**: Software Requirement Specification (SRS) & Use Cases
  - **Chapter 4**: System Architecture, ERD Schema & Design Specs
  - **Chapter 5**: AI Models, ML Risk Engine & Explainability Implementation
  - **Chapter 6**: Implementation & Testing Verification
  - **Chapter 7**: Conclusion, Limitations & Future Work
- [ ] Format document: Table of contents, list of figures, list of tables, references (IEEE format).
- [ ] Design high-impact Final Defense Slide Deck (20-25 slides) covering problem, solution, AI innovation, live demo walk-through, work division, and conclusions.
- [ ] Review report with Supervisor **Mr. Zafar Mehmood** prior to final submission.

---

## 📊 Summary of Issues by Milestone

| Milestone | Issue IDs | Core Deliverable Focus | Lead |
|---|---|---|---|
| **M1: Requirements & Planning** | #1 – #3 | Monorepo setup, architecture specs, FRS & use cases | All Members |
| **M2: UI/UX Design** | #4 – #6 | Figma design system, Flutter screens, Web dashboard UI | Noor Fatima |
| **M3: Backend Foundation** | #7 – #9 | Supabase SQL schema, RLS policies, Auth & Storage buckets | Imtishal Abid |
| **M4: Core Mobile Development** | #10 – #14 | Flutter mobile app, renter/owner flows, contracts, evidence | Areeba Arif |
| **M5: Web Development** | #15 – #18 | Next.js web app, Owner Dashboard, Admin Dispute Hub | Noor Fatima & Imtishal Abid |
| **M6: Core AI** | #19 – #22 | Python ML risk prediction (XGBoost), SHAP XAI, FastAPI service | Areeba Arif |
| **M7: Secondary AI** | #23 – #24 | Asset recommendation engine & AI Rental Assistant UI | Areeba Arif & Noor Fatima |
| **M8: Optional AI** | #25 – #26 | NLP review/dispute analysis & CV damage detection prototype | Areeba Arif |
| **M9: Testing & Integration** | #27 – #30 | RLS security tests, Flutter tests, Web tests, usability evaluation | Imtishal Abid & Team |
| **M10: Finalization** | #31 – #33 | Cloud deployment, seed data, final FYP report & slides | All Members |
