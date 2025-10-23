/// Canonical Admin Payment models based on @medusajs/types v2.10.1
///
/// Provides comprehensive payment management functionality with complete
/// API compatibility and type safety.

import 'package:json_annotation/json_annotation.dart';

part 'admin_payment.g.dart';

// =============================================================================
// ENUMS AND STATUS TYPES
// =============================================================================

/// Payment collection status as defined in @medusajs/types v2.10.1
enum PaymentCollectionStatus {
  @JsonValue('not_paid')
  notPaid,
  @JsonValue('awaiting')
  awaiting,
  @JsonValue('authorized')
  authorized,
  @JsonValue('partially_authorized')
  partiallyAuthorized,
  @JsonValue('canceled')
  canceled,
}

/// Payment session status as defined in @medusajs/types v2.10.1
enum PaymentSessionStatus {
  @JsonValue('authorized')
  authorized,
  @JsonValue('pending')
  pending,
  @JsonValue('requires_more')
  requiresMore,
  @JsonValue('error')
  error,
  @JsonValue('canceled')
  canceled,
}

// =============================================================================
// BASE MODEL CLASSES
// =============================================================================

/// Base payment provider as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BasePaymentProvider {
  /// The provider's ID
  final String id;

  /// Whether the provider is enabled
  final bool isEnabled;

  const BasePaymentProvider({required this.id, required this.isEnabled});

  factory BasePaymentProvider.fromJson(Map<String, dynamic> json) =>
      _$BasePaymentProviderFromJson(json);

  Map<String, dynamic> toJson() => _$BasePaymentProviderToJson(this);
}

/// Admin payment provider as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentProvider extends BasePaymentProvider {
  /// The provider's display ID
  final String? displayId;

  const AdminPaymentProvider({
    required super.id,
    required super.isEnabled,
    this.displayId,
  });

  factory AdminPaymentProvider.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentProviderFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminPaymentProviderToJson(this);
}

/// Base capture as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BaseCapture {
  /// The capture's ID
  final String id;

  /// The capture amount
  final int amount;

  /// When the capture was created
  final DateTime createdAt;

  /// When the capture was created by
  final String? createdBy;

  const BaseCapture({
    required this.id,
    required this.amount,
    required this.createdAt,
    this.createdBy,
  });

  factory BaseCapture.fromJson(Map<String, dynamic> json) =>
      _$BaseCaptureFromJson(json);

  Map<String, dynamic> toJson() => _$BaseCaptureToJson(this);

  /// Get capture amount in currency's major unit
  double get amountDecimal => amount / 100.0;
}

/// Refund reason as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class RefundReason {
  /// The refund reason's ID
  final String id;

  /// The refund reason's label
  final String label;

  /// The refund reason's description
  final String? description;

  /// When the refund reason was created
  final DateTime? createdAt;

  /// When the refund reason was updated
  final DateTime? updatedAt;

  /// When the refund reason was deleted
  final DateTime? deletedAt;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const RefundReason({
    required this.id,
    required this.label,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory RefundReason.fromJson(Map<String, dynamic> json) =>
      _$RefundReasonFromJson(json);

  Map<String, dynamic> toJson() => _$RefundReasonToJson(this);
}

/// Base refund as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BaseRefund {
  /// The refund's ID
  final String id;

  /// The refund amount
  final int amount;

  /// The refund's payment ID
  final String? paymentId;

  /// When the refund was created
  final DateTime createdAt;

  /// When the refund was created by
  final String? createdBy;

  /// The refund reason ID
  final String? refundReasonId;

  /// The refund note
  final String? note;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const BaseRefund({
    required this.id,
    required this.amount,
    this.paymentId,
    required this.createdAt,
    this.createdBy,
    this.refundReasonId,
    this.note,
    this.metadata,
  });

  factory BaseRefund.fromJson(Map<String, dynamic> json) =>
      _$BaseRefundFromJson(json);

  Map<String, dynamic> toJson() => _$BaseRefundToJson(this);

  /// Get refund amount in currency's major unit
  double get amountDecimal => amount / 100.0;
}

/// Admin refund as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminRefund extends BaseRefund {
  const AdminRefund({
    required super.id,
    required super.amount,
    super.paymentId,
    required super.createdAt,
    super.createdBy,
    super.refundReasonId,
    super.note,
    super.metadata,
  });

  factory AdminRefund.fromJson(Map<String, dynamic> json) =>
      _$AdminRefundFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminRefundToJson(this);
}

/// Admin refund reason as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminRefundReason extends RefundReason {
  const AdminRefundReason({
    required super.id,
    required super.label,
    super.description,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
    super.metadata,
  });

  factory AdminRefundReason.fromJson(Map<String, dynamic> json) =>
      _$AdminRefundReasonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminRefundReasonToJson(this);
}

/// Base payment as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BasePayment {
  /// The payment's ID
  final String id;

  /// The payment amount
  final int amount;

  /// The payment's authorized amount
  final int? authorizedAmount;

  /// The payment's captured amount
  final int? capturedAmount;

  /// The payment's refunded amount
  final int? refundedAmount;

  /// The payment's currency code
  final String currencyCode;

  /// The payment's provider ID
  final String providerId;

  /// The cart ID associated with the payment
  final String? cartId;

  /// The order ID associated with the payment
  final String? orderId;

  /// The customer ID associated with the payment
  final String? customerId;

  /// When the payment was created
  final DateTime createdAt;

  /// When the payment was updated
  final DateTime? updatedAt;

  /// When the payment was captured
  final DateTime? capturedAt;

  /// When the payment was canceled
  final DateTime? canceledAt;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const BasePayment({
    required this.id,
    required this.amount,
    this.authorizedAmount,
    this.capturedAmount,
    this.refundedAmount,
    required this.currencyCode,
    required this.providerId,
    this.cartId,
    this.orderId,
    this.customerId,
    required this.createdAt,
    this.updatedAt,
    this.capturedAt,
    this.canceledAt,
    this.metadata,
  });

  factory BasePayment.fromJson(Map<String, dynamic> json) =>
      _$BasePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$BasePaymentToJson(this);

  /// Get payment amount in currency's major unit
  double get amountDecimal => amount / 100.0;

  /// Get authorized amount in currency's major unit
  double? get authorizedAmountDecimal =>
      authorizedAmount != null ? authorizedAmount! / 100.0 : null;

  /// Get captured amount in currency's major unit
  double? get capturedAmountDecimal =>
      capturedAmount != null ? capturedAmount! / 100.0 : null;

  /// Get refunded amount in currency's major unit
  double? get refundedAmountDecimal =>
      refundedAmount != null ? refundedAmount! / 100.0 : null;
}

/// Admin payment as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPayment extends BasePayment {
  /// The payment session ID
  final String? sessionId;

  /// The payment's data from the provider
  final Map<String, dynamic>? data;

  /// When the payment was authorized
  final DateTime? authorizedAt;

  const AdminPayment({
    required super.id,
    required super.amount,
    super.authorizedAmount,
    super.capturedAmount,
    super.refundedAmount,
    required super.currencyCode,
    required super.providerId,
    super.cartId,
    super.orderId,
    super.customerId,
    required super.createdAt,
    super.updatedAt,
    super.capturedAt,
    super.canceledAt,
    super.metadata,
    this.sessionId,
    this.data,
    this.authorizedAt,
  });

  factory AdminPayment.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminPaymentToJson(this);
}

/// Base payment session as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BasePaymentSession {
  /// The payment session's ID
  final String id;

  /// The payment session amount
  final int amount;

  /// The payment session's currency code
  final String currencyCode;

  /// The payment session's provider ID
  final String providerId;

  /// The payment session's status
  final PaymentSessionStatus status;

  /// The payment session's data from the provider
  final Map<String, dynamic>? data;

  /// When the payment session was created
  final DateTime createdAt;

  /// When the payment session was updated
  final DateTime? updatedAt;

  const BasePaymentSession({
    required this.id,
    required this.amount,
    required this.currencyCode,
    required this.providerId,
    required this.status,
    this.data,
    required this.createdAt,
    this.updatedAt,
  });

  factory BasePaymentSession.fromJson(Map<String, dynamic> json) =>
      _$BasePaymentSessionFromJson(json);

  Map<String, dynamic> toJson() => _$BasePaymentSessionToJson(this);

  /// Get payment session amount in currency's major unit
  double get amountDecimal => amount / 100.0;
}

/// Admin payment session as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentSession extends BasePaymentSession {
  /// The cart ID associated with the payment session
  final String? cartId;

  const AdminPaymentSession({
    required super.id,
    required super.amount,
    required super.currencyCode,
    required super.providerId,
    required super.status,
    super.data,
    required super.createdAt,
    super.updatedAt,
    this.cartId,
  });

  factory AdminPaymentSession.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentSessionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminPaymentSessionToJson(this);
}

/// Base payment collection as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class BasePaymentCollection {
  /// The payment collection's ID
  final String id;

  /// The payment collection's currency code
  final String currencyCode;

  /// The payment collection's region ID
  final String? regionId;

  /// The payment collection amount
  final int amount;

  /// The payment collection's authorized amount
  final int? authorizedAmount;

  /// The payment collection's refunded amount
  final int? refundedAmount;

  /// The payment collection's status
  final PaymentCollectionStatus status;

  /// When the payment collection was created
  final DateTime createdAt;

  /// When the payment collection was updated
  final DateTime? updatedAt;

  /// When the payment collection was completed
  final DateTime? completedAt;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const BasePaymentCollection({
    required this.id,
    required this.currencyCode,
    this.regionId,
    required this.amount,
    this.authorizedAmount,
    this.refundedAmount,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.metadata,
  });

  factory BasePaymentCollection.fromJson(Map<String, dynamic> json) =>
      _$BasePaymentCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BasePaymentCollectionToJson(this);

  /// Get payment collection amount in currency's major unit
  double get amountDecimal => amount / 100.0;

  /// Get authorized amount in currency's major unit
  double? get authorizedAmountDecimal =>
      authorizedAmount != null ? authorizedAmount! / 100.0 : null;

  /// Get refunded amount in currency's major unit
  double? get refundedAmountDecimal =>
      refundedAmount != null ? refundedAmount! / 100.0 : null;
}

/// Admin payment collection as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentCollection extends BasePaymentCollection {
  const AdminPaymentCollection({
    required super.id,
    required super.currencyCode,
    super.regionId,
    required super.amount,
    super.authorizedAmount,
    super.refundedAmount,
    required super.status,
    required super.createdAt,
    super.updatedAt,
    super.completedAt,
    super.metadata,
  });

  factory AdminPaymentCollection.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentCollectionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminPaymentCollectionToJson(this);
}

// =============================================================================
// QUERY AND FILTER MODELS
// =============================================================================

/// Admin payment provider query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminGetPaymentProvidersParams {
  /// Whether to show only enabled providers
  final bool? isEnabled;

  const AdminGetPaymentProvidersParams({this.isEnabled});

  factory AdminGetPaymentProvidersParams.fromJson(Map<String, dynamic> json) =>
      _$AdminGetPaymentProvidersParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGetPaymentProvidersParamsToJson(this);
}

/// Admin payment query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentFilters {
  /// Query or keywords to search the payment's searchable fields
  final String? q;

  /// Filter by payment ID(s)
  final List<String>? id;

  /// Filter by order ID(s)
  final List<String>? orderId;

  /// Filter by cart ID(s)
  final List<String>? cartId;

  /// Filter by customer ID(s)
  final List<String>? customerId;

  /// Filter by provider ID(s)
  final List<String>? providerId;

  /// Filter by currency code(s)
  final List<String>? currencyCode;

  /// Filter by payment status(es)
  final List<String>? status;

  /// Filter by created date
  final DateTime? createdAt;

  /// Filter by updated date
  final DateTime? updatedAt;

  /// Number of payments to skip for pagination
  final int? offset;

  /// Number of payments to return for pagination
  final int? limit;

  /// The field to sort the payments by
  final String? order;

  /// Comma-separated relations that should be expanded in the returned payments
  final List<String>? expand;

  /// Comma-separated fields that should be included in the returned payments
  final List<String>? fields;

  const AdminPaymentFilters({
    this.q,
    this.id,
    this.orderId,
    this.cartId,
    this.customerId,
    this.providerId,
    this.currencyCode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.offset,
    this.limit,
    this.order,
    this.expand,
    this.fields,
  });

  factory AdminPaymentFilters.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPaymentFiltersToJson(this);

  /// Convert filters to query parameters for API requests
  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};

    if (q != null) params['q'] = q;
    if (id != null && id!.isNotEmpty) params['id'] = id;
    if (orderId != null && orderId!.isNotEmpty) params['order_id'] = orderId;
    if (cartId != null && cartId!.isNotEmpty) params['cart_id'] = cartId;
    if (customerId != null && customerId!.isNotEmpty)
      params['customer_id'] = customerId;
    if (providerId != null && providerId!.isNotEmpty)
      params['provider_id'] = providerId;
    if (currencyCode != null && currencyCode!.isNotEmpty)
      params['currency_code'] = currencyCode;
    if (status != null && status!.isNotEmpty) params['status'] = status;
    if (createdAt != null) params['created_at'] = createdAt!.toIso8601String();
    if (updatedAt != null) params['updated_at'] = updatedAt!.toIso8601String();
    if (offset != null) params['offset'] = offset;
    if (limit != null) params['limit'] = limit;
    if (order != null) params['order'] = order;
    if (expand != null && expand!.isNotEmpty)
      params['expand'] = expand!.join(',');
    if (fields != null && fields!.isNotEmpty)
      params['fields'] = fields!.join(',');

    return params;
  }
}

/// Refund reason query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class RefundReasonFilters {
  /// Filter by refund reason ID(s)
  final List<String>? id;

  /// Query or keywords to search the refund reason's searchable fields
  final String? q;

  /// Number of refund reasons to skip for pagination
  final int? offset;

  /// Number of refund reasons to return for pagination
  final int? limit;

  /// The field to sort the refund reasons by
  final String? order;

  /// Comma-separated relations that should be expanded in the returned refund reasons
  final List<String>? expand;

  /// Comma-separated fields that should be included in the returned refund reasons
  final List<String>? fields;

  const RefundReasonFilters({
    this.id,
    this.q,
    this.offset,
    this.limit,
    this.order,
    this.expand,
    this.fields,
  });

  factory RefundReasonFilters.fromJson(Map<String, dynamic> json) =>
      _$RefundReasonFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$RefundReasonFiltersToJson(this);
}

// =============================================================================
// RESPONSE MODELS
// =============================================================================

/// Admin payment collection response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentCollectionResponse {
  /// The payment collection
  final AdminPaymentCollection paymentCollection;

  const AdminPaymentCollectionResponse({required this.paymentCollection});

  factory AdminPaymentCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPaymentCollectionResponseToJson(this);
}

/// Admin delete payment collection response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminDeletePaymentCollectionResponse {
  /// The deleted payment collection ID
  final String id;

  /// The object type (always "payment_collection")
  final String object;

  /// Whether the payment collection was deleted
  final bool deleted;

  const AdminDeletePaymentCollectionResponse({
    required this.id,
    this.object = 'payment_collection',
    this.deleted = true,
  });

  factory AdminDeletePaymentCollectionResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminDeletePaymentCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminDeletePaymentCollectionResponseToJson(this);
}

/// Admin payment collections response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentCollectionsResponse {
  /// The list of payment collections
  final List<AdminPaymentCollection> paymentCollections;

  /// Total count of payment collections
  final int? count;

  /// Number of payment collections skipped
  final int? offset;

  /// Number of payment collections returned
  final int? limit;

  const AdminPaymentCollectionsResponse({
    required this.paymentCollections,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminPaymentCollectionsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentCollectionsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminPaymentCollectionsResponseToJson(this);
}

/// Admin payment response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentResponse {
  /// The payment
  final AdminPayment payment;

  const AdminPaymentResponse({required this.payment});

  factory AdminPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPaymentResponseToJson(this);
}

/// Admin payments response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentsResponse {
  /// The list of payments
  final List<AdminPayment> payments;

  /// Total count of payments
  final int? count;

  /// Number of payments skipped
  final int? offset;

  /// Number of payments returned
  final int? limit;

  const AdminPaymentsResponse({
    required this.payments,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminPaymentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminPaymentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminPaymentsResponseToJson(this);
}

/// Admin refund response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminRefundResponse {
  /// The refund
  final AdminRefund refund;

  const AdminRefundResponse({required this.refund});

  factory AdminRefundResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminRefundResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRefundResponseToJson(this);
}

/// Admin refunds response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminRefundsResponse {
  /// The list of refunds
  final List<AdminRefund> refunds;

  /// Total count of refunds
  final int? count;

  /// Number of refunds skipped
  final int? offset;

  /// Number of refunds returned
  final int? limit;

  const AdminRefundsResponse({
    required this.refunds,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminRefundsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminRefundsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRefundsResponseToJson(this);
}

/// Refund reason response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class RefundReasonResponse {
  /// The refund reason
  final RefundReason refundReason;

  const RefundReasonResponse({required this.refundReason});

  factory RefundReasonResponse.fromJson(Map<String, dynamic> json) =>
      _$RefundReasonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefundReasonResponseToJson(this);
}

/// Refund reasons response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class RefundReasonsResponse {
  /// The list of refund reasons
  final List<RefundReason> refundReasons;

  /// Total count of refund reasons
  final int? count;

  /// Number of refund reasons skipped
  final int? offset;

  /// Number of refund reasons returned
  final int? limit;

  const RefundReasonsResponse({
    required this.refundReasons,
    this.count,
    this.offset,
    this.limit,
  });

  factory RefundReasonsResponse.fromJson(Map<String, dynamic> json) =>
      _$RefundReasonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefundReasonsResponseToJson(this);
}

/// Admin payment provider list response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminPaymentProviderListResponse {
  /// The list of payment providers
  final List<AdminPaymentProvider> paymentProviders;

  /// Total count of payment providers
  final int? count;

  /// Number of payment providers skipped
  final int? offset;

  /// Number of payment providers returned
  final int? limit;

  const AdminPaymentProviderListResponse({
    required this.paymentProviders,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminPaymentProviderListResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminPaymentProviderListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminPaymentProviderListResponseToJson(this);
}

/// Admin refund reason delete response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminRefundReasonDeleteResponse {
  /// The deleted refund reason ID
  final String id;

  /// The object type (always "refund_reason")
  final String object;

  /// Whether the refund reason was deleted
  final bool deleted;

  const AdminRefundReasonDeleteResponse({
    required this.id,
    this.object = 'refund_reason',
    this.deleted = true,
  });

  factory AdminRefundReasonDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminRefundReasonDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminRefundReasonDeleteResponseToJson(this);
}

// =============================================================================
// REQUEST MODELS
// =============================================================================

/// Request model for capturing a payment
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCapturePayment {
  /// Amount to capture in currency's smallest unit
  final int? amount;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const AdminCapturePayment({this.amount, this.metadata});

  factory AdminCapturePayment.fromJson(Map<String, dynamic> json) =>
      _$AdminCapturePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCapturePaymentToJson(this);
}

/// Request model for refunding a payment
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminRefundPayment {
  /// Amount to refund in currency's smallest unit
  final int amount;

  /// Refund reason
  final String? reason;

  /// Refund note
  final String? note;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const AdminRefundPayment({
    required this.amount,
    this.reason,
    this.note,
    this.metadata,
  });

  factory AdminRefundPayment.fromJson(Map<String, dynamic> json) =>
      _$AdminRefundPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminRefundPaymentToJson(this);
}

/// Request model for canceling a payment
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCancelPayment {
  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const AdminCancelPayment({this.metadata});

  factory AdminCancelPayment.fromJson(Map<String, dynamic> json) =>
      _$AdminCancelPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCancelPaymentToJson(this);
}

/// Request model for updating a payment
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdatePayment {
  /// Additional metadata to update
  final Map<String, dynamic>? metadata;

  const AdminUpdatePayment({this.metadata});

  factory AdminUpdatePayment.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdatePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdatePaymentToJson(this);
}

/// Request model for creating a refund reason
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateRefundReason {
  /// The refund reason label
  final String label;

  /// The refund reason description
  final String? description;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateRefundReason({
    required this.label,
    this.description,
    this.metadata,
  });

  factory AdminCreateRefundReason.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateRefundReasonFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateRefundReasonToJson(this);
}

/// Request model for updating a refund reason
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateRefundReason {
  /// The refund reason label
  final String? label;

  /// The refund reason description
  final String? description;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateRefundReason({this.label, this.description, this.metadata});

  factory AdminUpdateRefundReason.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateRefundReasonFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateRefundReasonToJson(this);
}

/// Request model for creating a payment collection
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreatePaymentCollection {
  /// The currency code for the payment collection
  final String currencyCode;

  /// The region ID for the payment collection
  final String? regionId;

  /// The amount for the payment collection
  final int amount;

  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const AdminCreatePaymentCollection({
    required this.currencyCode,
    this.regionId,
    required this.amount,
    this.metadata,
  });

  factory AdminCreatePaymentCollection.fromJson(Map<String, dynamic> json) =>
      _$AdminCreatePaymentCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreatePaymentCollectionToJson(this);
}

/// Request model for updating a payment collection
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdatePaymentCollection {
  /// Additional metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdatePaymentCollection({this.metadata});

  factory AdminUpdatePaymentCollection.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdatePaymentCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdatePaymentCollectionToJson(this);
}
