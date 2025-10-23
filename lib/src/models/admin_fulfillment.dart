/// Canonical Admin Fulfillment models based on @medusajs/types v2.10.1
///
/// Provides comprehensive fulfillment management functionality with complete
/// API compatibility and type safety.

import 'package:json_annotation/json_annotation.dart';

part 'admin_fulfillment.g.dart';

// =============================================================================
// FULFILLMENT MODELS (Canonical v2.10.1)
// =============================================================================

/// Admin fulfillment address as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentAddress {
  /// First name
  final String? firstName;

  /// Last name
  final String? lastName;

  /// Phone number
  final String? phone;

  /// Company name
  final String? company;

  /// Primary address line
  final String? address1;

  /// Secondary address line
  final String? address2;

  /// City
  final String? city;

  /// Country code
  final String? countryCode;

  /// Province or state
  final String? province;

  /// Postal code
  final String? postalCode;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const AdminFulfillmentAddress({
    this.firstName,
    this.lastName,
    this.phone,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.countryCode,
    this.province,
    this.postalCode,
    this.metadata,
  });

  factory AdminFulfillmentAddress.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentAddressFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentAddressToJson(this);
}

/// Admin fulfillment item as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentItem {
  /// The fulfillment item's ID
  final String id;

  /// The fulfillment item's title
  final String title;

  /// The fulfillment item's quantity
  final int quantity;

  /// The fulfillment item's SKU
  final String sku;

  /// The fulfillment item's barcode
  final String barcode;

  /// The ID of the associated line item in an order
  final String? lineItemId;

  /// The ID of the associated inventory item
  final String? inventoryItemId;

  /// The ID of the fulfillment that the item belongs to
  final String fulfillmentId;

  /// The date the fulfillment item was created
  final DateTime createdAt;

  /// The date the fulfillment item was updated
  final DateTime updatedAt;

  /// The date the fulfillment item was deleted
  final DateTime? deletedAt;

  const AdminFulfillmentItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.sku,
    required this.barcode,
    this.lineItemId,
    this.inventoryItemId,
    required this.fulfillmentId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminFulfillmentItem.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentItemToJson(this);
}

/// Admin fulfillment label as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentLabel {
  /// The fulfillment label's ID
  final String id;

  /// The ID of the fulfillment that the label belongs to
  final String fulfillmentId;

  /// The tracking number
  final String trackingNumber;

  /// The tracking URL for the shipment
  final String? trackingUrl;

  /// The label URL for downloading/printing
  final String? labelUrl;

  /// The date the fulfillment label was created
  final DateTime createdAt;

  /// The date the fulfillment label was updated
  final DateTime updatedAt;

  /// The date the fulfillment label was deleted
  final DateTime? deletedAt;

  const AdminFulfillmentLabel({
    required this.id,
    required this.fulfillmentId,
    required this.trackingNumber,
    this.trackingUrl,
    this.labelUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminFulfillmentLabel.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentLabelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentLabelToJson(this);
}

/// Admin fulfillment as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillment {
  /// The fulfillment's ID
  final String id;

  /// The ID of the location that the fulfillment belongs to
  final String? locationId;

  /// The fulfillment's provider ID
  final String? providerId;

  /// The date the fulfillment was packed
  final DateTime? packedAt;

  /// The date the fulfillment was shipped
  final DateTime? shippedAt;

  /// The date the fulfillment was delivered
  final DateTime? deliveredAt;

  /// The date the fulfillment was canceled
  final DateTime? canceledAt;

  /// Additional data for the fulfillment
  final Map<String, dynamic>? data;

  /// The fulfillment's delivery address
  final AdminFulfillmentAddress? deliveryAddress;

  /// The items in the fulfillment
  final List<AdminFulfillmentItem>? items;

  /// The labels attached to the fulfillment
  final List<AdminFulfillmentLabel>? labels;

  /// Whether the fulfillment requires shipping
  final bool? requiresShipping;

  /// The date the fulfillment was created
  final DateTime createdAt;

  /// The date the fulfillment was updated
  final DateTime updatedAt;

  /// The date the fulfillment was deleted
  final DateTime? deletedAt;

  /// Additional metadata for the fulfillment
  final Map<String, dynamic>? metadata;

  const AdminFulfillment({
    required this.id,
    this.locationId,
    this.providerId,
    this.packedAt,
    this.shippedAt,
    this.deliveredAt,
    this.canceledAt,
    this.data,
    this.deliveryAddress,
    this.items,
    this.labels,
    this.requiresShipping,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory AdminFulfillment.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentToJson(this);
}

// =============================================================================
// FULFILLMENT PAYLOADS (CRUD Operations)
// =============================================================================

/// Create fulfillment payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateFulfillment {
  /// The ID of the location to fulfill from
  final String? locationId;

  /// Set of items to fulfill
  final List<Map<String, dynamic>>? items;

  /// The delivery address for the fulfillment
  final AdminFulfillmentAddress? deliveryAddress;

  /// Labels to attach to the fulfillment
  final List<Map<String, dynamic>>? labels;

  /// Whether the fulfillment requires shipping
  final bool? requiresShipping;

  /// Additional metadata for the fulfillment
  final Map<String, dynamic>? metadata;

  const AdminCreateFulfillment({
    this.locationId,
    this.items,
    this.deliveryAddress,
    this.labels,
    this.requiresShipping,
    this.metadata,
  });

  factory AdminCreateFulfillment.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateFulfillmentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateFulfillmentToJson(this);
}

/// Create fulfillment shipment payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateFulfillmentShipment {
  /// Labels to attach to the shipment
  final List<Map<String, dynamic>>? labels;

  /// The delivery address for the shipment
  final AdminFulfillmentAddress? deliveryAddress;

  /// Additional metadata for the shipment
  final Map<String, dynamic>? metadata;

  const AdminCreateFulfillmentShipment({
    this.labels,
    this.deliveryAddress,
    this.metadata,
  });

  factory AdminCreateFulfillmentShipment.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateFulfillmentShipmentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateFulfillmentShipmentToJson(this);
}

/// Update fulfillment payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateFulfillment {
  /// The ID of the location to fulfill from
  final String? locationId;

  /// Additional metadata for the fulfillment
  final Map<String, dynamic>? metadata;

  const AdminUpdateFulfillment({this.locationId, this.metadata});

  factory AdminUpdateFulfillment.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateFulfillmentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateFulfillmentToJson(this);
}

/// Cancel fulfillment payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCancelFulfillment {
  /// Additional metadata for the cancellation
  final Map<String, dynamic>? metadata;

  const AdminCancelFulfillment({this.metadata});

  factory AdminCancelFulfillment.fromJson(Map<String, dynamic> json) =>
      _$AdminCancelFulfillmentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCancelFulfillmentToJson(this);
}

// =============================================================================
// FULFILLMENT QUERIES
// =============================================================================

/// Fulfillment providers query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminGetFulfillmentProvidersParams {
  /// The IDs to filter fulfillment providers by
  final List<String>? id;

  /// The location IDs to filter fulfillment providers by
  final String? locationId;

  /// Whether to filter by enabled providers only
  final bool? isEnabled;

  /// The field to sort results by
  final String? order;

  /// The limit of results to return
  final int? limit;

  /// The offset of results to return
  final int? offset;

  const AdminGetFulfillmentProvidersParams({
    this.id,
    this.locationId,
    this.isEnabled,
    this.order,
    this.limit,
    this.offset,
  });

  factory AdminGetFulfillmentProvidersParams.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminGetFulfillmentProvidersParamsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminGetFulfillmentProvidersParamsToJson(this);
}

// =============================================================================
// FULFILLMENT RESPONSES
// =============================================================================

/// Admin fulfillment response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentResponse {
  /// The fulfillment details
  final AdminFulfillment fulfillment;

  const AdminFulfillmentResponse({required this.fulfillment});

  factory AdminFulfillmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentResponseToJson(this);
}

/// Admin fulfillments list response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentsResponse {
  /// The list of fulfillments
  final List<AdminFulfillment> fulfillments;

  /// The total count of fulfillments
  final int? count;

  /// The number of fulfillments skipped
  final int? offset;

  /// The number of fulfillments returned
  final int? limit;

  const AdminFulfillmentsResponse({
    required this.fulfillments,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminFulfillmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentsResponseToJson(this);
}

/// Admin fulfillment deletion response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentDeleteResponse {
  /// The ID of the deleted fulfillment
  final String id;

  /// The type of object that was deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminFulfillmentDeleteResponse({
    required this.id,
    this.object = 'fulfillment',
    this.deleted = true,
  });

  factory AdminFulfillmentDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentDeleteResponseToJson(this);
}

// =============================================================================
// ADDITIONAL FULFILLMENT REQUEST CLASSES (Resource Support)
// =============================================================================

/// Fulfillment filters for querying
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentFilters {
  /// Order IDs to filter by
  final List<String>? orderId;

  /// Status to filter by
  final List<String>? status;

  /// Location ID to filter by
  final String? locationId;

  /// Provider ID to filter by
  final String? providerId;

  /// Date range filters
  final DateTime? createdAtGte;
  final DateTime? createdAtLte;
  final DateTime? updatedAtGte;
  final DateTime? updatedAtLte;

  const AdminFulfillmentFilters({
    this.orderId,
    this.status,
    this.locationId,
    this.providerId,
    this.createdAtGte,
    this.createdAtLte,
    this.updatedAtGte,
    this.updatedAtLte,
  });

  factory AdminFulfillmentFilters.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentFiltersToJson(this);
}

/// Ship fulfillment request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminShipFulfillment {
  /// Tracking numbers
  final List<String>? trackingNumbers;

  /// Carrier information
  final String? carrier;

  /// Metadata
  final Map<String, dynamic>? metadata;

  const AdminShipFulfillment({
    this.trackingNumbers,
    this.carrier,
    this.metadata,
  });

  factory AdminShipFulfillment.fromJson(Map<String, dynamic> json) =>
      _$AdminShipFulfillmentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminShipFulfillmentToJson(this);
}

/// Deliver fulfillment request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminDeliverFulfillment {
  /// Delivery date
  final DateTime? deliveredAt;

  /// Metadata
  final Map<String, dynamic>? metadata;

  const AdminDeliverFulfillment({this.deliveredAt, this.metadata});

  factory AdminDeliverFulfillment.fromJson(Map<String, dynamic> json) =>
      _$AdminDeliverFulfillmentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDeliverFulfillmentToJson(this);
}
