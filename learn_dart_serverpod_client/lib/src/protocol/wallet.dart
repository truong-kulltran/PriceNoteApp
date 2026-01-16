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

abstract class Wallet implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String name;

  String currency;

  double initialBalance;

  double currentBalance;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

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
