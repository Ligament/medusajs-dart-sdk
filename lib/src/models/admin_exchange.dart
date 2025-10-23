/// Canonical Admin Exchange models based on @medusajs/types v2.10.1
///
/// Provides comprehensive exchange management functionality with complete
/// API compatibility and type safety.

import 'package:json_annotation/json_annotation.dart';

// Import necessary model dependencies
import 'admin_order.dart';
import 'return.dart';

part 'admin_exchange.g.dart';

// Type aliases for canonical compliance
typedef AdminReturn = Return;

// =============================================================================
// EXCHANGE ENUMS (Canonical v2.10.1)
// =============================================================================

/// Exchange reason types as defined in @medusajs/types v2.10.1
enum ExchangeReason {
  @JsonValue('missing_item')
  missingItem,
  @JsonValue('wrong_item')
  wrongItem,
  @JsonValue('production_failure')
  productionFailure,
  @JsonValue('other')
  other,
}

// =============================================================================
// BASE EXCHANGE MODELS (Canonical v2.10.1)
// =============================================================================

/// Base exchange interface as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BaseExchange {
  /// Unique identifier for the exchange
  final String id;

  /// ID of the associated order
  final String orderId;

  /// ID of the associated return (if any)
  final String? returnId;

  /// Display ID for the exchange (human-readable)
  final int displayId;

  /// Additional items being sent to customer
  final List<BaseExchangeItem>? additionalItems;

  /// Items being returned in the exchange
  final List<BaseExchangeItem>? returnItems;

  /// Difference amount due (positive = customer owes, negative = refund due)
  final int? differenceDue;

  /// Exchange metadata for custom fields
  final Map<String, dynamic>? metadata;

  /// When the exchange was created
  final DateTime createdAt;

  /// When the exchange was last updated
  final DateTime updatedAt;

  /// When the exchange was deleted (if soft deleted)
  final DateTime? deletedAt;

  const BaseExchange({
    required this.id,
    required this.orderId,
    this.returnId,
    required this.displayId,
    this.additionalItems,
    this.returnItems,
    this.differenceDue,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory BaseExchange.fromJson(Map<String, dynamic> json) =>
      _$BaseExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$BaseExchangeToJson(this);
}

/// Base exchange item interface as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BaseExchangeItem {
  /// Unique identifier for the exchange item
  final String id;

  /// ID of the parent exchange
  final String exchangeId;

  /// ID of the order item being exchanged
  final String orderItemId;

  /// Quantity being exchanged/added
  final int quantity;

  /// Exchange metadata for this item
  final Map<String, dynamic>? metadata;

  /// When the exchange item was created
  final DateTime createdAt;

  /// When the exchange item was last updated
  final DateTime updatedAt;

  const BaseExchangeItem({
    required this.id,
    required this.exchangeId,
    required this.orderItemId,
    required this.quantity,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BaseExchangeItem.fromJson(Map<String, dynamic> json) =>
      _$BaseExchangeItemFromJson(json);

  Map<String, dynamic> toJson() => _$BaseExchangeItemToJson(this);
}

// =============================================================================
// ADMIN EXCHANGE MODELS (Canonical v2.10.1)
// =============================================================================

/// Admin exchange entity extending BaseExchange as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminExchange extends BaseExchange {
  /// Order relationship (when populated)
  final AdminOrder? order;

  /// Return relationship (when populated)
  final AdminReturn? returnObject;

  const AdminExchange({
    required super.id,
    required super.orderId,
    super.returnId,
    required super.displayId,
    super.additionalItems,
    super.returnItems,
    super.differenceDue,
    super.metadata,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
    this.order,
    this.returnObject,
  });

  factory AdminExchange.fromJson(Map<String, dynamic> json) =>
      _$AdminExchangeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminExchangeToJson(this);

  /// Check if customer owes money
  bool get customerOwesMoney => (differenceDue ?? 0) > 0;

  /// Check if store owes refund to customer
  bool get storeOwesRefund => (differenceDue ?? 0) < 0;

  /// Get absolute difference amount
  int get absoluteDifference => (differenceDue ?? 0).abs();

  /// Get total quantity of return items
  int get totalReturnQuantity {
    if (returnItems == null) return 0;
    return returnItems!.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Get total quantity of additional items
  int get totalAdditionalQuantity {
    if (additionalItems == null) return 0;
    return additionalItems!.fold(0, (sum, item) => sum + item.quantity);
  }

  /// Get formatted difference due amount
  String getFormattedDifferenceDue([String symbol = '\$']) {
    if (differenceDue == null) return '${symbol}0.00';
    return '$symbol${(differenceDue! / 100).toStringAsFixed(2)}';
  }
}

// =============================================================================
// EXCHANGE PAYLOADS (Canonical v2.10.1)
// =============================================================================

/// Create exchange payload as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateExchange {
  /// ID of the order for the exchange
  final String orderId;

  /// ID of the return (if creating exchange from existing return)
  final String? returnId;

  /// Items to be returned/exchanged
  final List<AdminCreateExchangeReturnItem>? returnItems;

  /// Additional items to be sent to customer
  final List<AdminCreateExchangeAdditionalItem>? additionalItems;

  /// Whether to allow backorders for additional items
  final bool? allowBackorder;

  /// Exchange metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateExchange({
    required this.orderId,
    this.returnId,
    this.returnItems,
    this.additionalItems,
    this.allowBackorder,
    this.metadata,
  });

  factory AdminCreateExchange.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateExchangeToJson(this);
}

/// Return item in create exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateExchangeReturnItem {
  /// ID of the order item to return
  final String orderItemId;

  /// Quantity to return
  final int quantity;

  /// Reason for the return
  final ExchangeReason? reason;

  /// Additional notes about the return
  final String? note;

  /// Item metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateExchangeReturnItem({
    required this.orderItemId,
    required this.quantity,
    this.reason,
    this.note,
    this.metadata,
  });

  factory AdminCreateExchangeReturnItem.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateExchangeReturnItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateExchangeReturnItemToJson(this);
}

/// Additional item in create exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateExchangeAdditionalItem {
  /// ID of the product variant to add
  final String variantId;

  /// Quantity to add
  final int quantity;

  /// Item metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateExchangeAdditionalItem({
    required this.variantId,
    required this.quantity,
    this.metadata,
  });

  factory AdminCreateExchangeAdditionalItem.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCreateExchangeAdditionalItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminCreateExchangeAdditionalItemToJson(this);
}

/// Add inbound items to exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddExchangeInboundItems {
  /// Items to add to the exchange (inbound)
  final List<AdminCreateExchangeReturnItem> items;

  const AdminAddExchangeInboundItems({required this.items});

  factory AdminAddExchangeInboundItems.fromJson(Map<String, dynamic> json) =>
      _$AdminAddExchangeInboundItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAddExchangeInboundItemsToJson(this);
}

/// Add outbound items to exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddExchangeOutboundItems {
  /// Items to add to the exchange (outbound)
  final List<AdminCreateExchangeAdditionalItem> items;

  const AdminAddExchangeOutboundItems({required this.items});

  factory AdminAddExchangeOutboundItems.fromJson(Map<String, dynamic> json) =>
      _$AdminAddExchangeOutboundItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAddExchangeOutboundItemsToJson(this);
}

/// Update inbound items in exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateExchangeInboundItem {
  /// New quantity for the item
  final int? quantity;

  /// Updated reason for the return
  final ExchangeReason? reason;

  /// Updated notes about the return
  final String? note;

  /// Updated item metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateExchangeInboundItem({
    this.quantity,
    this.reason,
    this.note,
    this.metadata,
  });

  factory AdminUpdateExchangeInboundItem.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateExchangeInboundItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateExchangeInboundItemToJson(this);
}

/// Update outbound items in exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateExchangeOutboundItem {
  /// New quantity for the item
  final int? quantity;

  /// Updated item metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateExchangeOutboundItem({this.quantity, this.metadata});

  factory AdminUpdateExchangeOutboundItem.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateExchangeOutboundItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpdateExchangeOutboundItemToJson(this);
}

/// Add inbound shipping method to exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddExchangeInboundShipping {
  /// ID of the shipping option for the return shipping
  final String shippingOptionId;

  /// Custom shipping price (optional)
  final int? customPrice;

  /// Shipping metadata
  final Map<String, dynamic>? metadata;

  const AdminAddExchangeInboundShipping({
    required this.shippingOptionId,
    this.customPrice,
    this.metadata,
  });

  factory AdminAddExchangeInboundShipping.fromJson(Map<String, dynamic> json) =>
      _$AdminAddExchangeInboundShippingFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminAddExchangeInboundShippingToJson(this);
}

/// Add outbound shipping method to exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddExchangeOutboundShipping {
  /// ID of the shipping option for the outbound shipping
  final String shippingOptionId;

  /// Custom shipping price (optional)
  final int? customPrice;

  /// Shipping metadata
  final Map<String, dynamic>? metadata;

  const AdminAddExchangeOutboundShipping({
    required this.shippingOptionId,
    this.customPrice,
    this.metadata,
  });

  factory AdminAddExchangeOutboundShipping.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminAddExchangeOutboundShippingFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminAddExchangeOutboundShippingToJson(this);
}

/// Update inbound shipping method in exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateExchangeInboundShipping {
  /// Updated custom shipping price
  final int? customPrice;

  /// Updated shipping metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateExchangeInboundShipping({this.customPrice, this.metadata});

  factory AdminUpdateExchangeInboundShipping.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpdateExchangeInboundShippingFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpdateExchangeInboundShippingToJson(this);
}

/// Update outbound shipping method in exchange payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateExchangeOutboundShipping {
  /// Updated custom shipping price
  final int? customPrice;

  /// Updated shipping metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateExchangeOutboundShipping({this.customPrice, this.metadata});

  factory AdminUpdateExchangeOutboundShipping.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpdateExchangeOutboundShippingFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpdateExchangeOutboundShippingToJson(this);
}

// =============================================================================
// EXCHANGE QUERY PARAMETERS (Canonical v2.10.1)
// =============================================================================

/// Exchange list query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminExchangeListParams {
  /// Query string to search exchanges
  final String? q;

  /// Filter by exchange IDs
  final List<String>? id;

  /// Filter by order ID
  final String? orderId;

  /// Filter by order IDs
  final List<String>? orderIds;

  /// Filter by region ID
  final String? regionId;

  /// Filter by region IDs
  final List<String>? regionIds;

  /// Filter by creation date range
  final DateTime? createdAtGte;
  final DateTime? createdAtLte;

  /// Filter by update date range
  final DateTime? updatedAtGte;
  final DateTime? updatedAtLte;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  /// Sort order
  final String? order;

  /// Fields to include in response
  final List<String>? fields;

  /// Relations to expand in response
  final List<String>? expand;

  const AdminExchangeListParams({
    this.q,
    this.id,
    this.orderId,
    this.orderIds,
    this.regionId,
    this.regionIds,
    this.createdAtGte,
    this.createdAtLte,
    this.updatedAtGte,
    this.updatedAtLte,
    this.limit,
    this.offset,
    this.order,
    this.fields,
    this.expand,
  });

  factory AdminExchangeListParams.fromJson(Map<String, dynamic> json) =>
      _$AdminExchangeListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminExchangeListParamsToJson(this);

  /// Convert to query parameters for API requests
  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};

    if (q != null) params['q'] = q;
    if (id != null) params['id'] = id;
    if (orderId != null) params['order_id'] = orderId;
    if (orderIds != null) params['order_id'] = orderIds;
    if (regionId != null) params['region_id'] = regionId;
    if (regionIds != null) params['region_id'] = regionIds;
    if (createdAtGte != null) {
      params['created_at'] = {'gte': createdAtGte!.toIso8601String()};
    }
    if (createdAtLte != null) {
      params['created_at'] = {
        ...?params['created_at'],
        'lte': createdAtLte!.toIso8601String(),
      };
    }
    if (updatedAtGte != null) {
      params['updated_at'] = {'gte': updatedAtGte!.toIso8601String()};
    }
    if (updatedAtLte != null) {
      params['updated_at'] = {
        ...?params['updated_at'],
        'lte': updatedAtLte!.toIso8601String(),
      };
    }
    if (limit != null) params['limit'] = limit;
    if (offset != null) params['offset'] = offset;
    if (order != null) params['order'] = order;
    if (fields != null) params['fields'] = fields!.join(',');
    if (expand != null) params['expand'] = expand!.join(',');

    return params;
  }
}

// =============================================================================
// EXCHANGE RESPONSES (Canonical v2.10.1)
// =============================================================================

/// Single exchange response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminExchangeResponse {
  /// The exchange data
  final AdminExchange exchange;

  const AdminExchangeResponse({required this.exchange});

  factory AdminExchangeResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminExchangeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminExchangeResponseToJson(this);
}

/// Multiple exchanges response with pagination
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminExchangesResponse {
  /// List of exchanges
  final List<AdminExchange> exchanges;

  /// Total count of exchanges
  final int count;

  /// Pagination offset
  final int offset;

  /// Pagination limit
  final int limit;

  const AdminExchangesResponse({
    required this.exchanges,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminExchangesResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminExchangesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminExchangesResponseToJson(this);
}

/// Exchange deletion response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminDeleteExchangeResponse {
  /// ID of the deleted exchange
  final String id;

  /// Deletion confirmation
  final bool deleted;

  const AdminDeleteExchangeResponse({required this.id, required this.deleted});

  factory AdminDeleteExchangeResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminDeleteExchangeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDeleteExchangeResponseToJson(this);
}

/// Exchange order preview response (when creating exchanges with additional items)
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminExchangeOrderPreviewResponse {
  /// The order preview showing changes
  final AdminOrder orderPreview;

  const AdminExchangeOrderPreviewResponse({required this.orderPreview});

  factory AdminExchangeOrderPreviewResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminExchangeOrderPreviewResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminExchangeOrderPreviewResponseToJson(this);
}

// =============================================================================
// ADDITIONAL REQUEST MODELS (Resource Support)
// =============================================================================

/// Update exchange request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateExchange {
  /// Allow return metadata updates
  final Map<String, dynamic>? metadata;

  const AdminUpdateExchange({this.metadata});

  factory AdminUpdateExchange.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateExchangeToJson(this);
}

/// Cancel exchange request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCancelExchange {
  /// Cancellation reason
  final String? reason;

  const AdminCancelExchange({this.reason});

  factory AdminCancelExchange.fromJson(Map<String, dynamic> json) =>
      _$AdminCancelExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCancelExchangeToJson(this);
}

/// Exchange status enum
enum AdminExchangeStatus {
  @JsonValue('requested')
  requested,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled;

  /// Get the string value for API requests
  String get value {
    switch (this) {
      case AdminExchangeStatus.requested:
        return 'requested';
      case AdminExchangeStatus.confirmed:
        return 'confirmed';
      case AdminExchangeStatus.processing:
        return 'processing';
      case AdminExchangeStatus.completed:
        return 'completed';
      case AdminExchangeStatus.cancelled:
        return 'cancelled';
    }
  }
}

/// Create exchange item request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateExchangeItem {
  /// Variant ID
  final String variantId;

  /// Quantity
  final int quantity;

  /// Unit price
  final int? unitPrice;

  /// Metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateExchangeItem({
    required this.variantId,
    required this.quantity,
    this.unitPrice,
    this.metadata,
  });

  factory AdminCreateExchangeItem.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateExchangeItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateExchangeItemToJson(this);
}

/// Create additional exchange item request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateAdditionalExchangeItem {
  /// Variant ID
  final String variantId;

  /// Quantity
  final int quantity;

  /// Unit price
  final int? unitPrice;

  const AdminCreateAdditionalExchangeItem({
    required this.variantId,
    required this.quantity,
    this.unitPrice,
  });

  factory AdminCreateAdditionalExchangeItem.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCreateAdditionalExchangeItemFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminCreateAdditionalExchangeItemToJson(this);
}

/// Process exchange payment request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminProcessExchangePayment {
  /// Payment amount
  final int amount;

  /// Currency code
  final String? currencyCode;

  const AdminProcessExchangePayment({required this.amount, this.currencyCode});

  factory AdminProcessExchangePayment.fromJson(Map<String, dynamic> json) =>
      _$AdminProcessExchangePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminProcessExchangePaymentToJson(this);
}
