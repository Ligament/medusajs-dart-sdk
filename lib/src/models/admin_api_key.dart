// admin_api_key.dart
// AdminApiKey canonical model - Complete implementation based on @medusajs/types v2.10.1

import 'package:json_annotation/json_annotation.dart';

part 'admin_api_key.g.dart';

/// API key type enumeration
enum ApiKeyType {
  @JsonValue('secret')
  secret,
  @JsonValue('publishable')
  publishable,
}

/// Admin API key entity
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminApiKey {
  /// The API key's ID
  final String id;

  /// The API key's token
  final String token;

  /// The redacted form of the token, useful for displaying the API key
  final String redacted;

  /// The API key's title
  final String title;

  /// The API key's type
  final ApiKeyType type;

  /// The date the API key was last used
  final DateTime? lastUsedAt;

  /// The ID of the user that created the API key
  final String createdBy;

  /// The date the API key was created
  final DateTime createdAt;

  /// The date the API key was updated
  final DateTime updatedAt;

  /// The ID of the user that revoked the API key
  final String? revokedBy;

  /// The date the API key was revoked
  final DateTime? revokedAt;

  /// The date the API key was deleted
  final DateTime? deletedAt;

  const AdminApiKey({
    required this.id,
    required this.token,
    required this.redacted,
    required this.title,
    required this.type,
    this.lastUsedAt,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.revokedBy,
    this.revokedAt,
    this.deletedAt,
  });

  factory AdminApiKey.fromJson(Map<String, dynamic> json) =>
      _$AdminApiKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AdminApiKeyToJson(this);
}

// Query Parameters

/// Admin get API keys parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminGetApiKeysParams {
  /// Query or keywords to search the API key's searchable fields
  final String? q;

  /// Filter by API key ID(s)
  final List<String>? id;

  /// Filter by title(s)
  final List<String>? title;

  /// Filter by token(s)
  final List<String>? token;

  /// Filter by type
  final ApiKeyType? type;

  /// Apply filters on the API key's creation date
  final Map<String, dynamic>? createdAt;

  /// Apply filters on the API key's update date
  final Map<String, dynamic>? updatedAt;

  /// Apply filters on the API key's deletion date
  final Map<String, dynamic>? deletedAt;

  /// Apply filters on the API key's revocation date
  final Map<String, dynamic>? revokedAt;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminGetApiKeysParams({
    this.q,
    this.id,
    this.title,
    this.token,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.revokedAt,
    this.limit,
    this.offset,
    this.expand,
    this.fields,
  });

  factory AdminGetApiKeysParams.fromJson(Map<String, dynamic> json) =>
      _$AdminGetApiKeysParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGetApiKeysParamsToJson(this);
}

// Payload Types

/// Admin create API key payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateApiKey {
  /// The API key's title
  final String title;

  /// The API key's type
  final ApiKeyType type;

  const AdminCreateApiKey({required this.title, required this.type});

  factory AdminCreateApiKey.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateApiKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateApiKeyToJson(this);
}

/// Admin update API key payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateApiKey {
  /// The API key's title
  final String title;

  const AdminUpdateApiKey({required this.title});

  factory AdminUpdateApiKey.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateApiKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateApiKeyToJson(this);
}

/// Admin revoke API key payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminRevokeApiKey {
  /// Revoke the API key after the specified number of seconds
  final int? revokeIn;

  const AdminRevokeApiKey({this.revokeIn});

  factory AdminRevokeApiKey.fromJson(Map<String, dynamic> json) =>
      _$AdminRevokeApiKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRevokeApiKeyToJson(this);
}

// Response Types

/// Admin API key response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminApiKeyResponse {
  /// The API key's details
  final AdminApiKey apiKey;

  const AdminApiKeyResponse({required this.apiKey});

  factory AdminApiKeyResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminApiKeyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminApiKeyResponseToJson(this);
}

/// Admin API key list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminApiKeyListResponse {
  /// The list of API keys
  final List<AdminApiKey> apiKeys;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminApiKeyListResponse({
    required this.apiKeys,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminApiKeyListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminApiKeyListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminApiKeyListResponseToJson(this);
}

/// Admin API key delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminApiKeyDeleteResponse {
  /// The ID of the deleted API key
  final String id;

  /// The type of object that was deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminApiKeyDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminApiKeyDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminApiKeyDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminApiKeyDeleteResponseToJson(this);
}
