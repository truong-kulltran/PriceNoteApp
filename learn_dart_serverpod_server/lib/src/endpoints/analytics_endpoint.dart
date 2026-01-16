import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../models/analytics_summary.dart';

class AnalyticsEndpoint extends Endpoint {
  /// Get daily summary for a specific date
  Future<Map<String, dynamic>> getDailySummary(
    Session session,
    int userId,
    DateTime date,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return await _getSummary(session, userId, startOfDay, endOfDay);
  }

  /// Get weekly summary (ISO week: Monday to Sunday)
  Future<Map<String, dynamic>> getWeeklySummary(
    Session session,
    int userId,
    DateTime date,
  ) async {
    // Get the start of the week (Monday)
    final dayOfWeek = date.weekday;
    final startOfWeek = date.subtract(Duration(days: dayOfWeek - 1));
    final startOfWeekMidnight = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );
    final endOfWeek = startOfWeekMidnight.add(const Duration(days: 7));

    return await _getSummary(session, userId, startOfWeekMidnight, endOfWeek);
  }

  /// Get monthly summary
  Future<Map<String, dynamic>> getMonthlySummary(
    Session session,
    int userId,
    DateTime date,
  ) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 1);

    return await _getSummary(session, userId, startOfMonth, endOfMonth);
  }

  /// Get yearly summary
  Future<Map<String, dynamic>> getYearlySummary(
    Session session,
    int userId,
    DateTime date,
  ) async {
    final startOfYear = DateTime(date.year, 1, 1);
    final endOfYear = DateTime(date.year + 1, 1, 1);

    return await _getSummary(session, userId, startOfYear, endOfYear);
  }

  /// Get custom date range summary
  Future<Map<String, dynamic>> getCustomRangeSummary(
    Session session,
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await _getSummary(session, userId, startDate, endDate);
  }

  /// Internal method to calculate summary for any date range
  Future<Map<String, dynamic>> _getSummary(
    Session session,
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    // Get all transactions in the date range
    final transactions = await ExpenseTransaction.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.transactionDate.between(startDate, endDate),
    );

    // Calculate totals
    double totalIncome = 0;
    double totalExpense = 0;
    Map<int, double> categoryExpenses = {};
    Map<int, double> walletBreakdown = {};
    Map<int, int> categoryCount = {};
    Map<int, int> walletCount = {};

    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        totalIncome += transaction.amount;
      } else if (transaction.type == 'expense') {
        totalExpense += transaction.amount;

        // Track category expenses
        if (transaction.categoryId != null) {
          categoryExpenses[transaction.categoryId!] =
              (categoryExpenses[transaction.categoryId!] ?? 0) + transaction.amount;
          categoryCount[transaction.categoryId!] = (categoryCount[transaction.categoryId!] ?? 0) + 1;
        }
      }

      // Track wallet breakdown
      walletBreakdown[transaction.walletId] = (walletBreakdown[transaction.walletId] ?? 0) + transaction.amount;
      walletCount[transaction.walletId] = (walletCount[transaction.walletId] ?? 0) + 1;
    }

    // Get category and wallet names
    Map<String, double> categoryBreakdownNamed = {};
    String? topCategory;
    double maxCategoryAmount = 0;

    for (var entry in categoryExpenses.entries) {
      final category = await Category.db.findById(session, entry.key);
      if (category != null) {
        categoryBreakdownNamed[category.name] = entry.value;
        if (entry.value > maxCategoryAmount) {
          maxCategoryAmount = entry.value;
          topCategory = category.name;
        }
      }
    }

    Map<String, double> walletBreakdownNamed = {};
    String? mostUsedWallet;
    int maxWalletCount = 0;

    for (var entry in walletBreakdown.entries) {
      final wallet = await Wallet.db.findById(session, entry.key);
      if (wallet != null) {
        walletBreakdownNamed[wallet.name] = entry.value;
        final count = walletCount[entry.key] ?? 0;
        if (count > maxWalletCount) {
          maxWalletCount = count;
          mostUsedWallet = wallet.name;
        }
      }
    }

    final netBalance = totalIncome - totalExpense;

    return AnalyticsSummary(
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      netBalance: netBalance,
      categoryBreakdown: categoryBreakdownNamed,
      walletBreakdown: walletBreakdownNamed,
      topCategory: topCategory,
      mostUsedWallet: mostUsedWallet,
    ).toJson();
  }

  /// Get spending trend (daily totals for a date range)
  Future<List<Map<String, dynamic>>> getSpendingTrend(
    Session session,
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactions = await ExpenseTransaction.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.transactionDate.between(startDate, endDate),
      orderBy: (t) => t.transactionDate,
    );

    // Group by date
    Map<String, Map<String, double>> dailyData = {};

    for (var transaction in transactions) {
      final dateKey = DateTime(
        transaction.transactionDate.year,
        transaction.transactionDate.month,
        transaction.transactionDate.day,
      ).toIso8601String().split('T')[0];

      if (!dailyData.containsKey(dateKey)) {
        dailyData[dateKey] = {'income': 0, 'expense': 0};
      }

      if (transaction.type == 'income') {
        dailyData[dateKey]!['income'] = dailyData[dateKey]!['income']! + transaction.amount;
      } else if (transaction.type == 'expense') {
        dailyData[dateKey]!['expense'] = dailyData[dateKey]!['expense']! + transaction.amount;
      }
    }

    // Convert to list
    return dailyData.entries.map((entry) {
      return {
        'date': entry.key,
        'income': entry.value['income'],
        'expense': entry.value['expense'],
        'net': entry.value['income']! - entry.value['expense']!,
      };
    }).toList();
  }

  /// Get category-wise spending comparison
  Future<List<Map<String, dynamic>>> getCategoryComparison(
    Session session,
    int userId,
    DateTime currentStart,
    DateTime currentEnd,
    DateTime previousStart,
    DateTime previousEnd,
  ) async {
    final currentTransactions = await ExpenseTransaction.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.type.equals('expense') & t.transactionDate.between(currentStart, currentEnd),
    );

    final previousTransactions = await ExpenseTransaction.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.type.equals('expense') & t.transactionDate.between(previousStart, previousEnd),
    );

    Map<int, double> currentCategoryTotals = {};
    Map<int, double> previousCategoryTotals = {};

    for (var t in currentTransactions) {
      if (t.categoryId != null) {
        currentCategoryTotals[t.categoryId!] = (currentCategoryTotals[t.categoryId!] ?? 0) + t.amount;
      }
    }

    for (var t in previousTransactions) {
      if (t.categoryId != null) {
        previousCategoryTotals[t.categoryId!] = (previousCategoryTotals[t.categoryId!] ?? 0) + t.amount;
      }
    }

    // Get all unique category IDs
    final allCategoryIds = {...currentCategoryTotals.keys, ...previousCategoryTotals.keys};

    List<Map<String, dynamic>> comparison = [];

    for (var categoryId in allCategoryIds) {
      final category = await Category.db.findById(session, categoryId);
      if (category != null) {
        final current = currentCategoryTotals[categoryId] ?? 0;
        final previous = previousCategoryTotals[categoryId] ?? 0;
        final change = current - previous;
        final percentChange = previous > 0 ? ((change / previous) * 100) : (current > 0 ? 100 : 0);

        comparison.add({
          'categoryName': category.name,
          'currentPeriod': current,
          'previousPeriod': previous,
          'change': change,
          'percentChange': percentChange,
        });
      }
    }

    return comparison;
  }
}
