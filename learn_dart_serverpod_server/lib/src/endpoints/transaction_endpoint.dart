import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class TransactionEndpoint extends Endpoint {
  /// Create a new transaction and update wallet balance
  Future<Transaction> createTransaction(
    Session session,
    Transaction transaction,
  ) async {
    // Validate transaction data
    if (transaction.amount <= 0) {
      throw Exception('Transaction amount must be greater than 0');
    }
    if (transaction.type != 'income' && transaction.type != 'expense') {
      throw Exception('Transaction type must be either income or expense');
    }

    // Get the wallet to update balance
    final wallet = await Wallet.db.findById(session, transaction.walletId);
    if (wallet == null) {
      throw Exception('Wallet not found');
    }

    // Set timestamps
    transaction.createdAt = DateTime.now();
    transaction.updatedAt = DateTime.now();

    // Insert transaction
    final insertedTransaction = await Transaction.db.insertRow(
      session,
      transaction,
    );

    // Update wallet balance
    if (transaction.type == 'income') {
      wallet.currentBalance += transaction.amount;
    } else {
      wallet.currentBalance -= transaction.amount;
    }
    wallet.updatedAt = DateTime.now();
    await Wallet.db.updateRow(session, wallet);

    return insertedTransaction;
  }

  /// Get all transactions for a user
  Future<List<Transaction>> getTransactionsByUserId(
    Session session,
    int userId, {
    int? limit,
    int? offset,
  }) async {
    return await Transaction.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.transactionDate,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Get all transactions for a wallet
  Future<List<Transaction>> getTransactionsByWalletId(
    Session session,
    int walletId, {
    int? limit,
    int? offset,
  }) async {
    return await Transaction.db.find(
      session,
      where: (t) => t.walletId.equals(walletId),
      orderBy: (t) => t.transactionDate,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Get transactions for a specific date range
  Future<List<Transaction>> getTransactionsByDateRange(
    Session session,
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await Transaction.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.transactionDate.between(startDate, endDate),
      orderBy: (t) => t.transactionDate,
      orderDescending: true,
    );
  }

  /// Get a single transaction by ID
  Future<Transaction?> getTransactionById(
    Session session,
    int transactionId,
  ) async {
    return await Transaction.db.findById(session, transactionId);
  }

  /// Update a transaction and recalculate wallet balance
  Future<Transaction> updateTransaction(
    Session session,
    Transaction updatedTransaction,
  ) async {
    // Validate
    if (updatedTransaction.amount <= 0) {
      throw Exception('Transaction amount must be greater than 0');
    }

    // Get the old transaction to reverse its effect
    final oldTransaction = await Transaction.db.findById(
      session,
      updatedTransaction.id!,
    );
    if (oldTransaction == null) {
      throw Exception('Transaction not found');
    }

    // Get the wallet
    final wallet = await Wallet.db.findById(
      session,
      updatedTransaction.walletId,
    );
    if (wallet == null) {
      throw Exception('Wallet not found');
    }

    // Reverse old transaction effect
    if (oldTransaction.type == 'income') {
      wallet.currentBalance -= oldTransaction.amount;
    } else {
      wallet.currentBalance += oldTransaction.amount;
    }

    // Apply new transaction effect
    if (updatedTransaction.type == 'income') {
      wallet.currentBalance += updatedTransaction.amount;
    } else {
      wallet.currentBalance -= updatedTransaction.amount;
    }

    // Update transaction
    updatedTransaction.updatedAt = DateTime.now();
    final result = await Transaction.db.updateRow(session, updatedTransaction);

    // Update wallet
    wallet.updatedAt = DateTime.now();
    await Wallet.db.updateRow(session, wallet);

    return result;
  }

  /// Delete a transaction and update wallet balance
  Future<void> deleteTransaction(Session session, int transactionId) async {
    // Get the transaction
    final transaction = await Transaction.db.findById(session, transactionId);
    if (transaction == null) {
      throw Exception('Transaction not found');
    }

    // Get the wallet
    final wallet = await Wallet.db.findById(session, transaction.walletId);
    if (wallet == null) {
      throw Exception('Wallet not found');
    }

    // Reverse transaction effect on wallet
    if (transaction.type == 'income') {
      wallet.currentBalance -= transaction.amount;
    } else {
      wallet.currentBalance += transaction.amount;
    }

    // Update wallet
    wallet.updatedAt = DateTime.now();
    await Wallet.db.updateRow(session, wallet);

    // Delete transaction
    await Transaction.db.deleteRow(session, transaction);
  }

  /// Get today's transactions for a user
  Future<List<Transaction>> getTodayTransactions(
    Session session,
    int userId,
  ) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return await getTransactionsByDateRange(
      session,
      userId,
      startOfDay,
      endOfDay,
    );
  }

  /// Get total income for a date range
  Future<double> getTotalIncome(
    Session session,
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactions = await Transaction.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.type.equals('income') &
          t.transactionDate.between(startDate, endDate),
    );

    return transactions.fold<double>(
      0,
      (sum, transaction) => sum + transaction.amount,
    );
  }

  /// Get total expenses for a date range
  Future<double> getTotalExpenses(
    Session session,
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactions = await Transaction.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.type.equals('expense') &
          t.transactionDate.between(startDate, endDate),
    );

    return transactions.fold<double>(
      0,
      (sum, transaction) => sum + transaction.amount,
    );
  }
}
