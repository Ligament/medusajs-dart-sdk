/// Canonical Admin Reservation models based on @medusajs/types v2.10.1
///
/// Provides inventory reservation management functionality with complete
/// API compatibility and type safety.

import 'package:json_annotation/json_annotation.dart';

part 'admin_reservation.g.dart';

// =============================================================================
// RESERVATION MODELS (Canonical v2.10.1)
// =============================================================================

/// Admin reservation as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReservation {
  /// The reservation's ID
  final String id;

  /// The ID of the line item that the reservation is for
  final String? lineItemId;

  /// The ID of the location that the quantity is reserved from
  final String locationId;

  /// The quantity that is reserved
  final int quantity;

  /// The ID of the reservation in an external system
  final String? externalId;

  /// The description of the reservation
  final String? description;

  /// The ID of the inventory item that the reservation is for
  final String inventoryItemId;

  /// The inventory item that the reservation is for
  final Map<String, dynamic>? inventoryItem;

  /// Custom key-value pairs that can be added to the reservation
  final Map<String, dynamic>? metadata;

  /// The ID of the user that created the reservation
  final String? createdBy;

  /// The date that the reservation was deleted
  final DateTime? deletedAt;

  /// The date that the reservation was created
  final DateTime? createdAt;

  /// The date that the reservation was updated
  final DateTime? updatedAt;

  const AdminReservation({
    required this.id,
    this.lineItemId,
    required this.locationId,
    required this.quantity,
    this.externalId,
    this.description,
    required this.inventoryItemId,
    this.inventoryItem,
    this.metadata,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminReservation.fromJson(Map<String, dynamic> json) =>
      _$AdminReservationFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReservationToJson(this);
}

// =============================================================================
// RESERVATION PAYLOADS (CRUD Operations)
// =============================================================================

/// Create reservation payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateReservation {
  /// The ID of the line item to create the reservation for
  final String? lineItemId;

  /// The ID of the location that the quantity is reserved from
  final String locationId;

  /// The ID of the inventory item that the reservation is for
  final String inventoryItemId;

  /// The quantity of the inventory item that is reserved
  final int quantity;

  /// The description of the reservation
  final String? description;

  /// Custom key-value pairs that can be added to the reservation
  final Map<String, dynamic>? metadata;

  const AdminCreateReservation({
    this.lineItemId,
    required this.locationId,
    required this.inventoryItemId,
    required this.quantity,
    this.description,
    this.metadata,
  });

  factory AdminCreateReservation.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateReservationFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateReservationToJson(this);
}

/// Update reservation payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateReservation {
  /// The ID of the location that the quantity is reserved from
  final String? locationId;

  /// The quantity of the inventory item that is reserved
  final int? quantity;

  /// The description of the reservation
  final String? description;

  /// Custom key-value pairs that can be added to the reservation
  final Map<String, dynamic>? metadata;

  const AdminUpdateReservation({
    this.locationId,
    this.quantity,
    this.description,
    this.metadata,
  });

  factory AdminUpdateReservation.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateReservationFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateReservationToJson(this);
}

// =============================================================================
// RESERVATION QUERIES
// =============================================================================

/// Admin reservation list query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminGetReservationsParams {
  /// The maximum number of reservations to retrieve
  final int? limit;

  /// The number of reservations to skip
  final int? offset;

  /// Filter by the ID(s) of the location(s) to retrieve the reservations for
  final List<String>? locationId;

  /// Filter by the ID(s) of the inventory item(s) to retrieve the reservations for
  final List<String>? inventoryItemId;

  /// Filter by the ID(s) of the line item(s) to retrieve the reservations for
  final List<String>? lineItemId;

  /// Sort the reservations by the given field
  final List<String>? orderId;

  /// Filter by the ID(s) of the user(s) to retrieve the reservations they created
  final List<String>? createdBy;

  /// Filter by reservation description(s)
  final Map<String, dynamic>? description;

  /// Apply filters on the reservation's creation date
  final Map<String, dynamic>? createdAt;

  /// Apply filters on the reservation's update date
  final Map<String, dynamic>? updatedAt;

  /// Apply filters on the reservation's deletion date
  final Map<String, dynamic>? deletedAt;

  /// Fields to include in the response
  final List<String>? fields;

  /// Relations to expand in the response
  final List<String>? expand;

  const AdminGetReservationsParams({
    this.limit,
    this.offset,
    this.locationId,
    this.inventoryItemId,
    this.lineItemId,
    this.orderId,
    this.createdBy,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.fields,
    this.expand,
  });

  factory AdminGetReservationsParams.fromJson(Map<String, dynamic> json) =>
      _$AdminGetReservationsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGetReservationsParamsToJson(this);
}

/// Admin reservation single query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReservationParams {
  /// Fields to include in the response
  final List<String>? fields;

  /// Relations to expand in the response
  final List<String>? expand;

  const AdminReservationParams({this.fields, this.expand});

  factory AdminReservationParams.fromJson(Map<String, dynamic> json) =>
      _$AdminReservationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReservationParamsToJson(this);
}

// =============================================================================
// RESERVATION RESPONSES
// =============================================================================

/// Admin reservation response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReservationResponse {
  /// The reservation's details
  final AdminReservation reservation;

  const AdminReservationResponse({required this.reservation});

  factory AdminReservationResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminReservationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReservationResponseToJson(this);
}

/// Admin reservation list response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReservationListResponse {
  /// The list of reservations
  final List<AdminReservation> reservations;

  /// Total count of reservations
  final int? count;

  /// Number of reservations skipped
  final int? offset;

  /// Number of reservations returned
  final int? limit;

  const AdminReservationListResponse({
    required this.reservations,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminReservationListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminReservationListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReservationListResponseToJson(this);
}

/// Admin reservation delete response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReservationDeleteResponse {
  /// The ID of the deleted reservation
  final String id;

  /// The type of object that was deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminReservationDeleteResponse({
    required this.id,
    this.object = 'reservation',
    this.deleted = true,
  });

  factory AdminReservationDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminReservationDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReservationDeleteResponseToJson(this);
}
