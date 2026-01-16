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

abstract class Wallet implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Wallet._({
    this.id,
    required this.userId,
    required this.name,
    required this.currency,
    required this.initialBalance,
    required this.currentBalance,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : status = status ?? 'active',
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Wallet({
    int? id,
    required int userId,
    required String name,
    required String currency,
    required double initialBalance,
    required double currentBalance,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WalletImpl;

  factory Wallet.fromJson(Map<String, dynamic> jsonSerialization) {
    return Wallet(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      currency: jsonSerialization['currency'] as String,
      initialBalance: (jsonSerialization['initialBalance'] as num).toDouble(),
      currentBalance: (jsonSerialization['currentBalance'] as num).toDouble(),
      status: jsonSerialization['status'] as String,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = WalletTable();

  static const db = WalletRepository._();

  @override
  int? id;

  int userId;

  String name;

  String currency;

  double initialBalance;

  double currentBalance;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Wallet]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Wallet copyWith({
    int? id,
    int? userId,
    String? name,
    String? currency,
    double? initialBalance,
    double? currentBalance,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'currency': currency,
      'initialBalance': initialBalance,
      'currentBalance': currentBalance,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'currency': currency,
      'initialBalance': initialBalance,
      'currentBalance': currentBalance,
      'status': status,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static WalletInclude include() {
    return WalletInclude._();
  }

  static WalletIncludeList includeList({
    _i1.WhereExpressionBuilder<WalletTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WalletTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTable>? orderByList,
    WalletInclude? include,
  }) {
    return WalletIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Wallet.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Wallet.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WalletImpl extends Wallet {
  _WalletImpl({
    int? id,
    required int userId,
    required String name,
    required String currency,
    required double initialBalance,
    required double currentBalance,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          name: name,
          currency: currency,
          initialBalance: initialBalance,
          currentBalance: currentBalance,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Wallet]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Wallet copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? currency,
    double? initialBalance,
    double? currentBalance,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Wallet(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      initialBalance: initialBalance ?? this.initialBalance,
      currentBalance: currentBalance ?? this.currentBalance,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WalletTable extends _i1.Table<int?> {
  WalletTable({super.tableRelation}) : super(tableName: 'wallets') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    currency = _i1.ColumnString(
      'currency',
      this,
    );
    initialBalance = _i1.ColumnDouble(
      'initialBalance',
      this,
    );
    currentBalance = _i1.ColumnDouble(
      'currentBalance',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
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

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString currency;

  late final _i1.ColumnDouble initialBalance;

  late final _i1.ColumnDouble currentBalance;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        name,
        currency,
        initialBalance,
        currentBalance,
        status,
        createdAt,
        updatedAt,
      ];
}

class WalletInclude extends _i1.IncludeObject {
  WalletInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Wallet.t;
}

class WalletIncludeList extends _i1.IncludeList {
  WalletIncludeList._({
    _i1.WhereExpressionBuilder<WalletTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Wallet.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Wallet.t;
}

class WalletRepository {
  const WalletRepository._();

  /// Returns a list of [Wallet]s matching the given query parameters.
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
  Future<List<Wallet>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WalletTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WalletTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Wallet>(
      where: where?.call(Wallet.t),
      orderBy: orderBy?.call(Wallet.t),
      orderByList: orderByList?.call(Wallet.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Wallet] matching the given query parameters.
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
  Future<Wallet?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WalletTable>? where,
    int? offset,
    _i1.OrderByBuilder<WalletTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WalletTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Wallet>(
      where: where?.call(Wallet.t),
      orderBy: orderBy?.call(Wallet.t),
      orderByList: orderByList?.call(Wallet.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Wallet] by its [id] or null if no such row exists.
  Future<Wallet?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Wallet>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Wallet]s in the list and returns the inserted rows.
  ///
  /// The returned [Wallet]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Wallet>> insert(
    _i1.Session session,
    List<Wallet> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Wallet>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Wallet] and returns the inserted row.
  ///
  /// The returned [Wallet] will have its `id` field set.
  Future<Wallet> insertRow(
    _i1.Session session,
    Wallet row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Wallet>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Wallet]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Wallet>> update(
    _i1.Session session,
    List<Wallet> rows, {
    _i1.ColumnSelections<WalletTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Wallet>(
      rows,
      columns: columns?.call(Wallet.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Wallet]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Wallet> updateRow(
    _i1.Session session,
    Wallet row, {
    _i1.ColumnSelections<WalletTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Wallet>(
      row,
      columns: columns?.call(Wallet.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Wallet]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Wallet>> delete(
    _i1.Session session,
    List<Wallet> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Wallet>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Wallet].
  Future<Wallet> deleteRow(
    _i1.Session session,
    Wallet row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Wallet>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Wallet>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WalletTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Wallet>(
      where: where(Wallet.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WalletTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Wallet>(
      where: where?.call(Wallet.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
