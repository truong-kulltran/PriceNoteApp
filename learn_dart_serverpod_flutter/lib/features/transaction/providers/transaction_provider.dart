import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_dart_serverpod_client/learn_dart_serverpod_client.dart';
import '../../../core/providers/serverpod_provider.dart';

/// AsyncNotifier for managing transactions
class TransactionsNotifier extends AsyncNotifier<List<ExpenseTransaction>> {
  @override
  Future<List<ExpenseTransaction>> build() async {
    final client = ref.watch(serverpodClientProvider);
    final userId = ref.watch(currentUserIdProvider);
    return await client.transaction.getTransactionsByUserId(userId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      final userId = ref.read(currentUserIdProvider);
      return await client.transaction.getTransactionsByUserId(userId);
    });
  }

  Future<void> createTransaction(ExpenseTransaction transaction) async {
    try {
      final client = ref.read(serverpodClientProvider);
      await client.transaction.createTransaction(transaction);
      await refresh();
      ref.invalidate(recentTransactionsProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTransaction(ExpenseTransaction transaction) async {
    try {
      final client = ref.read(serverpodClientProvider);
      await client.transaction.updateTransaction(transaction);
      await refresh();
      ref.invalidate(recentTransactionsProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    try {
      final client = ref.read(serverpodClientProvider);
      await client.transaction.deleteTransaction(transactionId);
      await refresh();
      ref.invalidate(recentTransactionsProvider);
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider to fetch all transactions for the current user
final transactionsProvider = AsyncNotifierProvider<TransactionsNotifier, List<ExpenseTransaction>>(
  TransactionsNotifier.new,
);

/// AsyncNotifier for transactions by wallet
class TransactionsByWalletNotifier extends FamilyAsyncNotifier<List<ExpenseTransaction>, int> {
  @override
  Future<List<ExpenseTransaction>> build(int arg) async {
    final client = ref.watch(serverpodClientProvider);
    return await client.transaction.getTransactionsByWalletId(arg);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      return await client.transaction.getTransactionsByWalletId(arg);
    });
  }
}

/// Provider to fetch transactions for a specific wallet
final transactionsByWalletProvider =
    AsyncNotifierProvider.family<TransactionsByWalletNotifier, List<ExpenseTransaction>, int>(
  TransactionsByWalletNotifier.new,
);

/// AsyncNotifier for recent transactions
class RecentTransactionsNotifier extends AsyncNotifier<List<ExpenseTransaction>> {
  @override
  Future<List<ExpenseTransaction>> build() async {
    final client = ref.watch(serverpodClientProvider);
    final userId = ref.watch(currentUserIdProvider);
    return await client.transaction.getTransactionsByUserId(
      userId,
      limit: 10,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      final userId = ref.read(currentUserIdProvider);
      return await client.transaction.getTransactionsByUserId(
        userId,
        limit: 10,
      );
    });
  }
}

/// Provider to fetch recent transactions (limited)
final recentTransactionsProvider = AsyncNotifierProvider<RecentTransactionsNotifier, List<ExpenseTransaction>>(
  RecentTransactionsNotifier.new,
);
