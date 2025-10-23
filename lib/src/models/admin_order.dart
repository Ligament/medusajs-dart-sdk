import 'package:json_annotation/json_annotation.dart';

part 'admin_order.g.dart';

/// AdminOrder model from official @medusajs/types v2.10.1
///
/// Admin-specific order model with comprehensive order management capabilities.
/// Extends BaseOrder with admin-specific fields, metadata, and relationships.
///
/// Key features:
/// - Complete order lifecycle management
/// - Payment and fulfillment tracking
/// - Customer and billing information
/// - Admin-specific metadata and status
///
/// Official Type: AdminOrder extends BaseOrder
@JsonSerializable(explicitToJson: true)
class AdminOrder {
  /// The order's ID
  final String id;

  /// The order's display ID
  @JsonKey(name: 'display_id')
  final int displayId;

  /// The order's status
  final String status; // "pending" | "completed" | "canceled" | "archived"

  /// The order's payment status
  @JsonKey(name: 'payment_status')
  final String paymentStatus; // "not_paid" | "awaiting" | "captured" | "partially_refunded" | "refunded" | "canceled"

  /// The order's fulfillment status
  @JsonKey(name: 'fulfillment_status')
  final String fulfillmentStatus; // "not_fulfilled" | "partially_fulfilled" | "fulfilled" | "partially_shipped" | "shipped" | "partially_returned" | "returned" | "canceled" | "requires_action"

  /// The order's currency code
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// The order's email
  final String? email;

  /// The customer ID
  @JsonKey(name: 'customer_id')
  final String? customerId;

  /// The sales channel ID
  @JsonKey(name: 'sales_channel_id')
  final String? salesChannelId;

  /// The region ID
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// Whether the order was placed by a guest
  @JsonKey(name: 'is_draft_order')
  final bool? isDraftOrder;

  /// The order total
  final double? total;

  /// The order subtotal
  final double? subtotal;

  /// The order tax total
  @JsonKey(name: 'tax_total')
  final double? taxTotal;

  /// The order discount total
  @JsonKey(name: 'discount_total')
  final double? discountTotal;

  /// The order shipping total
  @JsonKey(name: 'shipping_total')
  final double? shippingTotal;

  /// The date the order was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the order was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the order was canceled
  @JsonKey(name: 'canceled_at')
  final DateTime? canceledAt;

  const AdminOrder({
    required this.id,
    required this.displayId,
    required this.status,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    required this.currencyCode,
    this.email,
    this.customerId,
    this.salesChannelId,
    this.regionId,
    this.metadata,
    this.isDraftOrder,
    this.total,
    this.subtotal,
    this.taxTotal,
    this.discountTotal,
    this.shippingTotal,
    required this.createdAt,
    required this.updatedAt,
    this.canceledAt,
  });

  factory AdminOrder.fromJson(Map<String, dynamic> json) =>
      _$AdminOrderFromJson(json);

  Map<String, dynamic> toJson() => _$AdminOrderToJson(this);

  @override
  String toString() =>
      'AdminOrder(id: $id, displayId: $displayId, status: $status)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminOrder && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
