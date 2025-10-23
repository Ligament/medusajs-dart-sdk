// admin_return.dart
// AdminReturn canonical model - Complete implementation based on @medusajs/types v2.10.1

import 'package:json_annotation/json_annotation.dart';

part 'admin_return.g.dart';

/// Return status enumeration
enum ReturnStatus {
  @JsonValue('requested')
  requested,
  @JsonValue('received')
  received,
  @JsonValue('partially_received')
  partiallyReceived,
  @JsonValue('canceled')
  canceled,
}

/// Base return item interface
@JsonSerializable(fieldRename: FieldRename.snake)
class BaseReturnItem {
  /// The ID of the return item
  final String id;

  /// The quantity of the item to return
  final int quantity;

  /// The received quantity of the return item
  final int? receivedQuantity;

  /// The damaged quantity of the return item
  final int? damagedQuantity;

  /// The ID of the return reason
  final String? reasonId;

  /// Note describing the return item
  final String? note;

  /// The ID of the associated line item
  final String itemId;

  /// The ID of the associated return
  final String returnId;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  /// When the return item was created
  final DateTime? createdAt;

  /// When the return item was updated
  final DateTime? updatedAt;

  const BaseReturnItem({
    required this.id,
    required this.quantity,
    this.receivedQuantity,
    this.damagedQuantity,
    this.reasonId,
    this.note,
    required this.itemId,
    required this.returnId,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory BaseReturnItem.fromJson(Map<String, dynamic> json) =>
      _$BaseReturnItemFromJson(json);

  Map<String, dynamic> toJson() => _$BaseReturnItemToJson(this);
}

/// Admin return item interface extending BaseReturnItem
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReturnItem extends BaseReturnItem {
  const AdminReturnItem({
    required super.id,
    required super.quantity,
    super.receivedQuantity,
    super.damagedQuantity,
    super.reasonId,
    super.note,
    required super.itemId,
    required super.returnId,
    super.metadata,
    super.createdAt,
    super.updatedAt,
  });

  factory AdminReturnItem.fromJson(Map<String, dynamic> json) =>
      _$AdminReturnItemFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminReturnItemToJson(this);
}

/// Base return interface
@JsonSerializable(fieldRename: FieldRename.snake)
class BaseReturn {
  /// The ID of the return
  final String id;

  /// The associated order's ID
  final String orderId;

  /// The status of the return
  final ReturnStatus status;

  /// The associated exchange's ID
  final String? exchangeId;

  /// The ID of the location to return items to
  final String? locationId;

  /// The associated claim's ID
  final String? claimId;

  /// The version of the order when the return is applied
  final int? orderVersion;

  /// The return's display ID
  final int? displayId;

  /// Whether customer should receive notifications
  final bool? noNotification;

  /// The refund amount of the return
  final num? refundAmount;

  /// The items of the return
  final List<BaseReturnItem> items;

  /// When the return was received
  final DateTime? receivedAt;

  /// When the return was created
  final DateTime? createdAt;

  /// When the return was canceled
  final DateTime? canceledAt;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  /// When the return was updated
  final DateTime? updatedAt;

  /// When the return was deleted
  final DateTime? deletedAt;

  /// When the return was requested
  final DateTime? requestedAt;

  const BaseReturn({
    required this.id,
    required this.orderId,
    required this.status,
    this.exchangeId,
    this.locationId,
    this.claimId,
    this.orderVersion,
    this.displayId,
    this.noNotification,
    this.refundAmount,
    required this.items,
    this.receivedAt,
    this.createdAt,
    this.canceledAt,
    this.metadata,
    this.updatedAt,
    this.deletedAt,
    this.requestedAt,
  });

  factory BaseReturn.fromJson(Map<String, dynamic> json) =>
      _$BaseReturnFromJson(json);

  Map<String, dynamic> toJson() => _$BaseReturnToJson(this);
}

/// Admin return interface extending BaseReturn
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReturn extends BaseReturn {
  /// The return's items (AdminReturnItem type)
  @override
  @JsonKey(name: 'items')
  final List<AdminReturnItem> items;

  const AdminReturn({
    required super.id,
    required super.orderId,
    required super.status,
    super.exchangeId,
    super.locationId,
    super.claimId,
    super.orderVersion,
    super.displayId,
    super.noNotification,
    super.refundAmount,
    required this.items,
    super.receivedAt,
    super.createdAt,
    super.canceledAt,
    super.metadata,
    super.updatedAt,
    super.deletedAt,
    super.requestedAt,
  }) : super(items: items);

  factory AdminReturn.fromJson(Map<String, dynamic> json) =>
      _$AdminReturnFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminReturnToJson(this);
}

// Query Parameters

/// Admin return filters for list operations
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReturnFilters {
  /// Filter by return ID(s)
  final List<String>? id;

  /// Filter by order ID(s) to retrieve their returns
  final List<String>? orderId;

  /// Filter by status
  final List<String>? status;

  /// Filter by created date
  final String? createdAt;

  /// Filter by updated date
  final String? updatedAt;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Fields to expand in response
  final List<String>? expand;

  /// Fields to select in response
  final List<String>? fields;

  const AdminReturnFilters({
    this.id,
    this.orderId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.limit,
    this.offset,
    this.expand,
    this.fields,
  });

  factory AdminReturnFilters.fromJson(Map<String, dynamic> json) =>
      _$AdminReturnFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReturnFiltersToJson(this);
}

// Create/Update Payloads

/// Admin initiate return request payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInitiateReturnRequest {
  /// The ID of the order that the return belongs to
  final String orderId;

  /// The ID of the stock location to return items to
  final String? locationId;

  /// The return's description
  final String? description;

  /// Admin-only note describing the return
  final String? internalNote;

  /// Whether to send notifications to customer
  final bool? noNotification;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminInitiateReturnRequest({
    required this.orderId,
    this.locationId,
    this.description,
    this.internalNote,
    this.noNotification,
    this.metadata,
  });

  factory AdminInitiateReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminInitiateReturnRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInitiateReturnRequestToJson(this);
}

/// Admin add return item payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddReturnItem {
  /// The ID of the order item to add to return
  final String id;

  /// The quantity of the item to return
  final int quantity;

  /// Description of why item is being returned
  final String? description;

  /// Admin-only note describing return item
  final String? internalNote;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminAddReturnItem({
    required this.id,
    required this.quantity,
    this.description,
    this.internalNote,
    this.metadata,
  });

  factory AdminAddReturnItem.fromJson(Map<String, dynamic> json) =>
      _$AdminAddReturnItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAddReturnItemToJson(this);
}

/// Admin add return items payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddReturnItems {
  /// Items to add to return
  final List<AdminAddReturnItem> items;

  const AdminAddReturnItems({required this.items});

  factory AdminAddReturnItems.fromJson(Map<String, dynamic> json) =>
      _$AdminAddReturnItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAddReturnItemsToJson(this);
}

/// Admin update return items payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateReturnItems {
  /// The quantity of the item to return
  final int? quantity;

  /// Admin-only note describing return item
  final String? internalNote;

  /// The ID of the return reason
  final String? reasonId;

  const AdminUpdateReturnItems({
    this.quantity,
    this.internalNote,
    this.reasonId,
  });

  factory AdminUpdateReturnItems.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateReturnItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateReturnItemsToJson(this);
}

/// Admin add return shipping payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddReturnShipping {
  /// The ID of the shipping option
  final String shippingOptionId;

  /// Custom amount for shipping method
  final num? customAmount;

  /// Description of shipping method
  final String? description;

  /// Admin-only note for shipping method
  final String? internalNote;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminAddReturnShipping({
    required this.shippingOptionId,
    this.customAmount,
    this.description,
    this.internalNote,
    this.metadata,
  });

  factory AdminAddReturnShipping.fromJson(Map<String, dynamic> json) =>
      _$AdminAddReturnShippingFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAddReturnShippingToJson(this);
}

/// Admin update return shipping payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateReturnShipping {
  /// Custom amount for shipping method
  final num? customAmount;

  /// Admin-only note for shipping method
  final String? internalNote;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateReturnShipping({
    this.customAmount,
    this.internalNote,
    this.metadata,
  });

  factory AdminUpdateReturnShipping.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateReturnShippingFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateReturnShippingToJson(this);
}

/// Admin confirm return request payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminConfirmReturnRequest {
  /// Whether to send notifications to customer
  final bool? noNotification;

  const AdminConfirmReturnRequest({this.noNotification});

  factory AdminConfirmReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminConfirmReturnRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminConfirmReturnRequestToJson(this);
}

/// Admin update return request payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateReturnRequest {
  /// The ID of the stock location to return items to
  final String? locationId;

  /// Whether to send notifications to customer
  final bool? noNotification;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateReturnRequest({
    this.locationId,
    this.noNotification,
    this.metadata,
  });

  factory AdminUpdateReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateReturnRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateReturnRequestToJson(this);
}

/// Admin confirm receive return payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminConfirmReceiveReturn {
  /// Whether to send notifications to customer
  final bool? noNotification;

  const AdminConfirmReceiveReturn({this.noNotification});

  factory AdminConfirmReceiveReturn.fromJson(Map<String, dynamic> json) =>
      _$AdminConfirmReceiveReturnFromJson(json);

  Map<String, dynamic> toJson() => _$AdminConfirmReceiveReturnToJson(this);
}

/// Admin initiate receive return payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminInitiateReceiveReturn {
  /// Admin-only note describing the return
  final String? internalNote;

  /// Description of the return
  final String? description;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminInitiateReceiveReturn({
    this.internalNote,
    this.description,
    this.metadata,
  });

  factory AdminInitiateReceiveReturn.fromJson(Map<String, dynamic> json) =>
      _$AdminInitiateReceiveReturnFromJson(json);

  Map<String, dynamic> toJson() => _$AdminInitiateReceiveReturnToJson(this);
}

/// Received item details
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReceiveReturnItem {
  /// The ID of the received item
  final String id;

  /// The received quantity of the item
  final int quantity;

  /// Admin-only note describing received item
  final String? internalNote;

  const AdminReceiveReturnItem({
    required this.id,
    required this.quantity,
    this.internalNote,
  });

  factory AdminReceiveReturnItem.fromJson(Map<String, dynamic> json) =>
      _$AdminReceiveReturnItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReceiveReturnItemToJson(this);
}

/// Admin receive items payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReceiveItems {
  /// The received items in the return
  final List<AdminReceiveReturnItem> items;

  const AdminReceiveItems({required this.items});

  factory AdminReceiveItems.fromJson(Map<String, dynamic> json) =>
      _$AdminReceiveItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReceiveItemsToJson(this);
}

/// Dismissed item details
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminDismissReturnItem {
  /// The ID of the item to dismiss
  final String id;

  /// The quantity of the item that is damaged
  final int quantity;

  /// Admin-only note describing damaged item
  final String? internalNote;

  const AdminDismissReturnItem({
    required this.id,
    required this.quantity,
    this.internalNote,
  });

  factory AdminDismissReturnItem.fromJson(Map<String, dynamic> json) =>
      _$AdminDismissReturnItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDismissReturnItemToJson(this);
}

/// Admin dismiss items payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminDismissItems {
  /// The damaged items to add to the return
  final List<AdminDismissReturnItem> items;

  const AdminDismissItems({required this.items});

  factory AdminDismissItems.fromJson(Map<String, dynamic> json) =>
      _$AdminDismissItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDismissItemsToJson(this);
}

/// Admin update receive items payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateReceiveItems {
  /// The received quantity of the item
  final int? quantity;

  /// Admin-only note describing received item
  final String? internalNote;

  /// The ID of the return reason
  final String? reasonId;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateReceiveItems({
    this.quantity,
    this.internalNote,
    this.reasonId,
    this.metadata,
  });

  factory AdminUpdateReceiveItems.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateReceiveItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateReceiveItemsToJson(this);
}

/// Admin update dismiss items payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateDismissItems {
  /// The quantity of the item that is damaged
  final int? quantity;

  /// Admin-only note
  final String? internalNote;

  /// The ID of the return reason
  final String? reasonId;

  /// Custom metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateDismissItems({
    this.quantity,
    this.internalNote,
    this.reasonId,
    this.metadata,
  });

  factory AdminUpdateDismissItems.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateDismissItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateDismissItemsToJson(this);
}

// Response Types

/// Admin return response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReturnResponse {
  /// The return's details
  @JsonKey(name: 'return')
  final AdminReturn returnData;

  const AdminReturnResponse({required this.returnData});

  factory AdminReturnResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminReturnResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReturnResponseToJson(this);
}

/// Admin returns list response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReturnsResponse {
  /// The list of returns
  final List<AdminReturn> returns;

  /// Total count
  final int? count;

  /// Pagination offset
  final int? offset;

  /// Pagination limit
  final int? limit;

  const AdminReturnsResponse({
    required this.returns,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminReturnsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminReturnsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReturnsResponseToJson(this);
}

/// Admin order return response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminOrderReturnResponse {
  /// The order details
  final Map<String, dynamic> order;

  /// The return details
  @JsonKey(name: 'return')
  final AdminReturn returnData;

  const AdminOrderReturnResponse({
    required this.order,
    required this.returnData,
  });

  factory AdminOrderReturnResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminOrderReturnResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminOrderReturnResponseToJson(this);
}

/// Admin return preview response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReturnPreviewResponse {
  /// The order preview
  final Map<String, dynamic> orderPreview;

  /// The return details
  @JsonKey(name: 'return')
  final AdminReturn returnData;

  const AdminReturnPreviewResponse({
    required this.orderPreview,
    required this.returnData,
  });

  factory AdminReturnPreviewResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminReturnPreviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReturnPreviewResponseToJson(this);
}

/// Admin return delete response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminReturnDeleteResponse {
  /// The ID of the deleted return
  final String id;

  /// The object type
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminReturnDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminReturnDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminReturnDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminReturnDeleteResponseToJson(this);
}
