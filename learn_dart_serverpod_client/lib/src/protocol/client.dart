/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:learn_dart_serverpod_client/src/protocol/category.dart' as _i3;
import 'package:learn_dart_serverpod_client/src/protocol/transaction.dart'
    as _i4;
import 'package:learn_dart_serverpod_client/src/protocol/wallet.dart' as _i5;
import 'package:learn_dart_serverpod_client/src/protocol/greeting.dart' as _i6;
import 'protocol.dart' as _i7;

/// {@category Endpoint}
class EndpointAnalytics extends _i1.EndpointRef {
  EndpointAnalytics(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'analytics';

  /// Get daily summary for a specific date
  _i2.Future<Map<String, dynamic>> getDailySummary(
    int userId,
    DateTime date,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getDailySummary',
        {
          'userId': userId,
          'date': date,
        },
      );

  /// Get weekly summary (ISO week: Monday to Sunday)
  _i2.Future<Map<String, dynamic>> getWeeklySummary(
    int userId,
    DateTime date,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getWeeklySummary',
        {
          'userId': userId,
          'date': date,
        },
      );

  /// Get monthly summary
  _i2.Future<Map<String, dynamic>> getMonthlySummary(
    int userId,
    DateTime date,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getMonthlySummary',
        {
          'userId': userId,
          'date': date,
        },
      );

  /// Get yearly summary
  _i2.Future<Map<String, dynamic>> getYearlySummary(
    int userId,
    DateTime date,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getYearlySummary',
        {
          'userId': userId,
          'date': date,
        },
      );

  /// Get custom date range summary
  _i2.Future<Map<String, dynamic>> getCustomRangeSummary(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'analytics',
        'getCustomRangeSummary',
        {
          'userId': userId,
          'startDate': startDate,
          'endDate': endDate,
        },
      );

  /// Get spending trend (daily totals for a date range)
  _i2.Future<List<Map<String, dynamic>>> getSpendingTrend(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'analytics',
        'getSpendingTrend',
        {
          'userId': userId,
          'startDate': startDate,
          'endDate': endDate,
        },
      );

  /// Get category-wise spending comparison
  _i2.Future<List<Map<String, dynamic>>> getCategoryComparison(
    int userId,
    DateTime currentStart,
    DateTime currentEnd,
    DateTime previousStart,
    DateTime previousEnd,
  ) =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'analytics',
        'getCategoryComparison',
        {
          'userId': userId,
          'currentStart': currentStart,
          'currentEnd': currentEnd,
          'previousStart': previousStart,
          'previousEnd': previousEnd,
        },
      );
}

/// {@category Endpoint}
class EndpointCategory extends _i1.EndpointRef {
  EndpointCategory(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'category';

  /// Create a new category
  _i2.Future<_i3.Category> createCategory(_i3.Category category) =>
      caller.callServerEndpoint<_i3.Category>(
        'category',
        'createCategory',
        {'category': category},
      );

  /// Get all categories
  _i2.Future<List<_i3.Category>> getAllCategories() =>
      caller.callServerEndpoint<List<_i3.Category>>(
        'category',
        'getAllCategories',
        {},
      );

  /// Get categories by type (income or expense)
  _i2.Future<List<_i3.Category>> getCategoriesByType(String type) =>
      caller.callServerEndpoint<List<_i3.Category>>(
        'category',
        'getCategoriesByType',
        {'type': type},
      );

  /// Get a single category by ID
  _i2.Future<_i3.Category?> getCategoryById(int categoryId) =>
      caller.callServerEndpoint<_i3.Category?>(
        'category',
        'getCategoryById',
        {'categoryId': categoryId},
      );

  /// Update category
  _i2.Future<_i3.Category> updateCategory(_i3.Category category) =>
      caller.callServerEndpoint<_i3.Category>(
        'category',
        'updateCategory',
        {'category': category},
      );

  /// Delete category
  _i2.Future<void> deleteCategory(int categoryId) =>
      caller.callServerEndpoint<void>(
        'category',
        'deleteCategory',
        {'categoryId': categoryId},
      );

  /// Initialize default categories
  _i2.Future<List<_i3.Category>> initializeDefaultCategories() =>
      caller.callServerEndpoint<List<_i3.Category>>(
        'category',
        'initializeDefaultCategories',
        {},
      );
}

/// {@category Endpoint}
class EndpointTransaction extends _i1.EndpointRef {
  EndpointTransaction(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'transaction';

  /// Create a new transaction and update wallet balance
  _i2.Future<_i4.ExpenseTransaction> createTransaction(
          _i4.ExpenseTransaction transaction) =>
      caller.callServerEndpoint<_i4.ExpenseTransaction>(
        'transaction',
        'createTransaction',
        {'transaction': transaction},
      );

  /// Get all transactions for a user
  _i2.Future<List<_i4.ExpenseTransaction>> getTransactionsByUserId(
    int userId, {
    int? limit,
    int? offset,
  }) =>
      caller.callServerEndpoint<List<_i4.ExpenseTransaction>>(
        'transaction',
        'getTransactionsByUserId',
        {
          'userId': userId,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Get all transactions for a wallet
  _i2.Future<List<_i4.ExpenseTransaction>> getTransactionsByWalletId(
    int walletId, {
    int? limit,
    int? offset,
  }) =>
      caller.callServerEndpoint<List<_i4.ExpenseTransaction>>(
        'transaction',
        'getTransactionsByWalletId',
        {
          'walletId': walletId,
          'limit': limit,
          'offset': offset,
        },
      );

  /// Get transactions for a specific date range
  _i2.Future<List<_i4.ExpenseTransaction>> getTransactionsByDateRange(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) =>
      caller.callServerEndpoint<List<_i4.ExpenseTransaction>>(
        'transaction',
        'getTransactionsByDateRange',
        {
          'userId': userId,
          'startDate': startDate,
          'endDate': endDate,
        },
      );

  /// Get a single transaction by ID
  _i2.Future<_i4.ExpenseTransaction?> getTransactionById(int transactionId) =>
      caller.callServerEndpoint<_i4.ExpenseTransaction?>(
        'transaction',
        'getTransactionById',
        {'transactionId': transactionId},
      );

  /// Update a transaction and recalculate wallet balance
  _i2.Future<_i4.ExpenseTransaction> updateTransaction(
          _i4.ExpenseTransaction updatedTransaction) =>
      caller.callServerEndpoint<_i4.ExpenseTransaction>(
        'transaction',
        'updateTransaction',
        {'updatedTransaction': updatedTransaction},
      );

  /// Delete a transaction and update wallet balance
  _i2.Future<void> deleteTransaction(int transactionId) =>
      caller.callServerEndpoint<void>(
        'transaction',
        'deleteTransaction',
        {'transactionId': transactionId},
      );

  /// Get today's transactions for a user
  _i2.Future<List<_i4.ExpenseTransaction>> getTodayTransactions(int userId) =>
      caller.callServerEndpoint<List<_i4.ExpenseTransaction>>(
        'transaction',
        'getTodayTransactions',
        {'userId': userId},
      );

  /// Get total income for a date range
  _i2.Future<double> getTotalIncome(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) =>
      caller.callServerEndpoint<double>(
        'transaction',
        'getTotalIncome',
        {
          'userId': userId,
          'startDate': startDate,
          'endDate': endDate,
        },
      );

  /// Get total expenses for a date range
  _i2.Future<double> getTotalExpenses(
    int userId,
    DateTime startDate,
    DateTime endDate,
  ) =>
      caller.callServerEndpoint<double>(
        'transaction',
        'getTotalExpenses',
        {
          'userId': userId,
          'startDate': startDate,
          'endDate': endDate,
        },
      );
}

/// {@category Endpoint}
class EndpointWallet extends _i1.EndpointRef {
  EndpointWallet(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'wallet';

  /// Create a new wallet
  _i2.Future<_i5.Wallet> createWallet(_i5.Wallet wallet) =>
      caller.callServerEndpoint<_i5.Wallet>(
        'wallet',
        'createWallet',
        {'wallet': wallet},
      );

  /// Get all wallets for a user
  _i2.Future<List<_i5.Wallet>> getWalletsByUserId(int userId) =>
      caller.callServerEndpoint<List<_i5.Wallet>>(
        'wallet',
        'getWalletsByUserId',
        {'userId': userId},
      );

  /// Get a single wallet by ID
  _i2.Future<_i5.Wallet?> getWalletById(int walletId) =>
      caller.callServerEndpoint<_i5.Wallet?>(
        'wallet',
        'getWalletById',
        {'walletId': walletId},
      );

  /// Update wallet details (name, currency only)
  _i2.Future<_i5.Wallet> updateWallet(_i5.Wallet wallet) =>
      caller.callServerEndpoint<_i5.Wallet>(
        'wallet',
        'updateWallet',
        {'wallet': wallet},
      );

  /// Archive a wallet (soft delete)
  _i2.Future<_i5.Wallet> archiveWallet(int walletId) =>
      caller.callServerEndpoint<_i5.Wallet>(
        'wallet',
        'archiveWallet',
        {'walletId': walletId},
      );

  /// Recalculate wallet balance based on all transactions
  _i2.Future<_i5.Wallet> recalculateBalance(int walletId) =>
      caller.callServerEndpoint<_i5.Wallet>(
        'wallet',
        'recalculateBalance',
        {'walletId': walletId},
      );

  /// Get total balance across all active wallets for a user
  _i2.Future<double> getTotalBalance(int userId) =>
      caller.callServerEndpoint<double>(
        'wallet',
        'getTotalBalance',
        {'userId': userId},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i6.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i6.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i7.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    analytics = EndpointAnalytics(this);
    category = EndpointCategory(this);
    transaction = EndpointTransaction(this);
    wallet = EndpointWallet(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointAnalytics analytics;

  late final EndpointCategory category;

  late final EndpointTransaction transaction;

  late final EndpointWallet wallet;

  late final EndpointGreeting greeting;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'analytics': analytics,
        'category': category,
        'transaction': transaction,
        'wallet': wallet,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
