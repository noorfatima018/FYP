# 🛡️ RentWise — Trust & Risk Management Platform for Peer-to-Peer Asset Sharing

> **"Don't just match renters and owners — protect both of them."**

---

## 📌 What is RentWise?

RentWise is a **peer-to-peer rental platform with a built-in trust and risk engine**. It allows individuals to lend and borrow physical assets (cameras, laptops, appliances, vehicles, etc.) while intelligently assessing the risk of every transaction *before* it happens.

Unlike typical rental apps that simply connect buyers and sellers, RentWise acts as a **digital trust layer** — evaluating users, calculating dynamic risk scores, generating digital contracts, and maintaining evidence trails that can be used in dispute resolution.

---

## 🧠 The Core Idea

Most P2P rental platforms ask one question:

> *"Is this item available?"*

RentWise asks a better question:

> *"Should this rental happen at all — and if so, under what safeguards?"*

---

## 🔍 How the Risk Engine Works

When a rental request is made, the system evaluates a combination of factors:

### User Signals
| Factor | Weight |
|---|---|
| Account age | Medium |
| Identity verification status | High |
| Number of completed rentals | High |
| Late return history | High |
| Cancellation history | Medium |
| Dispute history | High |
| Review scores (given & received) | Medium |

### Transaction Signals
| Factor | Weight |
|---|---|
| Item value | High |
| Rental duration | Medium |
| Deposit offered | Medium |
| Distance between users | Low |
| Item category (risk tier) | Medium |

### Risk Output
```
Risk Score: 8%   → ✅ Low Risk
Risk Score: 45%  → ⚠️ Medium Risk
Risk Score: 72%  → 🔴 High Risk — Additional verification required
```

Each transaction produces:
- A **risk percentage**
- A **recommended deposit amount** (dynamic, not flat)
- A **maximum suggested rental period**
- Required verification steps (if any)

---

## 🏗️ System Architecture

```
┌────────────────────────────────────────────────────────┐
│                    RentWise Platform                  │
├────────────────────────┬───────────────────────────────┤
│   Flutter Mobile App   │     Next.js Web App           │
│   (iOS + Android)      │   (Portal + Admin Panel)      │
├────────────────────────┴───────────────────────────────┤
│                   Supabase Client SDK                  │
│       supabase_flutter  ·  @supabase/supabase-js       │
├────────────────────────────────────────────────────────┤
│                      SUPABASE                          │
│  ┌──────────────┬──────────────┬──────────────────┐   │
│  │  Auth        │  Database    │  Storage         │   │
│  │  (Email OTP, │  (PostgreSQL │  (Item photos,   │   │
│  │  Phone OTP,  │   + RLS)     │   Evidence       │   │
│  │  OAuth)      │              │   media)         │   │
│  ├──────────────┴──────────────┴──────────────────┤   │
│  │  Edge Functions (Deno/TypeScript)               │   │
│  │  - Risk Scoring Engine                         │   │
│  │  - Trust Score Service                         │   │
│  │  - Dynamic Deposit Calculator                  │   │
│  │  - Contract Generator                          │   │
│  │  - Return Monitoring Cron                      │   │
│  ├─────────────────────────────────────────────────┤   │
│  │  Realtime (WebSocket subscriptions)            │   │
│  │  - Notifications, rental status updates        │   │
│  └─────────────────────────────────────────────────┘   │
└────────────────────────────────────────────────────────┘
```

---

## 🛡️ Multi-Layer Protection System

### 1. 🪪 Identity Verification
Before renting high-value items, users must complete:
- Email & phone number verification (handled by **Supabase Auth**)
- CNIC (National ID) upload → stored in **Supabase Storage**, hash in database
- Optional: Selfie / liveness check

### 2. 💰 Dynamic Deposit System
No flat deposits. The deposit scales with the user's risk profile:
```
Camera value = Rs. 100,000
Low-risk renter  → Deposit: Rs. 20,000
High-risk renter → Deposit: Rs. 50,000
```
Calculated by a **Supabase Edge Function** and stored in the database.

### 3. 📄 Digital Rental Contract
Both parties digitally agree to:
- Item condition at handover
- Rental start & end date
- Deposit amount held
- Late-return penalty (per day)
- Damage policy
- Loss/theft procedure

Generated and stored as a JSON record by a **Supabase Edge Function**.

### 4. 📸 Item Condition Evidence
- Owner uploads **before-handover** photos/videos → **Supabase Storage**
- Renter uploads receipt confirmation
- On return, both parties upload **return condition** media
- Optional: Computer vision comparison of before vs. after images

### 5. ⏱️ Return Monitoring & Alerts
The system tracks each rental's lifecycle via a **Supabase scheduled Edge Function (pg_cron)**:
```
Rental Started → Due Date Reminder (24h) → Overdue Alert → Escalation
```

### 6. ⚖️ Dispute Resolution System
When a conflict arises, the platform surfaces:
- Full transaction timeline with timestamps (from database audit log)
- Uploaded evidence (before/after from Supabase Storage)
- Digital contract terms
- In-app communication logs
- Risk score at time of transaction

All protected by **Row Level Security (RLS)** — users only see their own data.

---

## 🔄 Trust Score Lifecycle

A user's trust score is a **living value** that evolves with behavior, updated by Supabase Edge Functions triggered on each event:

```
New User Registered
        ↓
 Identity Verified          +10 pts
        ↓
 First Rental Completed     +15 pts
        ↓
 Returned On Time           +10 pts
        ↓
 5 Rentals, No Issues       → Unlocks high-value item rentals
```

Negative events reduce the score:
```
Late Return                 -10 pts
Damage Claim Filed          -20 pts
Dispute Opened              -15 pts
Dispute Lost                -25 pts
Repeated Violations         → Account Restrictions
```

---

## 🎯 Who Is This For?

| User Type | Use Case |
|---|---|
| **Renters** | Borrow items at lower cost with transparent terms |
| **Owners** | Lend assets with financial and evidence-based protection |
| **Platform** | Facilitate safe, scalable P2P transactions |

---

## ⚙️ Tech Stack

| Layer | Technology |
|---|---|
| **Mobile App** | Flutter (Dart) — iOS & Android |
| **Web App** | Next.js 14 (TypeScript, App Router) |
| **Database** | Supabase (PostgreSQL) with Row Level Security |
| **Auth** | Supabase Auth (Email OTP, Phone OTP, OAuth) |
| **Backend Logic** | Supabase Edge Functions (Deno / TypeScript) |
| **File Storage** | Supabase Storage (item photos, CNIC, evidence) |
| **Realtime** | Supabase Realtime (WebSocket subscriptions) |
| **Scheduled Jobs** | Supabase `pg_cron` + Edge Functions |
| **Push Notifications** | Firebase Cloud Messaging (FCM) — mobile |
| **Email** | Supabase built-in SMTP + custom templates |
| **Optional CV** | Python FastAPI microservice (OpenCV / TensorFlow) |

### Flutter Key Packages
| Package | Purpose |
|---|---|
| `supabase_flutter` | Supabase client (auth, DB, storage, realtime) |
| `go_router` | Navigation & deep linking |
| `flutter_riverpod` | State management |
| `firebase_messaging` | FCM push notifications |
| `image_picker` | Camera & gallery access |
| `cached_network_image` | Image caching from Supabase Storage |

### Next.js Key Packages
| Package | Purpose |
|---|---|
| `@supabase/supabase-js` | Supabase client |
| `@supabase/ssr` | Server-side Supabase client for Next.js |
| `next-auth` or Supabase Auth UI | Session management |
| `react-hook-form` + `zod` | Forms + validation |
| `recharts` | Admin dashboard charts |

---

## 📊 Is This a Good FYP Project?

**Yes — and here's exactly why:**

| Criteria | Assessment |
|---|---|
| **Technical depth** | ✅ Risk modeling, RLS security, Edge Functions, Realtime |
| **Real-world relevance** | ✅ Solves an actual problem in the Pakistani market |
| **Multi-disciplinary** | ✅ Mobile + Web + Supabase backend + AI/ML components |
| **Originality** | ✅ Not just another rental app — a risk & trust *engine* |
| **Scope** | ✅ Large enough to be serious, achievable with Supabase |
| **Demonstration value** | ✅ Highly demonstrable — live data, realtime updates |
| **Scalability path** | ✅ Supabase scales to production without infrastructure changes |

> 💡 Using Supabase eliminates the need to build and maintain a separate backend server, letting you focus your FYP effort on the intelligent parts: the risk engine, trust scoring, and protection system — all living as typed TypeScript Edge Functions.

---

## ⚠️ Important Limitations (Be Honest in Your FYP)

- The platform **cannot recover stolen physical items**. It reduces risk and provides evidence — not guarantees.
- The platform **does not automatically charge bank accounts or declare users criminals** — those involve payment provider agreements and legal frameworks beyond the project's scope.
- Computer vision for damage detection is **optional and aspirational** — treat it as a bonus feature if time permits.
- Supabase Edge Functions run on **Deno** (not Node.js) — TypeScript is fully supported but some Node.js-only packages may not work; use Deno-compatible alternatives.

---

## 📁 Repository Structure

```
RentWise/
├── mobile/                  ← Flutter app
│   ├── lib/
│   │   ├── core/            ← Theme, constants, Supabase client
│   │   └── features/        ← auth, items, rentals, risk, disputes
│   └── pubspec.yaml
├── web/                     ← Next.js web app + admin panel
│   ├── app/
│   │   ├── (auth)/          ← Login, register, verify
│   │   ├── (main)/          ← Dashboard, items, rentals, disputes
│   │   └── admin/           ← Admin panel routes
│   ├── components/
│   ├── lib/
│   │   └── supabase/        ← Supabase client (browser + server)
│   └── types/
├── supabase/                ← Supabase project config
│   ├── functions/           ← Edge Functions (Deno/TypeScript)
│   │   ├── risk-score/      ← Transaction risk scoring
│   │   ├── trust-event/     ← Trust score update handler
│   │   ├── deposit-calc/    ← Dynamic deposit calculator
│   │   ├── contract-gen/    ← Contract generation
│   │   └── return-monitor/  ← Scheduled return monitoring
│   ├── migrations/          ← SQL migration files
│   └── seed.sql             ← Demo seed data
└── docs/                    ← Architecture, FYP report assets
```

---

## 👥 Team

> Noor Fatima
> Areeba Arif
> Imtishal Abid

---

## 📄 License

This project is developed as a Final Year Project (FYP). All rights reserved.
