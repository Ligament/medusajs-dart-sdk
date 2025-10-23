/// Canonical Admin Invite models based on @medusajs/types v2.10.1
///
/// Provides invite management functionality with complete
/// API compatibility and type safety.

import 'package:json_annotation/json_annotation.dart';

part 'admin_invite.g.dart';

// =============================================================================
// INVITE MODELS (Canonical v2.10.1)
// =============================================================================

/// Admin invite as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInvite {
  /// The invite's ID
  final String id;

  /// The email of the invited user
  final String email;

  /// Whether the invite was accepted
  final bool accepted;

  /// The invite token
  final String token;

  /// The date the invite expires
  final DateTime expiresAt;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date that the invite was created
  final DateTime createdAt;

  /// The date that the invite was updated
  final DateTime updatedAt;

  const AdminInvite({
    required this.id,
    required this.email,
    required this.accepted,
    required this.token,
    required this.expiresAt,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminInvite.fromJson(Map<String, dynamic> json) =>
      _$AdminInviteFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInviteToJson(this);
}

// =============================================================================
// INVITE PAYLOADS (CRUD Operations)
// =============================================================================

/// Accept invite payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAcceptInvite {
  /// The user's email
  final String email;

  /// The user's first name
  final String firstName;

  /// The user's last name
  final String lastName;

  const AdminAcceptInvite({
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory AdminAcceptInvite.fromJson(Map<String, dynamic> json) =>
      _$AdminAcceptInviteFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAcceptInviteToJson(this);
}

/// Create invite payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateInvite {
  /// The email of the user to invite
  final String email;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  const AdminCreateInvite({required this.email, this.metadata});

  factory AdminCreateInvite.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateInviteFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateInviteToJson(this);
}

// =============================================================================
// INVITE QUERIES
// =============================================================================

/// Admin invite query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminGetInvitesParams {
  /// Query or keywords to search the invite's searchable fields
  final String? q;

  /// Filter by invite ID(s)
  final List<String>? id;

  /// Filter by email(s)
  final List<String>? email;

  /// Filter by creation date
  final Map<String, dynamic>? createdAt;

  /// Filter by update date
  final Map<String, dynamic>? updatedAt;

  /// Filter by deletion date
  final Map<String, dynamic>? deletedAt;

  /// Number of invites to skip for pagination
  final int? offset;

  /// Maximum number of invites to return
  final int? limit;

  /// Sort order for the results
  final String? order;

  /// Fields to include in the response
  final List<String>? fields;

  /// Relations to expand in the response
  final List<String>? expand;

  const AdminGetInvitesParams({
    this.q,
    this.id,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.offset,
    this.limit,
    this.order,
    this.fields,
    this.expand,
  });

  factory AdminGetInvitesParams.fromJson(Map<String, dynamic> json) =>
      _$AdminGetInvitesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGetInvitesParamsToJson(this);
}

// =============================================================================
// INVITE RESPONSES
// =============================================================================

/// Admin invite response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInviteResponse {
  /// The invite's details
  final AdminInvite invite;

  const AdminInviteResponse({required this.invite});

  factory AdminInviteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminInviteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInviteResponseToJson(this);
}

/// Admin invite list response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInviteListResponse {
  /// The list of invites
  final List<AdminInvite> invites;

  /// Total count of invites
  final int? count;

  /// Number of invites skipped
  final int? offset;

  /// Number of invites returned
  final int? limit;

  const AdminInviteListResponse({
    required this.invites,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminInviteListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminInviteListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInviteListResponseToJson(this);
}

/// Admin accept invite response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAcceptInviteResponse {
  /// The user's details (if successful)
  final Map<String, dynamic>? user;

  /// A message if an error occurs
  final String? message;

  const AdminAcceptInviteResponse({this.user, this.message});

  factory AdminAcceptInviteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminAcceptInviteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAcceptInviteResponseToJson(this);
}

/// Admin invite delete response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInviteDeleteResponse {
  /// The ID of the deleted invite
  final String id;

  /// The type of object that was deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminInviteDeleteResponse({
    required this.id,
    this.object = 'invite',
    this.deleted = true,
  });

  factory AdminInviteDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminInviteDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInviteDeleteResponseToJson(this);
}
