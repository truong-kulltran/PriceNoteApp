import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_bottom_nav.dart';

/// Wallet list page showing all user wallets
class WalletListPage extends StatelessWidget {
  const WalletListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real data from provider
    final wallets = [
      {
        'id': 1,
        'name': 'Cash',
        'balance': 1250.00,
        'currency': 'USD',
        'icon': Icons.money,
        'color': Colors.green,
      },
      {
        'id': 2,
        'name': 'Bank Account',
        'balance': 12500.50,
        'currency': 'USD',
        'icon': Icons.account_balance,
        'color': Colors.blue,
      },
      {
        'id': 3,
        'name': 'Credit Card',
        'balance': 2000.00,
        'currency': 'USD',
        'icon': Icons.credit_card,
        'color': Colors.purple,
      },
    ];

    final totalBalance = wallets.fold<double>(
      0,
      (sum, wallet) => sum + (wallet['balance'] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddWalletDialog(context);
            },
          ),
        ],
      ),
      body: CenteredContent(
        child: Column(
          children: [
            // Total across all wallets
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Responsive.padding(context) * 1.5),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: Responsive.padding(context) * 0.5),
                  Text(
                    CurrencyFormatter.format(totalBalance),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accentColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${wallets.length} active wallets',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // Wallet list
            Expanded(
              child: ResponsiveBuilder(
                mobile: (context) => ListView.builder(
                  padding: EdgeInsets.all(Responsive.padding(context)),
                  itemCount: wallets.length,
                  itemBuilder: (context, index) {
                    final wallet = wallets[index];
                    return _buildWalletCard(context, wallet);
                  },
                ),
                tablet: (context) => GridView.builder(
                  padding: EdgeInsets.all(Responsive.padding(context)),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: wallets.length,
                  itemBuilder: (context, index) {
                    final wallet = wallets[index];
                    return _buildWalletCard(context, wallet);
                  },
                ),
                desktop: (context) => GridView.builder(
                  padding: EdgeInsets.all(Responsive.padding(context)),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: wallets.length,
                  itemBuilder: (context, index) {
                    final wallet = wallets[index];
                    return _buildWalletCard(context, wallet);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }

  Widget _buildWalletCard(BuildContext context, Map<String, dynamic> wallet) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => context.push('/wallets/${wallet['id']}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (wallet['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  wallet['icon'] as IconData,
                  color: wallet['color'] as Color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),

              // Name and balance
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wallet['name'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormatter.format(
                        wallet['balance'] as double,
                        currency: wallet['currency'] as String,
                      ),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddWalletDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Wallet'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Wallet Name',
                hintText: 'e.g., Savings Account',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Initial Balance',
                hintText: '0.00',
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // TODO: Add wallet
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
