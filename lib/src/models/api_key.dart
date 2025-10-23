import 'package:json_annotation/json_annotation.dart';

part 'api_key.g.dart';

/// API Key type
enum ApiKeyType {
  @JsonValue('publishable')
  publishable,
  @JsonValue('secret')
  secret,
}

/// Represents an API key in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class ApiKey {
  /// Unique identifier for the API key
  final String id;

  /// The API key token
  final String token;

  /// API key title
  final String title;

  /// API key type
  final ApiKeyType type;

  /// When the API key was last used
  final DateTime? lastUsedAt;

  /// Whether the API key is revoked
  final bool revoked;

  /// When the API key was created
  final DateTime createdAt;

  /// When the API key was last updated
  final DateTime updatedAt;

  /// When the API key was revoked (if revoked)
  final DateTime? revokedAt;

  /// User who created the API key
  final String? createdBy;

  /// User who revoked the API key
  final String? revokedBy;

  const ApiKey({
    required this.id,
    required this.token,
    required this.title,
    required this.type,
    this.lastUsedAt,
    this.revoked = false,
    required this.createdAt,
    required this.updatedAt,
    this.revokedAt,
    this.createdBy,
    this.revokedBy,
  });

  factory ApiKey.fromJson(Map<String, dynamic> json) => _$ApiKeyFromJson(json);
  Map<String, dynamic> toJson() => _$ApiKeyToJson(this);

  /// Check if API key is active
  bool get isActive => !revoked;

  /// Check if API key is publishable
  bool get isPublishable => type == ApiKeyType.publishable;

  /// Check if API key is secret
  bool get isSecret => type == ApiKeyType.secret;
}

/// Request to create an API key
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateApiKeyRequest {
  /// API key title
  final String title;

  /// API key type
  final ApiKeyType type;

  const CreateApiKeyRequest({required this.title, required this.type});

  factory CreateApiKeyRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateApiKeyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateApiKeyRequestToJson(this);
}

/// Request to update an API key
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateApiKeyRequest {
  /// API key title
  final String? title;

  const UpdateApiKeyRequest({this.title});

  factory UpdateApiKeyRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateApiKeyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateApiKeyRequestToJson(this);
}
