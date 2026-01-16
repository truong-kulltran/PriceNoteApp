import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_bottom_nav.dart';

/// Analytics page showing financial insights and reports
class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  String _selectedPeriod = 'Month';
  final List<String> _periods = ['Day', 'Week', 'Month', 'Year'];

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.padding(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Export report
            },
          ),
        ],
      ),
      body: CenteredContent(
        child: ListView(
          padding: EdgeInsets.all(padding),
          children: [
            // Period Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: _periods.map((period) {
                    final isSelected = period == _selectedPeriod;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedPeriod = period;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? AppTheme.accentColor.withOpacity(0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected ? AppTheme.accentColor : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              period,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: isSelected ? AppTheme.accentColor : null,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: padding * 1.5),

            // Summary Cards
            ResponsiveBuilder(
              mobile: (context) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          context,
                          'Income',
                          5200.00,
                          '+15%',
                          AppTheme.incomeColor,
                          Icons.trending_up,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSummaryCard(
                          context,
                          'Expense',
                          3450.00,
                          '+8%',
                          AppTheme.expenseColor,
                          Icons.trending_down,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryCard(
                    context,
                    'Net Savings',
                    1750.00,
                    '+12%',
                    AppTheme.accentColor,
                    Icons.savings,
                    isFullWidth: true,
                  ),
                ],
              ),
              tablet: (context) => Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      'Income',
                      5200.00,
                      '+15%',
                      AppTheme.incomeColor,
                      Icons.trending_up,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      'Expense',
                      3450.00,
                      '+8%',
                      AppTheme.expenseColor,
                      Icons.trending_down,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      'Net Savings',
                      1750.00,
                      '+12%',
                      AppTheme.accentColor,
                      Icons.savings,
                    ),
                  ),
                ],
              ),
              desktop: (context) => Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      'Income',
                      5200.00,
                      '+15%',
                      AppTheme.incomeColor,
                      Icons.trending_up,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      'Expense',
                      3450.00,
                      '+8%',
                      AppTheme.expenseColor,
                      Icons.trending_down,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      'Net Savings',
                      1750.00,
                      '+12%',
                      AppTheme.accentColor,
                      Icons.savings,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: padding * 1.5),

            // Spending Trend Chart
            Text(
              'Spending Trend',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: padding),
            Card(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: SizedBox(
                  height: Responsive.value<double>(
                    context,
                    mobile: 200,
                    tablet: 250,
                    desktop: 300,
                  ),
                  child: _buildSpendingChart(),
                ),
              ),
            ),
            SizedBox(height: padding * 1.5),

            // Category Breakdown
            Text(
              'Expense by Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: padding),
            Card(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: _buildCategoryPieChart(),
                    ),
                    const SizedBox(height: 16),
                    ..._buildCategoryList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Wallet Breakdown
            Text(
              'Balance by Wallet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ..._buildWalletBreakdown(),
            const SizedBox(height: 24),

            // Top Spending Category
            Text(
              'Insights',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInsightCard(
              context,
              'Top Spending Category',
              'Food',
              '1,250.00',
              Icons.restaurant,
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildInsightCard(
              context,
              'Most Used Wallet',
              'Cash',
              '45 transactions',
              Icons.account_balance_wallet,
              Colors.green,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    double amount,
    String change,
    Color color,
    IconData icon, {
    bool isFullWidth = false,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: isFullWidth ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isFullWidth ? MainAxisAlignment.center : MainAxisAlignment.start,
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
              CurrencyFormatter.format(amount),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
              textAlign: isFullWidth ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 4),
            Text(
              '$change from last ${_selectedPeriod.toLowerCase()}',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: isFullWidth ? TextAlign.center : TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Theme.of(context).dividerColor,
              strokeWidth: 1,
            );
          },
        ),
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
                final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() < labels.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[value.toInt()],
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          // Income line
          LineChartBarData(
            spots: const [
              FlSpot(0, 100),
              FlSpot(1, 150),
              FlSpot(2, 120),
              FlSpot(3, 180),
              FlSpot(4, 160),
              FlSpot(5, 140),
              FlSpot(6, 200),
            ],
            isCurved: true,
            color: AppTheme.incomeColor,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
          // Expense line
          LineChartBarData(
            spots: const [
              FlSpot(0, 50),
              FlSpot(1, 80),
              FlSpot(2, 45),
              FlSpot(3, 120),
              FlSpot(4, 90),
              FlSpot(5, 60),
              FlSpot(6, 85),
            ],
            isCurved: true,
            color: AppTheme.expenseColor,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppTheme.expenseColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryPieChart() {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 60,
        sections: [
          PieChartSectionData(
            value: 1250,
            title: '36%',
            color: Colors.orange,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 850,
            title: '25%',
            color: Colors.blue,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 650,
            title: '19%',
            color: Colors.purple,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: 700,
            title: '20%',
            color: Colors.teal,
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryList() {
    final categories = [
      {'name': 'Food', 'amount': 1250.00, 'color': Colors.orange},
      {'name': 'Transport', 'amount': 850.00, 'color': Colors.blue},
      {'name': 'Entertainment', 'amount': 700.00, 'color': Colors.teal},
      {'name': 'Shopping', 'amount': 650.00, 'color': Colors.purple},
    ];

    return categories.map((category) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: category['color'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category['name'] as String,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Text(
              CurrencyFormatter.format(category['amount'] as double),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildWalletBreakdown() {
    final wallets = [
      {'name': 'Bank Account', 'amount': 12500.50, 'percentage': 0.70},
      {'name': 'Cash', 'amount': 1250.00, 'percentage': 0.20},
      {'name': 'Credit Card', 'amount': 2000.00, 'percentage': 0.10},
    ];

    return wallets.map((wallet) {
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    wallet['name'] as String,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    CurrencyFormatter.format(wallet['amount'] as double),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: wallet['percentage'] as double,
                backgroundColor: Theme.of(context).dividerColor,
                valueColor: AlwaysStoppedAnimation(AppTheme.accentColor),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildInsightCard(
    BuildContext context,
    String title,
    String value,
    String detail,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    detail,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
