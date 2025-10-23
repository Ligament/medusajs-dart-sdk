// admin_user.dart
// AdminUser canonical model - Complete implementation based on @medusajs/types v2.10.1

import 'package:json_annotation/json_annotation.dart';

part 'admin_user.g.dart';

/// Admin user entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUser {
  /// The user's ID
  final String id;

  /// The user's email
  final String email;

  /// The user's first name
  final String? firstName;

  /// The user's last name
  final String? lastName;

  /// The URL of the user's avatar image
  final String? avatarUrl;

  /// Custom key-value pairs that can be added to the user
  final Map<String, dynamic>? metadata;

  /// The date the user was created
  final DateTime createdAt;

  /// The date the user was updated
  final DateTime updatedAt;

  /// The date the user was deleted
  final DateTime? deletedAt;

  const AdminUser({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserToJson(this);
}

// Query Parameters

/// Admin user list parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUserListParams {
  /// Query or keywords to search the user's searchable fields
  final String? q;

  /// Filter by user ID(s)
  final List<String>? id;

  /// Filter by email(s)
  final String? email;

  /// Filter by first name(s)
  final String? firstName;

  /// Filter by last name(s)
  final String? lastName;

  /// Filter by the date the user was created
  final Map<String, dynamic>? createdAt;

  /// Filter by the date the user was updated
  final Map<String, dynamic>? updatedAt;

  /// Filter by the date the user was deleted
  final Map<String, dynamic>? deletedAt;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminUserListParams({
    this.q,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.limit,
    this.offset,
    this.expand,
    this.fields,
  });

  factory AdminUserListParams.fromJson(Map<String, dynamic> json) =>
      _$AdminUserListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserListParamsToJson(this);
}

/// Admin user parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUserParams {
  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminUserParams({this.expand, this.fields});

  factory AdminUserParams.fromJson(Map<String, dynamic> json) =>
      _$AdminUserParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserParamsToJson(this);
}

// Payload Types

/// Admin create user payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateUser {
  /// The user's email
  final String email;

  /// The first name of the user
  final String? firstName;

  /// The last name of the user
  final String? lastName;

  /// The URL of the user's avatar image
  final String? avatarUrl;

  const AdminCreateUser({
    required this.email,
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  factory AdminCreateUser.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateUserFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateUserToJson(this);
}

/// Admin update user payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateUser {
  /// The first name of the user
  final String? firstName;

  /// The last name of the user
  final String? lastName;

  /// The URL of the user's avatar image
  final String? avatarUrl;

  /// Custom key-value pairs that can be added to the user
  final Map<String, dynamic>? metadata;

  const AdminUpdateUser({
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.metadata,
  });

  factory AdminUpdateUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateUserFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateUserToJson(this);
}

// Response Types

/// Admin user response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUserResponse {
  /// The user's details
  final AdminUser user;

  const AdminUserResponse({required this.user});

  factory AdminUserResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserResponseToJson(this);
}

/// Admin user list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUserListResponse {
  /// The list of users
  final List<AdminUser> users;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminUserListResponse({
    required this.users,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminUserListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminUserListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserListResponseToJson(this);
}

/// Admin user delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUserDeleteResponse {
  /// The ID of the deleted user
  final String id;

  /// The type of object that was deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminUserDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminUserDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminUserDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserDeleteResponseToJson(this);
}
