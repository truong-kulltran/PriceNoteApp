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

abstract class Category implements _i1.SerializableModel {
  Category._({
    this.id,
    required this.name,
    required this.type,
    this.icon,
    this.color,
    bool? isDefault,
  }) : isDefault = isDefault ?? true;

  factory Category({
    int? id,
    required String name,
    required String type,
    String? icon,
    String? color,
    bool? isDefault,
  }) = _CategoryImpl;

  factory Category.fromJson(Map<String, dynamic> jsonSerialization) {
    return Category(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      icon: jsonSerialization['icon'] as String?,
      color: jsonSerialization['color'] as String?,
      isDefault: jsonSerialization['isDefault'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String type;

  String? icon;

  String? color;

  bool isDefault;

  /// Returns a shallow copy of this [Category]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Category copyWith({
    int? id,
    String? name,
    String? type,
    String? icon,
    String? color,
    bool? isDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      'isDefault': isDefault,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CategoryImpl extends Category {
  _CategoryImpl({
    int? id,
    required String name,
    required String type,
    String? icon,
    String? color,
    bool? isDefault,
  }) : super._(
          id: id,
          name: name,
          type: type,
          icon: icon,
          color: color,
          isDefault: isDefault,
        );

  /// Returns a shallow copy of this [Category]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Category copyWith({
    Object? id = _Undefined,
    String? name,
    String? type,
    Object? icon = _Undefined,
    Object? color = _Undefined,
    bool? isDefault,
  }) {
    return Category(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon is String? ? icon : this.icon,
      color: color is String? ? color : this.color,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
