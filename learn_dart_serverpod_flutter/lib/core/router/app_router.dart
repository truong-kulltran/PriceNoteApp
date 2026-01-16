import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/wallet/presentation/pages/wallet_list_page.dart';
import '../../features/wallet/presentation/pages/wallet_detail_page.dart';
import '../../features/transaction/presentation/pages/transaction_list_page.dart';
import '../../features/transaction/presentation/pages/add_transaction_page.dart';
import '../../features/analytics/presentation/pages/analytics_page.dart';

/// App routing configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const HomePage(),
        ),
      ),
      GoRoute(
        path: '/wallets',
        name: 'wallets',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const WalletListPage(),
        ),
        routes: [
          GoRoute(
            path: ':id',
            name: 'wallet-detail',
            pageBuilder: (context, state) {
              final walletId = int.parse(state.pathParameters['id']!);
              return _buildPageWithTransition(
                context,
                state,
                WalletDetailPage(walletId: walletId),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/transactions',
        name: 'transactions',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const TransactionListPage(),
        ),
      ),
      GoRoute(
        path: '/add-transaction',
        name: 'add-transaction',
        pageBuilder: (context, state) => _buildPageWithSlideTransition(
          context,
          state,
          const AddTransactionPage(),
        ),
      ),
      GoRoute(
        path: '/analytics',
        name: 'analytics',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const AnalyticsPage(),
        ),
      ),
    ],
  );

  /// Build page with smooth fade transition
  static Page<void> _buildPageWithTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  /// Build page with slide up transition (for modals/forms)
  static Page<void> _buildPageWithSlideTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.1);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}
