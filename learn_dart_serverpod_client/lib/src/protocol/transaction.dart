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

abstract class Transaction implements _i1.SerializableModel {
  Transaction._({
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

  factory Transaction({
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
  }) = _TransactionImpl;

  factory Transaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return Transaction(
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Transaction copyWith({
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
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TransactionImpl extends Transaction {
  _TransactionImpl({
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

  /// Returns a shallow copy of this [Transaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Transaction copyWith({
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
    return Transaction(
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
