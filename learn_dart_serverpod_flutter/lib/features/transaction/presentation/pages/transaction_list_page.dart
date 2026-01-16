import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_bottom_nav.dart';

/// Transaction list page with filtering and search
class TransactionListPage extends StatefulWidget {
  const TransactionListPage({super.key});

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Income', 'Expense'];

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real data from provider
    final transactions = [
      {
        'id': 1,
        'title': 'Grocery Shopping',
        'amount': -85.50,
        'date': DateTime.now(),
        'category': 'Food',
        'wallet': 'Cash',
        'note': 'Weekly groceries at Walmart',
      },
      {
        'id': 2,
        'title': 'Salary',
        'amount': 5000.00,
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'category': 'Income',
        'wallet': 'Bank Account',
        'note': 'Monthly salary deposit',
      },
      {
        'id': 3,
        'title': 'Transportation',
        'amount': -25.00,
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'category': 'Transport',
        'wallet': 'Cash',
        'note': 'Uber ride to office',
      },
      {
        'id': 4,
        'title': 'Restaurant',
        'amount': -45.00,
        'date': DateTime.now().subtract(const Duration(days: 3)),
        'category': 'Food',
        'wallet': 'Credit Card',
        'note': 'Dinner with friends',
      },
    ];

    // Filter transactions
    final filteredTransactions = _selectedFilter == 'All'
        ? transactions
        : transactions.where((t) {
            if (_selectedFilter == 'Income') {
              return (t['amount'] as double) > 0;
            } else {
              return (t['amount'] as double) < 0;
            }
          }).toList();

    // Group by date
    final groupedTransactions = _groupByDate(filteredTransactions);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = filter == _selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Transaction list
          Expanded(
            child: filteredTransactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No transactions yet',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add your first transaction',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : ResponsiveBuilder(
                    mobile: (context) => ListView.builder(
                      padding: EdgeInsets.all(Responsive.padding(context)),
                      itemCount: groupedTransactions.length,
                      itemBuilder: (context, index) {
                        final date = groupedTransactions.keys.elementAt(index);
                        final dateTransactions = groupedTransactions[date]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date header
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormatter.formatRelative(date),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    _calculateDayTotal(dateTransactions),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),

                            // Transactions for this date
                            ...dateTransactions.map(
                              (transaction) => _buildTransactionCard(context, transaction),
                            ),

                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                    tablet: (context) => ListView.builder(
                      padding: EdgeInsets.all(Responsive.padding(context)),
                      itemCount: groupedTransactions.length,
                      itemBuilder: (context, index) {
                        final date = groupedTransactions.keys.elementAt(index);
                        final dateTransactions = groupedTransactions[date]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormatter.formatRelative(date),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    _calculateDayTotal(dateTransactions),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            ...dateTransactions.map(
                              (transaction) => _buildTransactionCard(context, transaction),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                    desktop: (context) => ListView.builder(
                      padding: EdgeInsets.all(Responsive.padding(context)),
                      itemCount: groupedTransactions.length,
                      itemBuilder: (context, index) {
                        final date = groupedTransactions.keys.elementAt(index);
                        final dateTransactions = groupedTransactions[date]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormatter.formatRelative(date),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    _calculateDayTotal(dateTransactions),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            ...dateTransactions.map(
                              (transaction) => _buildTransactionCard(context, transaction),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-transaction'),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  Map<DateTime, List<Map<String, dynamic>>> _groupByDate(
    List<Map<String, dynamic>> transactions,
  ) {
    final Map<DateTime, List<Map<String, dynamic>>> grouped = {};

    for (final transaction in transactions) {
      final date = transaction['date'] as DateTime;
      final dateOnly = DateTime(date.year, date.month, date.day);

      if (!grouped.containsKey(dateOnly)) {
        grouped[dateOnly] = [];
      }
      grouped[dateOnly]!.add(transaction);
    }

    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
    );
  }

  String _calculateDayTotal(List<Map<String, dynamic>> transactions) {
    final total = transactions.fold<double>(
      0,
      (sum, t) => sum + (t['amount'] as double),
    );
    return CurrencyFormatter.formatWithSign(total);
  }

  Widget _buildTransactionCard(
    BuildContext context,
    Map<String, dynamic> transaction,
  ) {
    final isIncome = (transaction['amount'] as double) > 0;
    final color = isIncome ? AppTheme.incomeColor : AppTheme.expenseColor;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          _showTransactionDetail(context, transaction);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['title'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              transaction['category'] as String,
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            ' • ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Flexible(
                            child: Text(
                              transaction['wallet'] as String,
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Amount
              Text(
                CurrencyFormatter.formatWithSign(
                  transaction['amount'] as double,
                ),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('All Transactions'),
              leading: const Icon(Icons.all_inclusive),
              onTap: () {
                setState(() => _selectedFilter = 'All');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Income Only'),
              leading: Icon(Icons.arrow_upward, color: AppTheme.incomeColor),
              onTap: () {
                setState(() => _selectedFilter = 'Income');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Expense Only'),
              leading: Icon(Icons.arrow_downward, color: AppTheme.expenseColor),
              onTap: () {
                setState(() => _selectedFilter = 'Expense');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetail(
    BuildContext context,
    Map<String, dynamic> transaction,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          final isIncome = (transaction['amount'] as double) > 0;
          final color = isIncome ? AppTheme.incomeColor : AppTheme.expenseColor;

          return Container(
            padding: const EdgeInsets.all(24),
            child: ListView(
              controller: scrollController,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Icon and amount
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                          color: color,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        CurrencyFormatter.format(
                          (transaction['amount'] as double).abs(),
                        ),
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Details
                _buildDetailRow(
                  context,
                  'Title',
                  transaction['title'] as String,
                ),
                _buildDetailRow(
                  context,
                  'Category',
                  transaction['category'] as String,
                ),
                _buildDetailRow(
                  context,
                  'Wallet',
                  transaction['wallet'] as String,
                ),
                _buildDetailRow(
                  context,
                  'Date',
                  DateFormatter.formatDateTime(
                    transaction['date'] as DateTime,
                  ),
                ),
                if (transaction['note'] != null && (transaction['note'] as String).isNotEmpty)
                  _buildDetailRow(
                    context,
                    'Note',
                    transaction['note'] as String,
                  ),

                const SizedBox(height: 24),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          // TODO: Edit transaction
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          // TODO: Delete transaction
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.expenseColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
