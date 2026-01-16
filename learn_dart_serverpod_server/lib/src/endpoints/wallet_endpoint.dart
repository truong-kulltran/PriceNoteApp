import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class WalletEndpoint extends Endpoint {
  /// Create a new wallet
  Future<Wallet> createWallet(Session session, Wallet wallet) async {
    // Validate wallet data
    if (wallet.name.isEmpty) {
      throw Exception('Wallet name cannot be empty');
    }
    if (wallet.initialBalance < 0) {
      throw Exception('Initial balance cannot be negative');
    }

    // Set current balance equal to initial balance
    wallet.currentBalance = wallet.initialBalance;
    wallet.createdAt = DateTime.now();
    wallet.updatedAt = DateTime.now();

    // Insert into database
    final insertedWallet = await Wallet.db.insertRow(session, wallet);
    return insertedWallet;
  }

  /// Get all wallets for a user
  Future<List<Wallet>> getWalletsByUserId(
    Session session,
    int userId,
  ) async {
    return await Wallet.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('active'),
      orderBy: (t) => t.createdAt,
    );
  }

  /// Get a single wallet by ID
  Future<Wallet?> getWalletById(Session session, int walletId) async {
    return await Wallet.db.findById(session, walletId);
  }

  /// Update wallet details (name, currency only)
  Future<Wallet> updateWallet(Session session, Wallet wallet) async {
    if (wallet.name.isEmpty) {
      throw Exception('Wallet name cannot be empty');
    }

    wallet.updatedAt = DateTime.now();
    final updatedWallet = await Wallet.db.updateRow(session, wallet);
    return updatedWallet;
  }

  /// Archive a wallet (soft delete)
  Future<Wallet> archiveWallet(Session session, int walletId) async {
    final wallet = await Wallet.db.findById(session, walletId);
    if (wallet == null) {
      throw Exception('Wallet not found');
    }

    wallet.status = 'archived';
    wallet.updatedAt = DateTime.now();
    return await Wallet.db.updateRow(session, wallet);
  }

  /// Recalculate wallet balance based on all transactions
  Future<Wallet> recalculateBalance(Session session, int walletId) async {
    final wallet = await Wallet.db.findById(session, walletId);
    if (wallet == null) {
      throw Exception('Wallet not found');
    }

    // Get all transactions for this wallet
    final transactions = await ExpenseTransaction.db.find(
      session,
      where: (t) => t.walletId.equals(walletId),
    );

    // Calculate balance
    double balance = wallet.initialBalance;
    for (var transaction in transactions) {
      if (transaction.type == 'income') {
        balance += transaction.amount;
      } else if (transaction.type == 'expense') {
        balance -= transaction.amount;
      }
    }

    // Update wallet balance
    wallet.currentBalance = balance;
    wallet.updatedAt = DateTime.now();
    return await Wallet.db.updateRow(session, wallet);
  }

  /// Get total balance across all active wallets for a user
  Future<double> getTotalBalance(Session session, int userId) async {
    final wallets = await Wallet.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('active'),
    );

    return wallets.fold<double>(
      0,
      (sum, wallet) => sum + wallet.currentBalance,
    );
  }
}
