/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/analytics_endpoint.dart' as _i2;
import '../endpoints/category_endpoint.dart' as _i3;
import '../endpoints/transaction_endpoint.dart' as _i4;
import '../endpoints/wallet_endpoint.dart' as _i5;
import '../greeting_endpoint.dart' as _i6;
import 'package:learn_dart_serverpod_server/src/generated/category.dart' as _i7;
import 'package:learn_dart_serverpod_server/src/generated/transaction.dart'
    as _i8;
import 'package:learn_dart_serverpod_server/src/generated/wallet.dart' as _i9;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'analytics': _i2.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'category': _i3.CategoryEndpoint()
        ..initialize(
          server,
          'category',
          null,
        ),
      'transaction': _i4.TransactionEndpoint()
        ..initialize(
          server,
          'transaction',
          null,
        ),
      'wallet': _i5.WalletEndpoint()
        ..initialize(
          server,
          'wallet',
          null,
        ),
      'greeting': _i6.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['analytics'] = _i1.EndpointConnector(
      name: 'analytics',
      endpoint: endpoints['analytics']!,
      methodConnectors: {
        'getDailySummary': _i1.MethodConnector(
          name: 'getDailySummary',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i2.AnalyticsEndpoint).getDailySummary(
            session,
            params['userId'],
            params['date'],
          ),
        ),
        'getWeeklySummary': _i1.MethodConnector(
          name: 'getWeeklySummary',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i2.AnalyticsEndpoint)
                  .getWeeklySummary(
            session,
            params['userId'],
            params['date'],
          ),
        ),
        'getMonthlySummary': _i1.MethodConnector(
          name: 'getMonthlySummary',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i2.AnalyticsEndpoint)
                  .getMonthlySummary(
            session,
            params['userId'],
            params['date'],
          ),
        ),
        'getYearlySummary': _i1.MethodConnector(
          name: 'getYearlySummary',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i2.AnalyticsEndpoint)
                  .getYearlySummary(
            session,
            params['userId'],
            params['date'],
          ),
        ),
        'getCustomRangeSummary': _i1.MethodConnector(
          name: 'getCustomRangeSummary',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i2.AnalyticsEndpoint)
                  .getCustomRangeSummary(
            session,
            params['userId'],
            params['startDate'],
            params['endDate'],
          ),
        ),
        'getSpendingTrend': _i1.MethodConnector(
          name: 'getSpendingTrend',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i2.AnalyticsEndpoint)
                  .getSpendingTrend(
            session,
            params['userId'],
            params['startDate'],
            params['endDate'],
          ),
        ),
        'getCategoryComparison': _i1.MethodConnector(
          name: 'getCategoryComparison',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'currentStart': _i1.ParameterDescription(
              name: 'currentStart',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'currentEnd': _i1.ParameterDescription(
              name: 'currentEnd',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'previousStart': _i1.ParameterDescription(
              name: 'previousStart',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'previousEnd': _i1.ParameterDescription(
              name: 'previousEnd',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i2.AnalyticsEndpoint)
                  .getCategoryComparison(
            session,
            params['userId'],
            params['currentStart'],
            params['currentEnd'],
            params['previousStart'],
            params['previousEnd'],
          ),
        ),
      },
    );
    connectors['category'] = _i1.EndpointConnector(
      name: 'category',
      endpoint: endpoints['category']!,
      methodConnectors: {
        'createCategory': _i1.MethodConnector(
          name: 'createCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i7.Category>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).createCategory(
            session,
            params['category'],
          ),
        ),
        'getAllCategories': _i1.MethodConnector(
          name: 'getAllCategories',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint)
                  .getAllCategories(session),
        ),
        'getCategoriesByType': _i1.MethodConnector(
          name: 'getCategoriesByType',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint)
                  .getCategoriesByType(
            session,
            params['type'],
          ),
        ),
        'getCategoryById': _i1.MethodConnector(
          name: 'getCategoryById',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).getCategoryById(
            session,
            params['categoryId'],
          ),
        ),
        'updateCategory': _i1.MethodConnector(
          name: 'updateCategory',
          params: {
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i7.Category>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).updateCategory(
            session,
            params['category'],
          ),
        ),
        'deleteCategory': _i1.MethodConnector(
          name: 'deleteCategory',
          params: {
            'categoryId': _i1.ParameterDescription(
              name: 'categoryId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint).deleteCategory(
            session,
            params['categoryId'],
          ),
        ),
        'initializeDefaultCategories': _i1.MethodConnector(
          name: 'initializeDefaultCategories',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['category'] as _i3.CategoryEndpoint)
                  .initializeDefaultCategories(session),
        ),
      },
    );
    connectors['transaction'] = _i1.EndpointConnector(
      name: 'transaction',
      endpoint: endpoints['transaction']!,
      methodConnectors: {
        'createTransaction': _i1.MethodConnector(
          name: 'createTransaction',
          params: {
            'transaction': _i1.ParameterDescription(
              name: 'transaction',
              type: _i1.getType<_i8.ExpenseTransaction>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .createTransaction(
            session,
            params['transaction'],
          ),
        ),
        'getTransactionsByUserId': _i1.MethodConnector(
          name: 'getTransactionsByUserId',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .getTransactionsByUserId(
            session,
            params['userId'],
            limit: params['limit'],
            offset: params['offset'],
          ),
        ),
        'getTransactionsByWalletId': _i1.MethodConnector(
          name: 'getTransactionsByWalletId',
          params: {
            'walletId': _i1.ParameterDescription(
              name: 'walletId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .getTransactionsByWalletId(
            session,
            params['walletId'],
            limit: params['limit'],
            offset: params['offset'],
          ),
        ),
        'getTransactionsByDateRange': _i1.MethodConnector(
          name: 'getTransactionsByDateRange',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .getTransactionsByDateRange(
            session,
            params['userId'],
            params['startDate'],
            params['endDate'],
          ),
        ),
        'getTransactionById': _i1.MethodConnector(
          name: 'getTransactionById',
          params: {
            'transactionId': _i1.ParameterDescription(
              name: 'transactionId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .getTransactionById(
            session,
            params['transactionId'],
          ),
        ),
        'updateTransaction': _i1.MethodConnector(
          name: 'updateTransaction',
          params: {
            'updatedTransaction': _i1.ParameterDescription(
              name: 'updatedTransaction',
              type: _i1.getType<_i8.ExpenseTransaction>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .updateTransaction(
            session,
            params['updatedTransaction'],
          ),
        ),
        'deleteTransaction': _i1.MethodConnector(
          name: 'deleteTransaction',
          params: {
            'transactionId': _i1.ParameterDescription(
              name: 'transactionId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .deleteTransaction(
            session,
            params['transactionId'],
          ),
        ),
        'getTodayTransactions': _i1.MethodConnector(
          name: 'getTodayTransactions',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .getTodayTransactions(
            session,
            params['userId'],
          ),
        ),
        'getTotalIncome': _i1.MethodConnector(
          name: 'getTotalIncome',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .getTotalIncome(
            session,
            params['userId'],
            params['startDate'],
            params['endDate'],
          ),
        ),
        'getTotalExpenses': _i1.MethodConnector(
          name: 'getTotalExpenses',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['transaction'] as _i4.TransactionEndpoint)
                  .getTotalExpenses(
            session,
            params['userId'],
            params['startDate'],
            params['endDate'],
          ),
        ),
      },
    );
    connectors['wallet'] = _i1.EndpointConnector(
      name: 'wallet',
      endpoint: endpoints['wallet']!,
      methodConnectors: {
        'createWallet': _i1.MethodConnector(
          name: 'createWallet',
          params: {
            'wallet': _i1.ParameterDescription(
              name: 'wallet',
              type: _i1.getType<_i9.Wallet>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['wallet'] as _i5.WalletEndpoint).createWallet(
            session,
            params['wallet'],
          ),
        ),
        'getWalletsByUserId': _i1.MethodConnector(
          name: 'getWalletsByUserId',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['wallet'] as _i5.WalletEndpoint).getWalletsByUserId(
            session,
            params['userId'],
          ),
        ),
        'getWalletById': _i1.MethodConnector(
          name: 'getWalletById',
          params: {
            'walletId': _i1.ParameterDescription(
              name: 'walletId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['wallet'] as _i5.WalletEndpoint).getWalletById(
            session,
            params['walletId'],
          ),
        ),
        'updateWallet': _i1.MethodConnector(
          name: 'updateWallet',
          params: {
            'wallet': _i1.ParameterDescription(
              name: 'wallet',
              type: _i1.getType<_i9.Wallet>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['wallet'] as _i5.WalletEndpoint).updateWallet(
            session,
            params['wallet'],
          ),
        ),
        'archiveWallet': _i1.MethodConnector(
          name: 'archiveWallet',
          params: {
            'walletId': _i1.ParameterDescription(
              name: 'walletId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['wallet'] as _i5.WalletEndpoint).archiveWallet(
            session,
            params['walletId'],
          ),
        ),
        'recalculateBalance': _i1.MethodConnector(
          name: 'recalculateBalance',
          params: {
            'walletId': _i1.ParameterDescription(
              name: 'walletId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['wallet'] as _i5.WalletEndpoint).recalculateBalance(
            session,
            params['walletId'],
          ),
        ),
        'getTotalBalance': _i1.MethodConnector(
          name: 'getTotalBalance',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['wallet'] as _i5.WalletEndpoint).getTotalBalance(
            session,
            params['userId'],
          ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _i6.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        )
      },
    );
  }
}
