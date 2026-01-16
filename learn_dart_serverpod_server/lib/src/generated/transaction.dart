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

abstract class ExpenseTransaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ExpenseTransaction._({
    this.id,
    required this.walletId,
    required this.userId,
    required this.type,
    required this.amount,
    required this.transactionDate,
    this.categoryId,
    this.note,
    String? source,
    this.aiConfidenceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : source = source ?? 'manual',
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory ExpenseTransaction({
    int? id,
    required int walletId,
    required int userId,
    required String type,
    required double amount,
    required DateTime transactionDate,
    int? categoryId,
    String? note,
    String? source,
    double? aiConfidenceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ExpenseTransactionImpl;

  factory ExpenseTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExpenseTransaction(
      id: jsonSerialization['id'] as int?,
      walletId: jsonSerialization['walletId'] as int,
      userId: jsonSerialization['userId'] as int,
      type: jsonSerialization['type'] as String,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      transactionDate: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['transactionDate']),
      categoryId: jsonSerialization['categoryId'] as int?,
      note: jsonSerialization['note'] as String?,
      source: jsonSerialization['source'] as String,
      aiConfidenceScore:
          (jsonSerialization['aiConfidenceScore'] as num?)?.toDouble(),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ExpenseTransactionTable();

  static const db = ExpenseTransactionRepository._();

  @override
  int? id;

  int walletId;

  int userId;

  String type;

  double amount;

  DateTime transactionDate;

  int? categoryId;

  String? note;

  String source;

  double? aiConfidenceScore;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ExpenseTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExpenseTransaction copyWith({
    int? id,
    int? walletId,
    int? userId,
    String? type,
    double? amount,
    DateTime? transactionDate,
    int? categoryId,
    String? note,
    String? source,
    double? aiConfidenceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'walletId': walletId,
      'userId': userId,
      'type': type,
      'amount': amount,
      'transactionDate': transactionDate.toJson(),
      if (categoryId != null) 'categoryId': categoryId,
      if (note != null) 'note': note,
      'source': source,
      if (aiConfidenceScore != null) 'aiConfidenceScore': aiConfidenceScore,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'walletId': walletId,
      'userId': userId,
      'type': type,
      'amount': amount,
      'transactionDate': transactionDate.toJson(),
      if (categoryId != null) 'categoryId': categoryId,
      if (note != null) 'note': note,
      'source': source,
      if (aiConfidenceScore != null) 'aiConfidenceScore': aiConfidenceScore,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ExpenseTransactionInclude include() {
    return ExpenseTransactionInclude._();
  }

  static ExpenseTransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<ExpenseTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExpenseTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTransactionTable>? orderByList,
    ExpenseTransactionInclude? include,
  }) {
    return ExpenseTransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExpenseTransaction.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ExpenseTransaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExpenseTransactionImpl extends ExpenseTransaction {
  _ExpenseTransactionImpl({
    int? id,
    required int walletId,
    required int userId,
    required String type,
    required double amount,
    required DateTime transactionDate,
    int? categoryId,
    String? note,
    String? source,
    double? aiConfidenceScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          walletId: walletId,
          userId: userId,
          type: type,
          amount: amount,
          transactionDate: transactionDate,
          categoryId: categoryId,
          note: note,
          source: source,
          aiConfidenceScore: aiConfidenceScore,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ExpenseTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExpenseTransaction copyWith({
    Object? id = _Undefined,
    int? walletId,
    int? userId,
    String? type,
    double? amount,
    DateTime? transactionDate,
    Object? categoryId = _Undefined,
    Object? note = _Undefined,
    String? source,
    Object? aiConfidenceScore = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpenseTransaction(
      id: id is int? ? id : this.id,
      walletId: walletId ?? this.walletId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      transactionDate: transactionDate ?? this.transactionDate,
      categoryId: categoryId is int? ? categoryId : this.categoryId,
      note: note is String? ? note : this.note,
      source: source ?? this.source,
      aiConfidenceScore: aiConfidenceScore is double?
          ? aiConfidenceScore
          : this.aiConfidenceScore,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ExpenseTransactionTable extends _i1.Table<int?> {
  ExpenseTransactionTable({super.tableRelation})
      : super(tableName: 'transactions') {
    walletId = _i1.ColumnInt(
      'walletId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    amount = _i1.ColumnDouble(
      'amount',
      this,
    );
    transactionDate = _i1.ColumnDateTime(
      'transactionDate',
      this,
    );
    categoryId = _i1.ColumnInt(
      'categoryId',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
      hasDefault: true,
    );
    aiConfidenceScore = _i1.ColumnDouble(
      'aiConfidenceScore',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt walletId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString type;

  late final _i1.ColumnDouble amount;

  late final _i1.ColumnDateTime transactionDate;

  late final _i1.ColumnInt categoryId;

  late final _i1.ColumnString note;

  late final _i1.ColumnString source;

  late final _i1.ColumnDouble aiConfidenceScore;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        walletId,
        userId,
        type,
        amount,
        transactionDate,
        categoryId,
        note,
        source,
        aiConfidenceScore,
        createdAt,
        updatedAt,
      ];
}

class ExpenseTransactionInclude extends _i1.IncludeObject {
  ExpenseTransactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ExpenseTransaction.t;
}

class ExpenseTransactionIncludeList extends _i1.IncludeList {
  ExpenseTransactionIncludeList._({
    _i1.WhereExpressionBuilder<ExpenseTransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExpenseTransaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ExpenseTransaction.t;
}

class ExpenseTransactionRepository {
  const ExpenseTransactionRepository._();

  /// Returns a list of [ExpenseTransaction]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ExpenseTransaction>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExpenseTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExpenseTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ExpenseTransaction>(
      where: where?.call(ExpenseTransaction.t),
      orderBy: orderBy?.call(ExpenseTransaction.t),
      orderByList: orderByList?.call(ExpenseTransaction.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ExpenseTransaction] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ExpenseTransaction?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExpenseTransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExpenseTransactionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExpenseTransactionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ExpenseTransaction>(
      where: where?.call(ExpenseTransaction.t),
      orderBy: orderBy?.call(ExpenseTransaction.t),
      orderByList: orderByList?.call(ExpenseTransaction.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ExpenseTransaction] by its [id] or null if no such row exists.
  Future<ExpenseTransaction?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ExpenseTransaction>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ExpenseTransaction]s in the list and returns the inserted rows.
  ///
  /// The returned [ExpenseTransaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ExpenseTransaction>> insert(
    _i1.Session session,
    List<ExpenseTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ExpenseTransaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ExpenseTransaction] and returns the inserted row.
  ///
  /// The returned [ExpenseTransaction] will have its `id` field set.
  Future<ExpenseTransaction> insertRow(
    _i1.Session session,
    ExpenseTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExpenseTransaction>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ExpenseTransaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ExpenseTransaction>> update(
    _i1.Session session,
    List<ExpenseTransaction> rows, {
    _i1.ColumnSelections<ExpenseTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ExpenseTransaction>(
      rows,
      columns: columns?.call(ExpenseTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExpenseTransaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExpenseTransaction> updateRow(
    _i1.Session session,
    ExpenseTransaction row, {
    _i1.ColumnSelections<ExpenseTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExpenseTransaction>(
      row,
      columns: columns?.call(ExpenseTransaction.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ExpenseTransaction]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ExpenseTransaction>> delete(
    _i1.Session session,
    List<ExpenseTransaction> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ExpenseTransaction>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ExpenseTransaction].
  Future<ExpenseTransaction> deleteRow(
    _i1.Session session,
    ExpenseTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExpenseTransaction>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ExpenseTransaction>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExpenseTransactionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ExpenseTransaction>(
      where: where(ExpenseTransaction.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExpenseTransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ExpenseTransaction>(
      where: where?.call(ExpenseTransaction.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
