import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/serverpod_provider.dart';

/// AsyncNotifier for daily summary
class DailySummaryNotifier extends FamilyAsyncNotifier<Map<String, dynamic>, DateTime> {
  @override
  Future<Map<String, dynamic>> build(DateTime arg) async {
    final client = ref.watch(serverpodClientProvider);
    final userId = ref.watch(currentUserIdProvider);
    return await client.analytics.getDailySummary(userId, arg);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      final userId = ref.read(currentUserIdProvider);
      return await client.analytics.getDailySummary(userId, arg);
    });
  }
}

/// Provider to fetch daily analytics summary
final dailySummaryProvider = AsyncNotifierProvider.family<DailySummaryNotifier, Map<String, dynamic>, DateTime>(
  DailySummaryNotifier.new,
);

/// AsyncNotifier for weekly summary
class WeeklySummaryNotifier extends FamilyAsyncNotifier<Map<String, dynamic>, DateTime> {
  @override
  Future<Map<String, dynamic>> build(DateTime arg) async {
    final client = ref.watch(serverpodClientProvider);
    final userId = ref.watch(currentUserIdProvider);
    return await client.analytics.getWeeklySummary(userId, arg);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      final userId = ref.read(currentUserIdProvider);
      return await client.analytics.getWeeklySummary(userId, arg);
    });
  }
}

/// Provider to fetch weekly analytics summary
final weeklySummaryProvider = AsyncNotifierProvider.family<WeeklySummaryNotifier, Map<String, dynamic>, DateTime>(
  WeeklySummaryNotifier.new,
);

/// AsyncNotifier for monthly summary
class MonthlySummaryNotifier extends FamilyAsyncNotifier<Map<String, dynamic>, DateTime> {
  @override
  Future<Map<String, dynamic>> build(DateTime arg) async {
    final client = ref.watch(serverpodClientProvider);
    final userId = ref.watch(currentUserIdProvider);
    return await client.analytics.getMonthlySummary(userId, arg);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      final userId = ref.read(currentUserIdProvider);
      return await client.analytics.getMonthlySummary(userId, arg);
    });
  }
}

/// Provider to fetch monthly analytics summary
final monthlySummaryProvider = AsyncNotifierProvider.family<MonthlySummaryNotifier, Map<String, dynamic>, DateTime>(
  MonthlySummaryNotifier.new,
);

/// AsyncNotifier for yearly summary
class YearlySummaryNotifier extends FamilyAsyncNotifier<Map<String, dynamic>, DateTime> {
  @override
  Future<Map<String, dynamic>> build(DateTime arg) async {
    final client = ref.watch(serverpodClientProvider);
    final userId = ref.watch(currentUserIdProvider);
    return await client.analytics.getYearlySummary(userId, arg);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      final userId = ref.read(currentUserIdProvider);
      return await client.analytics.getYearlySummary(userId, arg);
    });
  }
}

/// Provider to fetch yearly analytics summary
final yearlySummaryProvider = AsyncNotifierProvider.family<YearlySummaryNotifier, Map<String, dynamic>, DateTime>(
  YearlySummaryNotifier.new,
);

/// AsyncNotifier for today's summary
class TodaySummaryNotifier extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    final client = ref.watch(serverpodClientProvider);
    final userId = ref.watch(currentUserIdProvider);
    return await client.analytics.getDailySummary(userId, DateTime.now());
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      final userId = ref.read(currentUserIdProvider);
      return await client.analytics.getDailySummary(userId, DateTime.now());
    });
  }
}

/// Provider for today's summary
final todaySummaryProvider = AsyncNotifierProvider<TodaySummaryNotifier, Map<String, dynamic>>(
  TodaySummaryNotifier.new,
);
