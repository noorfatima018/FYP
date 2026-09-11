# 🛡️ TrustRent — Trust & Risk Management Platform for Peer-to-Peer Asset Sharing

> **"Don't just match renters and owners — protect both of them."**

---

## 📌 What is TrustRent?

TrustRent is a **peer-to-peer rental platform with a built-in trust and risk engine**. It allows individuals to lend and borrow physical assets (cameras, laptops, appliances, vehicles, etc.) while intelligently assessing the risk of every transaction *before* it happens.

Unlike typical rental apps that simply connect buyers and sellers, TrustRent acts as a **digital trust layer** — evaluating users, calculating dynamic risk scores, generating digital contracts, and maintaining evidence trails that can be used in dispute resolution.

---

## 🧠 The Core Idea

Most P2P rental platforms ask one question:

> *"Is this item available?"*

TrustRent asks a better question:

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
┌──────────────────────────────────────────────┐
│                 TrustRent Platform           │
├──────────────┬───────────────┬───────────────┤
│  Mobile App  │   Web Portal  │  Admin Panel  │
│  (React Native or Flutter)   │  (React.js)   │
├──────────────┴───────────────┴───────────────┤
│              REST / GraphQL API              │
│               (Node.js / Django)             │
├──────────────────────────────────────────────┤
│         Risk & Trust Engine (Python)         │
│    - Scoring Model                           │
│    - Dynamic Deposit Calculator              │
│    - Behavioral Pattern Detection            │
├──────────────────────────────────────────────┤
│         Database Layer (PostgreSQL)          │
│    - Users, Items, Transactions              │
│    - Evidence (images/video metadata)        │
│    - Contracts, Disputes, Audit Logs         │
├──────────────────────────────────────────────┤
│       Storage (Firebase / S3 / Cloudinary)   │
│    - Item photos, condition evidence         │
└──────────────────────────────────────────────┘
```

---

## 🛡️ Multi-Layer Protection System

### 1. 🪪 Identity Verification
Before renting high-value items, users must complete:
- Email & phone number verification
- CNIC (National ID) upload and validation
- Optional: Selfie / liveness check

### 2. 💰 Dynamic Deposit System
No flat deposits. The deposit scales with the user's risk profile:
```
Camera value = Rs. 100,000
Low-risk renter  → Deposit: Rs. 20,000
High-risk renter → Deposit: Rs. 50,000
```

### 3. 📄 Digital Rental Contract
Both parties digitally agree to:
- Item condition at handover
- Rental start & end date
- Deposit amount held
- Late-return penalty (per day)
- Damage policy
- Loss/theft procedure

### 4. 📸 Item Condition Evidence
- Owner uploads **before-handover** photos/videos
- Renter uploads **receipt confirmation**
- On return, both parties upload **return condition** media
- Optional: Computer vision comparison of before vs. after images

### 5. ⏱️ Return Monitoring & Alerts
The system tracks each rental's lifecycle:
```
Rental Started → Due Date Reminder (24h) → Overdue Alert → Escalation
```
Automatic push notifications and email alerts are sent at each stage.

### 6. ⚖️ Dispute Resolution System
When a conflict arises, the platform surfaces:
- Full transaction timeline with timestamps
- Uploaded evidence (before/after photos)
- Digital contract terms agreed upon
- In-app communication logs
- Risk score at time of transaction

---

## 🔄 Trust Score Lifecycle

A user's trust score is a **living value** that evolves with behavior:

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
| Mobile App | React Native / Flutter |
| Web Frontend | React.js |
| Backend API | Node.js (Express) or Django (Python) |
| Risk Engine | Python (scikit-learn / rule-based scoring) |
| Database | PostgreSQL |
| Media Storage | Firebase Storage / Cloudinary |
| Notifications | Firebase Cloud Messaging (FCM) |
| Auth | JWT + OAuth2 |
| Optional CV | Python + OpenCV / TensorFlow Lite |

---

## 📊 Is This a Good FYP Project?

**Yes — and here's exactly why:**

| Criteria | Assessment |
|---|---|
| **Technical depth** | ✅ Risk modeling, dynamic scoring, CV integration, real-time monitoring |
| **Real-world relevance** | ✅ Solves an actual problem in the Pakistani market |
| **Multi-disciplinary** | ✅ Mobile + Web + Backend + Database + AI/ML components |
| **Originality** | ✅ Not just another rental app — a risk & trust *engine* |
| **Scope** | ✅ Large enough to be serious, scoped enough to be achievable |
| **Demonstration value** | ✅ Highly demonstrable to evaluators and investors |
| **Scalability path** | ✅ Can expand to insurance integrations, payment gateways, etc. |

> 💡 The key differentiator: You're not building a marketplace. You're building a **risk and trust infrastructure layer** that a marketplace sits on top of. That framing alone elevates this from a semester project to a fundable product concept.

---

## ⚠️ Important Limitations (Be Honest in Your FYP)

- The platform **cannot recover stolen physical items**. It reduces risk and provides evidence — not guarantees.
- The platform **does not automatically charge bank accounts or declare users criminals** — those involve payment provider agreements and legal frameworks beyond the project's scope.
- Computer vision for damage detection is **optional and aspirational** — treat it as a bonus feature if time permits.

---

## 📁 Repository Structure

```
trustrent/
├── mobile/          # React Native / Flutter app
├── web/             # React.js web portal
├── backend/         # API server (Node.js or Django)
│   ├── risk/        # Risk engine & scoring models
│   ├── contracts/   # Digital contract generation
│   ├── disputes/    # Dispute resolution logic
│   └── evidence/    # Media upload & management
├── database/        # Schema, migrations, seed data
├── docs/            # FYP documentation
└── README.md
```

---

## 👥 Team

> Add your team members here.

---

## 📄 License

This project is developed as a Final Year Project (FYP). All rights reserved.
