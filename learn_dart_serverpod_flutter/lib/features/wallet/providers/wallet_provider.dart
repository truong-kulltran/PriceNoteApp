import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_dart_serverpod_client/learn_dart_serverpod_client.dart';
import '../../../core/providers/serverpod_provider.dart';

/// AsyncNotifier for managing wallets
class WalletsNotifier extends AsyncNotifier<List<Wallet>> {
  @override
  Future<List<Wallet>> build() async {
    final client = ref.watch(serverpodClientProvider);
    final userId = ref.watch(currentUserIdProvider);
    return await client.wallet.getWalletsByUserId(userId);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      final userId = ref.read(currentUserIdProvider);
      return await client.wallet.getWalletsByUserId(userId);
    });
  }

  Future<void> createWallet(Wallet wallet) async {
    try {
      final client = ref.read(serverpodClientProvider);
      await client.wallet.createWallet(wallet);
      await refresh();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWallet(Wallet wallet) async {
    try {
      final client = ref.read(serverpodClientProvider);
      await client.wallet.updateWallet(wallet);
      await refresh();
      ref.invalidate(walletByIdProvider(wallet.id!));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> archiveWallet(int walletId) async {
    try {
      final client = ref.read(serverpodClientProvider);
      await client.wallet.archiveWallet(walletId);
      await refresh();
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider to fetch all wallets for the current user
final walletsProvider = AsyncNotifierProvider<WalletsNotifier, List<Wallet>>(
  WalletsNotifier.new,
);

/// AsyncNotifier for wallet by ID
class WalletByIdNotifier extends FamilyAsyncNotifier<Wallet?, int> {
  @override
  Future<Wallet?> build(int arg) async {
    final client = ref.watch(serverpodClientProvider);
    return await client.wallet.getWalletById(arg);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      return await client.wallet.getWalletById(arg);
    });
  }
}

/// Provider to fetch a specific wallet by ID
final walletByIdProvider = AsyncNotifierProvider.family<WalletByIdNotifier, Wallet?, int>(
  WalletByIdNotifier.new,
);

/// Provider to calculate total balance across all wallets
final totalBalanceProvider = Provider<double>((ref) {
  final walletsAsync = ref.watch(walletsProvider);

  return walletsAsync.when(
    data: (wallets) => wallets.fold<double>(
      0,
      (sum, wallet) => sum + wallet.currentBalance,
    ),
    loading: () => 0,
    error: (_, __) => 0,
  );
});
