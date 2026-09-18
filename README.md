# 🛡️ RentWise — AI Based Risk-Aware Peer-to-Peer Rental Management Platform

<p align="center">
  <img src="logo.png" alt="RentWise Logo" width="220" />
</p>

> **Department of Computer Science — Faculty of Computing & IT — University of Gujrat**  
> *Final Year Project Proposal & Development Documentation*

---

## 📌 Project Overview

**RentWise** is an AI-enhanced peer-to-peer (P2P) rental management platform designed to build trust and eliminate risk in high-value asset sharing. Peer-to-peer rental platforms allow individuals to access expensive assets without purchasing them, but transactions between strangers create significant concerns regarding identity verification, asset condition, late returns, disputes, and financial risk.

RentWise solves these challenges by combining a **structured rental lifecycle** with **verification status, reputation, pre- and post-rental evidence management, ML-based transaction risk prediction, explainable risk factors, natural-language asset recommendations, and an AI Rental Assistant**.

### Target Assets
The platform focuses primarily on high-value personal and professional assets, including:
- 📸 **Cameras & Photography Gear** (DSLRs, lenses, gimbals, lighting)
- 💻 **Laptops & Computers** (High-end laptops, workstations)
- 📹 **Projectors & Display Systems**
- 🎮 **Gaming Equipment** (Consoles, VR headsets)
- 🛠️ **Professional & Specialised Tools**

---

## 👥 Project Team & Supervision

| Role | Name | Roll Number | Primary Responsibilities |
|---|---|---|---|
| **Supervisor** | **Mr. Zafar Mehmood** | — | Project supervision & guidance (`zafar.mehmood@uog.edu.pk`) |
| **Core Developer, Mobile & AI Engineer** | **Areeba Arif** | `23021519-068` | Flutter architecture & mobile app, core rental workflows, ML risk prediction & explainability, recommendations, AI assistant, AI evaluation, technical integration. |
| **UI/UX Designer & Frontend Developer** | **Noor Fatima** | `23021519-007` | UI/UX research, Figma designs, mobile UI, Next.js web app, Owner Dashboard, responsive design, frontend integration, usability testing, AI feature interfaces. |
| **Backend, Admin & Quality Engineer** | **Imtishal Abid** | `23021519-176` | Supabase schema, authentication/authorization, storage/security/RLS, Admin Dashboard, backend transaction services, evidence & dispute handling, integration & system testing, deployment & documentation support. |

---

## 🎯 Target Audience

- 🎒 **Renters**: Students, freelancers, content creators, event organizers, professionals, and individuals needing high-value equipment temporarily without purchasing.
- 🏢 **Asset Owners**: Individuals, freelancers, professionals, and small rental businesses with underutilized cameras, laptops, projectors, gaming gear, or tools looking to monetize assets safely.
- 🛡️ **Administrators**: Platform operators responsible for user verification reviews, listing moderation, transaction monitoring, risk-flag handling, and dispute resolution.

---

## 🏗️ System Architecture & Stack

```
┌────────────────────────────────────────────────────────────────────────┐
│                          RENTWISE PLATFORM                             │
├───────────────────────────────────┬────────────────────────────────────┤
│   Flutter Mobile Application      │     Next.js Web Application        │
│   (iOS + Android)                 │   (Owner Dashboard + Admin Panel)  │
│   - Renter Workflow               │   - Listing & Availability         │
│   - Owner Mobile Workflow         │   - Admin Risk & Dispute Control   │
│   - AI Rental Assistant           │   - Verification Queue             │
├───────────────────────────────────┴────────────────────────────────────┤
│                         API & INTEGRATION LAYER                        │
├───────────────────────────────────┬────────────────────────────────────┤
│       Supabase Backend Service    │        Python AI / ML Microservice │
│  - PostgreSQL + Row-Level Security│   - Risk Prediction (Scikit/XGBoost)│
│  - Auth (Email/Phone OTP, Roles)  │   - Explainable AI Risk Factors    │
│  - Storage (CNIC, Photos, Media)  │   - Recommendation Engine          │
│  - Realtime & Triggers            │   - LLM / NLP Rental Assistant     │
└───────────────────────────────────┴────────────────────────────────────┘
```

### Technology Reasoning

| Technology | Role | Rationale |
|---|---|---|
| **Flutter / Dart** | Mobile App (iOS & Android) | Single codebase delivering smooth cross-platform experience for renters and mobile owners. |
| **Next.js 14 / React** | Web App (Owner & Admin) | Responsive web dashboard for owners managing inventories and administrators monitoring transactions/disputes. |
| **Supabase** | Backend Suite | Managed PostgreSQL, built-in Auth (Email/Phone OTP), Storage (CNIC/Evidence media), and Row Level Security (RLS) with minimal overhead. |
| **Python** | AI Microservice | Primary language for training, serving, and evaluating ML classification models and NLP pipelines. |
| **Scikit-Learn / XGBoost** | ML Risk Engine | Established classification algorithms for transaction risk prediction and feature importance output. |
| **Explainability (SHAP / LIME)** | XAI Risk Assessment | Translates raw model outputs into human-understandable risk contributing factors for owners and admins. |
| **LLM / NLP Services** | Assistant & Recommendations | Natural language processing for user intent matching, conversational rental assistance, and query parsing. |
| **Git / GitHub** | Version Control | Source code management, feature branching, and pull request reviews. |
| **Figma** | Prototyping | UI/UX research, wireframing, high-fidelity screen designs, and design system alignment. |

---

## 🧠 System & AI Modules

### Core System Modules
1. **User Authentication & Profiles**: Registration, login (email/phone OTP), user roles (renter, owner, admin), profiles, verification badges, rental history, and reputation.
2. **Asset Listing & Management**: Owner listing tools, multi-image upload, technical specifications, rental pricing, deposit rates, availability calendar, and asset condition baseline.
3. **Asset Search & Discovery**: Renter search filters by category, price range, dates, specifications, owner reputation, and item condition.
4. **Rental Request & Booking**: Interactive rental requests, owner approval/rejection, availability validation, date selection, and transaction status tracking.
5. **Rental Agreement & Transaction**: Structured digital rental contracts detailing duration, pricing, deposit terms, handover/return guidelines, and digital signatures.
6. **Verification & Trust**: User identity status, account tenure, completed rental history, ratings, late return logs, and dispute records.
7. **Evidence & Condition Management**: Mandatory pre-rental and post-rental condition media (photos/videos), descriptions, and timestamped evidence records.
8. **Transaction Risk Assessment**: Multi-signal transaction risk evaluator combining asset value, duration, verification, ratings, and past behavior.

### AI Modules
- 🔴 **Core AI 1: ML Transaction Risk Prediction**: Uses machine learning models (Random Forest or XGBoost) to predict risk score for each rental request based on user, asset, and transaction features.
- 🔍 **Core AI 2: Explainable AI (XAI) Risk Assessment**: Generates clear, human-understandable contributing factors behind predicted risk scores to help owners and admins make informed decisions.
- 💡 **Secondary AI 1: Personalized Asset Recommendation**: Matches natural-language renter requirements and preferences with relevant asset specifications, price, and availability.
- 💬 **Secondary AI 2: AI Rental Assistant**: Provides a conversational natural-language interface for searching assets, checking availability, explaining risk factors, guiding contract steps, and answering rental policies.
- 📊 **Optional AI 1: NLP Review & Dispute Analysis**: Analyzes review comments and dispute text for sentiment, complaint categories, and urgent escalation flags.
- 👁️ **Optional AI 2: Computer Vision Damage Detection**: Compares pre- and post-rental asset photos to detect potential physical damage or surface changes.

---

## 🚀 Application Features Breakdown

### 📱 Flutter Mobile Application (Renters & Owners)
- **Renter Features**: User registration & profile, verification hub (CNIC, phone, email), asset search & discovery, asset details, AI recommendation feed, AI Rental Assistant, rental booking requests, contract signing, pre/post evidence upload, rating & reviews, dispute filing.
- **Owner Features**: Profile management, asset listing creation & edit, availability calendar control, incoming request review with renter risk profiles, digital contract signing, handover/return confirmation with pre-rental photo upload, rental history, rating management.

### 🌐 Next.js Web Application (Owners & Administrators)
- **Owner Dashboard**: Asset inventory management, rental request approval, renter verification status & risk card inspection, active rental tracking, condition evidence review, return verification, income/rental history.
- **Admin Dashboard**: System metric overview, user profile & verification management (CNIC verification queue), asset listing moderation, platform transaction monitoring, high-risk flag alerts, evidence comparison viewer, dispute resolution panel with admin override controls.

---

## 📊 Competitive Analysis

| Feature | RentWise | Typical Rental / Classified Platforms |
|---|:---:|:---:|
| Rental Listings | ✅ | ✅ |
| High-Value Asset Focus | ✅ | Partial |
| Identity Verification Status | ✅ | Limited / Varies |
| **ML Transaction Risk Prediction** | ✅ | Generally not core |
| **Explainable Risk Factors** | ✅ | Generally not core |
| **AI Asset Recommendations** | ✅ | Limited / Varies |
| **AI Rental Assistant** | ✅ | Generally not core |
| Pre- & Post-Rental Condition Evidence | ✅ | Limited / Varies |
| Digital Rental Agreements | ✅ | Varies |
| Structured Return Workflow | ✅ | Varies |
| Evidence-Based Dispute Management | ✅ | Varies |
| Admin Risk & Transaction Monitoring | ✅ | Varies |

---

## 🎯 Feature Prioritization

### 🟢 Core / Must Implement
- Cross-platform Flutter mobile application (Renters & Owners)
- Responsive Next.js web application (Owner & Admin dashboards)
- Supabase backend, database, authentication, storage & RLS security
- User authentication & verified profiles
- Asset listing & management (cameras, laptops, projectors, tools, gaming gear)
- Asset search, filtering & discovery
- Rental requests & booking workflow
- Digital rental agreements & structured transaction status
- Verification status & trust metrics
- Pre-rental and post-rental condition evidence management
- Returns, ratings & dispute management workflow
- ML-based transaction risk prediction (Python Scikit-Learn / XGBoost)
- Explainable AI risk factor generator

### 🟡 Secondary Priority
- Personalized asset recommendation engine (natural-language matching)
- AI Rental Assistant (conversational interface)

### 🔵 Optional / Stretch Goals
- NLP review and dispute sentiment analysis
- Computer vision damage detection (image diff analysis)
- Advanced semantic asset search

---

## 📁 Repository Structure

```
RentWise/
├── mobile/                  ← Flutter mobile application (Renters & Owners)
│   ├── lib/
│   │   ├── core/            ← Theme, constants, Supabase client, utils
│   │   ├── features/        ← Auth, items, rental_requests, risk, contracts, evidence, disputes, ai_assistant
│   │   └── main.dart
│   └── pubspec.yaml
├── web/                     ← Next.js web application (Owner & Admin Dashboards)
│   ├── app/
│   │   ├── (auth)/          ← Login, register, OTP, verification
│   │   ├── (owner)/         ← Owner dashboard, listing management, incoming requests
│   │   ├── (admin)/         ← Admin panel, user queue, risk monitor, dispute resolution
│   │   └── layout.tsx
│   ├── components/          ← UI component library, risk cards, evidence viewers
│   ├── lib/                 ← Supabase client (browser + server)
│   └── package.json
├── ai_service/              ← Python ML & AI Microservice
│   ├── models/              ← Scikit-Learn / XGBoost risk prediction models
│   ├── explainability/      ← XAI factor generation modules
│   ├── recommendation/      ← Recommendation engine
│   ├── assistant/           ← NLP / LLM AI Rental Assistant interface
│   ├── app.py               ← FastAPI server entrypoint
│   └── requirements.txt
├── supabase/                ← Supabase infrastructure & database
│   ├── migrations/          ← PostgreSQL migration scripts & schema definitions
│   ├── storage/             ← Storage bucket RLS policies (CNIC, items, evidence)
│   └── seed.sql             ← Initial seed data
└── docs/                    ← Architecture diagrams, API specs, FYP documentation
```

---

## 📄 License & Attribution

Developed as a **Final Year Project (FYP)** in the **Department of Computer Science, Faculty of Computing & IT, University of Gujrat**. All rights reserved © 2026.
