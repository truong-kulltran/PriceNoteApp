import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class CategoryEndpoint extends Endpoint {
  /// Create a new category
  Future<Category> createCategory(Session session, Category category) async {
    if (category.name.isEmpty) {
      throw Exception('Category name cannot be empty');
    }
    if (category.type != 'income' && category.type != 'expense') {
      throw Exception('Category type must be either income or expense');
    }

    return await Category.db.insertRow(session, category);
  }

  /// Get all categories
  Future<List<Category>> getAllCategories(Session session) async {
    return await Category.db.find(
      session,
      orderBy: (t) => t.name,
    );
  }

  /// Get categories by type (income or expense)
  Future<List<Category>> getCategoriesByType(
    Session session,
    String type,
  ) async {
    return await Category.db.find(
      session,
      where: (t) => t.type.equals(type),
      orderBy: (t) => t.name,
    );
  }

  /// Get a single category by ID
  Future<Category?> getCategoryById(Session session, int categoryId) async {
    return await Category.db.findById(session, categoryId);
  }

  /// Update category
  Future<Category> updateCategory(Session session, Category category) async {
    if (category.name.isEmpty) {
      throw Exception('Category name cannot be empty');
    }

    return await Category.db.updateRow(session, category);
  }

  /// Delete category
  Future<void> deleteCategory(Session session, int categoryId) async {
    final category = await Category.db.findById(session, categoryId);
    if (category == null) {
      throw Exception('Category not found');
    }

    // Check if category is used in any transactions
    final transactions = await ExpenseTransaction.db.find(
      session,
      where: (t) => t.categoryId.equals(categoryId),
      limit: 1,
    );

    if (transactions.isNotEmpty) {
      throw Exception(
        'Cannot delete category that is used in transactions',
      );
    }

    await Category.db.deleteRow(session, category);
  }

  /// Initialize default categories
  Future<List<Category>> initializeDefaultCategories(Session session) async {
    final defaultCategories = [
      Category(name: 'Food', type: 'expense', icon: '🍔', color: '#FF6B6B'),
      Category(name: 'Transport', type: 'expense', icon: '🚗', color: '#4ECDC4'),
      Category(name: 'Utilities', type: 'expense', icon: '💡', color: '#45B7D1'),
      Category(name: 'Entertainment', type: 'expense', icon: '🎬', color: '#FFA07A'),
      Category(name: 'Shopping', type: 'expense', icon: '🛍️', color: '#FFD93D'),
      Category(name: 'Health', type: 'expense', icon: '💊', color: '#6BCB77'),
      Category(name: 'Education', type: 'expense', icon: '📚', color: '#A8E6CF'),
      Category(name: 'Other', type: 'expense', icon: '📦', color: '#95A5A6'),
      Category(name: 'Salary', type: 'income', icon: '💰', color: '#2ECC71'),
      Category(name: 'Investment', type: 'income', icon: '📈', color: '#3498DB'),
      Category(name: 'Gift', type: 'income', icon: '🎁', color: '#9B59B6'),
      Category(name: 'Other Income', type: 'income', icon: '💵', color: '#1ABC9C'),
    ];

    List<Category> created = [];
    for (var category in defaultCategories) {
      try {
        final existing = await Category.db.find(
          session,
          where: (t) => t.name.equals(category.name),
          limit: 1,
        );

        if (existing.isEmpty) {
          final createdCategory = await Category.db.insertRow(
            session,
            category,
          );
          created.add(createdCategory);
        }
      } catch (e) {
        // Skip if category already exists
        continue;
      }
    }

    return created;
  }
}
