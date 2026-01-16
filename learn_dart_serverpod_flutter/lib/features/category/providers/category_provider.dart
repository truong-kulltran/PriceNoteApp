import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_dart_serverpod_client/learn_dart_serverpod_client.dart';
import '../../../core/providers/serverpod_provider.dart';

/// AsyncNotifier for managing categories
class CategoriesNotifier extends AsyncNotifier<List<Category>> {
  @override
  Future<List<Category>> build() async {
    final client = ref.watch(serverpodClientProvider);
    return await client.category.getAllCategories();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      return await client.category.getAllCategories();
    });
  }
}

/// Provider for all categories
final categoriesProvider = AsyncNotifierProvider<CategoriesNotifier, List<Category>>(
  CategoriesNotifier.new,
);

/// AsyncNotifier for categories by type
class CategoriesByTypeNotifier extends FamilyAsyncNotifier<List<Category>, String> {
  @override
  Future<List<Category>> build(String arg) async {
    final client = ref.watch(serverpodClientProvider);
    return await client.category.getCategoriesByType(arg);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(serverpodClientProvider);
      return await client.category.getCategoriesByType(arg);
    });
  }
}

/// Provider to fetch categories by type (income or expense)
final categoriesByTypeProvider = AsyncNotifierProvider.family<CategoriesByTypeNotifier, List<Category>, String>(
  CategoriesByTypeNotifier.new,
);

/// Provider for expense categories
final expenseCategoriesProvider = Provider<AsyncValue<List<Category>>>((ref) {
  return ref.watch(categoriesByTypeProvider('expense'));
});

/// Provider for income categories
final incomeCategoriesProvider = Provider<AsyncValue<List<Category>>>((ref) {
  return ref.watch(categoriesByTypeProvider('income'));
});
