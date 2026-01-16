import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';

/// Wallet detail page showing balance and transactions
class WalletDetailPage extends StatelessWidget {
  final int walletId;

  const WalletDetailPage({
    super.key,
    required this.walletId,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real data from provider
    final wallet = {
      'id': walletId,
      'name': 'Cash',
      'balance': 1250.00,
      'initialBalance': 1000.00,
      'currency': 'USD',
      'icon': Icons.money,
      'color': Colors.green,
    };

    final transactions = [
      {
        'title': 'Grocery Shopping',
        'amount': -85.50,
        'date': DateTime.now(),
        'category': 'Food',
      },
      {
        'title': 'Cash Deposit',
        'amount': 500.00,
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'category': 'Income',
      },
      {
        'title': 'Transportation',
        'amount': -25.00,
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'category': 'Transport',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(wallet['name'] as String),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Edit wallet
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'archive',
                child: Text('Archive Wallet'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete Wallet'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: (wallet['color'] as Color).withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Icon(
                    wallet['icon'] as IconData,
                    size: 48,
                    color: wallet['color'] as Color,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Current Balance',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    CurrencyFormatter.format(wallet['balance'] as double),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Initial: ${CurrencyFormatter.format(wallet['initialBalance'] as double)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // Statistics
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This Month',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Income',
                          500.00,
                          AppTheme.incomeColor,
                          Icons.arrow_upward,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Expense',
                          250.00,
                          AppTheme.expenseColor,
                          Icons.arrow_downward,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Spending Trend Chart
                  Text(
                    'Spending Trend',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: _buildSpendingChart(context),
                  ),
                  const SizedBox(height: 24),

                  // Recent Transactions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transactions',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: View all transactions
                        },
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...transactions.map(
                    (transaction) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (transaction['amount'] as double) > 0
                              ? AppTheme.incomeColor.withOpacity(0.1)
                              : AppTheme.expenseColor.withOpacity(0.1),
                          child: Icon(
                            (transaction['amount'] as double) > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                            color: (transaction['amount'] as double) > 0 ? AppTheme.incomeColor : AppTheme.expenseColor,
                          ),
                        ),
                        title: Text(transaction['title'] as String),
                        subtitle: Text(
                          '${transaction['category']} • ${DateFormatter.formatRelative(transaction['date'] as DateTime)}',
                        ),
                        trailing: Text(
                          CurrencyFormatter.formatWithSign(
                            transaction['amount'] as double,
                          ),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: (transaction['amount'] as double) > 0
                                    ? AppTheme.incomeColor
                                    : AppTheme.expenseColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    double amount,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              CurrencyFormatter.format(amount),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingChart(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() < days.length) {
                  return Text(
                    days[value.toInt()],
                    style: Theme.of(context).textTheme.labelSmall,
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 50),
              const FlSpot(1, 80),
              const FlSpot(2, 45),
              const FlSpot(3, 120),
              const FlSpot(4, 90),
              const FlSpot(5, 60),
              const FlSpot(6, 85),
            ],
            isCurved: true,
            color: AppTheme.accentColor,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppTheme.accentColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
