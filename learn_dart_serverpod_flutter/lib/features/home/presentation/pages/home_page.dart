import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../wallet/providers/wallet_provider.dart';
import '../../../transaction/providers/transaction_provider.dart';
import '../../../analytics/providers/analytics_provider.dart';

/// Home page - Dashboard with key financial metrics
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = Responsive.padding(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Show notifications
            },
          ),
        ],
      ),
      body: CenteredContent(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total Balance Card
                _buildTotalBalanceCard(context, ref),
                SizedBox(height: padding),

                // Today's Summary
                _buildTodaySummary(context, ref),
                SizedBox(height: padding),

                // Quick Actions
                _buildQuickActions(context),
                SizedBox(height: padding),

                // Recent Transactions
                _buildRecentTransactions(context, ref),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-transaction'),
        icon: const Icon(Icons.add),
        label: const Text('Add Transaction'),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }

  Widget _buildTotalBalanceCard(BuildContext context, WidgetRef ref) {
    final totalBalance = ref.watch(totalBalanceProvider);
    final walletsAsync = ref.watch(walletsProvider);

    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: walletsAsync.when(
          data: (wallets) {
            final income = wallets.fold<double>(
              0,
              (sum, wallet) => sum + (wallet.initialBalance > 0 ? wallet.initialBalance : 0),
            );
            final expense = wallets.fold<double>(
              0,
              (sum, wallet) =>
                  sum +
                  (wallet.currentBalance < wallet.initialBalance ? wallet.initialBalance - wallet.currentBalance : 0),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  CurrencyFormatter.format(totalBalance),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.accentColor,
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildBalanceIndicator(
                      context,
                      'Income',
                      income,
                      AppTheme.incomeColor,
                      Icons.arrow_upward,
                    ),
                    const SizedBox(width: 24),
                    _buildBalanceIndicator(
                      context,
                      'Expense',
                      expense,
                      AppTheme.expenseColor,
                      Icons.arrow_downward,
                    ),
                  ],
                ),
              ],
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text('Error: $error', style: TextStyle(color: AppTheme.errorColor)),
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceIndicator(
    BuildContext context,
    String label,
    double amount,
    Color color,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              CurrencyFormatter.format(amount),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodaySummary(BuildContext context, WidgetRef ref) {
    final columns = Responsive.gridColumns(context);
    final padding = Responsive.padding(context);
    final todaySummary = ref.watch(todaySummaryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Summary',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: padding * 0.75),
        todaySummary.when(
          data: (summary) {
            final totalExpense = summary['totalExpense'] as double? ?? 0.0;
            final totalIncome = summary['totalIncome'] as double? ?? 0.0;
            final transactionCount = summary['transactionCount'] as int? ?? 0;

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: Responsive.isMobile(context) ? 1.5 : 2.0,
              children: [
                _buildSummaryCard(
                  context,
                  'Expenses',
                  totalExpense.toString(),
                  AppTheme.expenseColor,
                  Icons.trending_down,
                ),
                _buildSummaryCard(
                  context,
                  'Income',
                  totalIncome.toString(),
                  AppTheme.incomeColor,
                  Icons.trending_up,
                ),
                _buildSummaryCard(
                  context,
                  'Transactions',
                  transactionCount.toString(),
                  AppTheme.accentColor,
                  Icons.receipt,
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Text('Error: $error', style: TextStyle(color: AppTheme.errorColor)),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title == 'Expenses' ? '\$${value}' : value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final padding = Responsive.padding(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: padding * 0.75),
        ResponsiveBuilder(
          mobile: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildQuickActionButtons(context),
          ),
          tablet: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildQuickActionButtons(context),
          ),
          desktop: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var i = 0; i < _buildQuickActionButtons(context).length; i++) ...[
                _buildQuickActionButtons(context)[i],
                if (i < _buildQuickActionButtons(context).length - 1) SizedBox(width: padding * 2),
              ],
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildQuickActionButtons(BuildContext context) {
    return [
      _buildQuickActionButton(
        context,
        'Add Income',
        Icons.add_circle_outline,
        AppTheme.incomeColor,
        () => context.push('/add-transaction'),
      ),
      _buildQuickActionButton(
        context,
        'Add Expense',
        Icons.remove_circle_outline,
        AppTheme.expenseColor,
        () => context.push('/add-transaction'),
      ),
      _buildQuickActionButton(
        context,
        'Scan Receipt',
        Icons.camera_alt_outlined,
        AppTheme.accentColor,
        () {
          // TODO: Implement OCR
        },
      ),
    ];
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentTransactions(BuildContext context, WidgetRef ref) {
    final recentTransactions = ref.watch(recentTransactionsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () => context.go('/transactions'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        recentTransactions.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 48,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No transactions yet',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Column(
              children: transactions.map(
                (transaction) {
                  final amount = transaction.type == 'income' ? transaction.amount : -transaction.amount;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            amount > 0 ? AppTheme.incomeColor.withOpacity(0.1) : AppTheme.expenseColor.withOpacity(0.1),
                        child: Icon(
                          amount > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                          color: amount > 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
                        ),
                      ),
                      title: Text(transaction.note ?? '-'),
                      subtitle: Text(
                        DateFormatter.formatRelative(transaction.transactionDate),
                      ),
                      trailing: Text(
                        CurrencyFormatter.formatWithSign(amount),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: amount > 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Text('Error: $error', style: TextStyle(color: AppTheme.errorColor)),
          ),
        ),
      ],
    );
  }
}
