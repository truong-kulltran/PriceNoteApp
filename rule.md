# Personal Expense Tracking Application  
## Business, UI/UX, and Technical Implementation Specification

---

## 1. Purpose of This Document

This document defines **all required rules, principles, and constraints** for building a **Personal Expense Tracking Application**.

It is intended to be a **single source of truth** for:
- Product Owners
- UI/UX Designers
- Flutter Developers
- Backend Engineers
- AI-assisted code generation

The goal is to ensure the application is:
- Financially accurate
- Easy to use
- Cleanly architected
- Maintainable
- Scalable for future growth

---

## 2. Core Business Objectives

1. Allow users to record **daily income and expenses**.
2. Support **automatic transaction detection** from screenshots or invoices.
3. Provide **daily, weekly, monthly, and yearly financial summaries**.
4. Maintain **real-time wallet balances**.
5. Enable users to **divide funds into multiple wallets**.
6. Support both **structured categories** and **free-text notes** for expenses.
7. Deliver **clear, actionable financial insights** with minimal user effort.

---

## 3. Business Domain Definitions

### 3.1 User
- Owns wallets
- Creates and manages transactions
- Views analytics and summaries

---

### 3.2 Wallet
A wallet represents a distinct pool of money.

**Attributes**
- Wallet ID
- Name
- Currency
- Initial Balance
- Current Balance (system-calculated)
- Status (Active / Archived)

**Business Rules**
- A transaction belongs to exactly one wallet.
- Wallet balance is calculated server-side.
- Wallets can be archived but not deleted.

---

### 3.3 Transaction
A transaction represents one income or expense event.

**Attributes**
- Transaction ID
- Wallet ID
- Type (`Income` or `Expense`)
- Amount (positive number)
- Date & Time
- Category (optional)
- Note (optional)
- Source (`Manual`, `Screenshot`, `Invoice`)
- AI Confidence Score (if auto-detected)

**Business Rules**
- Amount must always be greater than 0.
- Expense reduces wallet balance.
- Income increases wallet balance.
- Editing or deleting a transaction must re-calculate balances.

---

### 3.4 Category
Predefined classification for transactions.

**Examples**
- Food
- Transport
- Utilities
- Entertainment
- Salary
- Investment

Categories must be configurable and never hard-coded.

---

## 4. Transaction Recording Logic

### 4.1 Manual Entry
- User selects wallet, type, amount, and date.
- Category and note are optional.
- Transaction is saved only after validation.
- Wallet balance updates immediately after save.

---

### 4.2 Automatic Transaction Detection (OCR & AI)

**Supported Inputs**
- Screenshots
- Invoice / receipt images

**Processing Flow**
1. User uploads an image.
2. OCR extracts amount, date, and merchant info.
3. AI predicts transaction type and category.
4. A confidence score is generated.
5. User must confirm or edit detected data before saving.

**Rule**
- No auto-detected transaction is finalized without user confirmation.

---

## 5. Wallet Balance Calculation

Wallet Balance = Initial Balance
+ Total Income
- Total Expenses

**Rules**
- Balance is calculated and enforced server-side.
- Client displays balance only.
- Negative balance is not allowed unless explicitly enabled.

---

## 6. Daily Expense Analysis

For each calendar day:
- Total Income
- Total Expense
- Net Balance (Income - Expense)

**Insights**
- Highest spending category
- Most used wallet
- Comparison with previous day

---

## 7. Period-Based Expense Summary

### Supported Periods
- Day
- Week (ISO standard)
- Month
- Year

**Metrics**
- Total Income
- Total Expense
- Net Savings
- Category breakdown
- Wallet breakdown

---

## 8. UI/UX Design Rules (Dark Theme)

### 8.1 Design Philosophy
- Dark-first, minimal, and clean
- Financial clarity over decoration
- Reduce cognitive load

---

### 8.2 Color System
- Background: Near-black dark gray
- Surface/Card: Slightly lighter dark gray
- Income: Green / Teal
- Expense: Red
- Accent: Soft blue
- High contrast for numbers and balances

---

### 8.3 Typography
- Clean sans-serif font (Inter / SF Pro / Roboto)
- Monetary values visually dominant
- Clear hierarchy for labels and values

---

### 8.4 Navigation
- Bottom navigation with 3–4 tabs:
  - Home
  - Transactions
  - Analytics
  - Wallets

---

### 8.5 Home Screen Priority
1. Total Balance
2. Today’s Expense
3. Wallet switcher
4. Recent transactions

No more than one chart on the Home screen.

---

### 8.6 Transaction UI
- Clear distinction between income and expense
- Amount sign (+ / -) always visible
- Simple cards with category icon, note, amount, and wallet tag

---

### 8.7 Add Transaction Flow
- Bottom sheet or full-screen modal
- Maximum two-step flow
- OCR preview with editable detected fields

---

### 8.8 Analytics UI
- Minimal charts
- Clear period selector (Day / Week / Month / Year)
- Category and wallet breakdowns

---

### 8.9 Accessibility
- WCAG AA contrast
- Support text scaling
- Do not rely on color alone for meaning

---

## 9. Technical Architecture Rules

### 9.1 Technology Stack
- Frontend: Flutter
- Backend: Dart Serverpod
- Authentication & OCR: Firebase
- State Management: Riverpod
- Navigation: GoRouter

---

### 9.2 Clean Architecture (Mandatory)

presentation/
domain/
data/

**Rules**
- Domain layer must be pure Dart.
- No framework imports in domain layer.
- UI must not contain business logic.

---

### 9.3 Feature-Based Structure

features/
├── transactions/
├── wallets/
├── analytics/
└── auth/

Each feature must be independent and scalable.

---

## 10. State Management Rules

- UI listens to state only.
- Business logic lives in controllers/use cases.
- Repositories are never called directly from widgets.

---

## 11. Data Flow

UI
→ Controller (Riverpod)
→ Use Case
→ Repository
→ Data Source (Serverpod / Firebase)


---

## 12. Backend Rules (Serverpod)

- Enforce all business rules
- Validate inputs
- Maintain wallet balance consistency
- Perform aggregation (daily, monthly, yearly)
- Provide versioned APIs

---

## 13. Firebase Responsibilities

- User authentication
- OCR and ML-based transaction detection
- Push notifications
- Analytics events
- Crash reporting

Firebase must not contain core financial business logic.

---

## 14. Error Handling Rules

- Use typed domain failures
- No raw exceptions in UI
- UI handles only presentation of error states

---

## 15. Code Quality Rules

- One widget = one responsibility
- Widgets < 200 lines
- No logic inside `build()`
- Prefer immutable state
- Use `const` whenever possible

---

## 16. Scalability & Future-Proofing

The system must be designed to support:
- Multi-currency
- Budgeting per category
- Recurring transactions
- Financial forecasting
- Export for tax/accounting

---

## 17. AI Code Generation Rule (Mandatory Prompt)

> Generate Flutter code following Clean Architecture, Riverpod state management, and Serverpod backend integration.  
> The UI must follow dark-first minimal design principles.  
> Business logic must never be placed inside widgets.  
> The code must be scalable, maintainable, and production-ready.

---

## 18. Definition of Done

- All business rules enforced server-side
- UI matches dark-first design rules
- No business logic in presentation layer
- Unit tests for domain logic
- Codebase ready for feature expansion

---

End of specification.
