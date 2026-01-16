1. Core Business Objectives

Enable users to accurately track income and expenses at transaction level.

Provide automatic transaction recognition from screenshots or invoices.

Deliver actionable financial insights through daily and period-based analytics.

Maintain real-time balance visibility across multiple wallets.

Support structured and unstructured expense classification (categories + notes).

2. Key Business Entities & Definitions
2.1 User

Owns wallets

Creates transactions

Views analytics and summaries

2.2 Wallet

Represents a pool of money (e.g., Cash, Bank Account, Credit Card).

Attributes

Wallet ID

Wallet Name

Currency

Initial Balance

Current Balance

Status (Active / Archived)

2.3 Transaction

Represents a single income or expense event.

Attributes

Transaction ID

Wallet ID

Transaction Type (Income | Expense)

Amount (positive value)

Transaction Date & Time

Category (optional, predefined)

Note (optional, free text)

Source (Manual | Screenshot | Invoice)

Confidence Score (for auto-detected transactions)

Created At / Updated At

2.4 Category

Predefined expense or income classification.

Examples

Food

Transport

Utilities

Entertainment

Salary

Investment

3. Business Logic by Functional Area
4. Transaction Recording Logic
4.1 Manual Entry

Rules

User must select:

Wallet

Transaction Type

Amount

Date

Category and note are optional but recommended.

Amount must be > 0.

System Actions

Save transaction

Update wallet balance:

Income → Balance + Amount

Expense → Balance - Amount

4.2 Automatic Transaction Identification (OCR & AI)

Input Sources

Screenshot

Invoice / Receipt Image

Processing Logic

Image uploaded by user

OCR extracts:

Merchant name

Date

Total amount

Currency

AI classification:

Determines transaction type (income/expense)

Suggests category

Confidence scoring:

If confidence ≥ threshold → auto-fill fields

If confidence < threshold → require user confirmation

Business Rule

No transaction is finalized until user confirms detected data.

5. Wallet Balance Calculation Logic
5.1 Real-Time Balance
Wallet Balance = Initial Balance
               + Σ(Income Transactions)
               - Σ(Expense Transactions)


Rules

Balance updates immediately after transaction creation, edit, or deletion.

Transactions are wallet-specific.

Cross-wallet transfers are treated as:

Expense in source wallet

Income in destination wallet

6. Daily Expense Analysis Logic
6.1 Daily Aggregation

For each day:

Daily Total Expense = Σ(Expenses on that day)
Daily Total Income  = Σ(Income on that day)
Daily Net Balance   = Income - Expense


Insights Generated

Highest spending category of the day

Wallet with highest usage

Comparison with previous day

7. Expense Summary by Time Period
7.1 Supported Periods

Day

Week (ISO week)

Month

Year

7.2 Aggregation Logic

For selected period:

Total Expense = Σ(Expenses within period)
Total Income  = Σ(Income within period)
Net Savings   = Income - Expense


Breakdowns

By category

By wallet

By transaction source (manual vs auto-detected)

8. Fund Division into Wallets
8.1 Wallet Allocation Rules

Each transaction belongs to exactly one wallet.

Users may define:

Spending wallets (Cash, Checking)

Saving wallets (Savings, Emergency Fund)

Optional Advanced Rule

Spending limits per wallet (soft warning when exceeded).

9. Expense Details & Categorization Logic
9.1 Category Assignment

User may:

Select a predefined category

Leave uncategorized

AI may suggest category during auto-detection.

9.2 Notes

Free-text notes allowed per transaction.

Used for:

Search

Future AI-based insights

10. Data Validation & Consistency Rules

Transaction date cannot be in the future (configurable).

Wallet balance cannot go negative unless explicitly allowed.

Deleting a transaction must rollback wallet balance.

Editing amount/type must re-calculate affected balances.

11. Analytics KPIs (Business Perspective)

Daily Average Spending

Monthly Savings Rate

Category Spend Ratio

Wallet Utilization %

Auto-detected Transaction Accuracy

12. Future Scalability Considerations

Multi-currency support

Budget planning per category

Recurring transactions

Predictive expense forecasting

Export for tax or accounting use