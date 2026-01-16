import 'package:serverpod/serverpod.dart';

/// Analytics summary data transfer object
class AnalyticsSummary {
  final double totalIncome;
  final double totalExpense;
  final double netBalance;
  final Map<String, double> categoryBreakdown;
  final Map<String, double> walletBreakdown;
  final String? topCategory;
  final String? mostUsedWallet;

  AnalyticsSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.netBalance,
    required this.categoryBreakdown,
    required this.walletBreakdown,
    this.topCategory,
    this.mostUsedWallet,
  });

  Map<String, dynamic> toJson() => {
        'totalIncome': totalIncome,
        'totalExpense': totalExpense,
        'netBalance': netBalance,
        'categoryBreakdown': categoryBreakdown,
        'walletBreakdown': walletBreakdown,
        'topCategory': topCategory,
        'mostUsedWallet': mostUsedWallet,
      };
}
