import 'package:json_annotation/json_annotation.dart';

part 'common.g.dart';

/// Paginated response wrapper for API responses
@JsonSerializable(
  genericArgumentFactories: true,
  fieldRename: FieldRename.snake,
)
class PaginatedResponse<T> {
  /// The data items for this page
  final List<T> data;

  /// Total number of items across all pages
  final int count;

  /// Current page offset
  final int offset;

  /// Number of items per page
  final int limit;

  const PaginatedResponse({
    required this.data,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);

  /// Check if there are more pages available
  bool get hasMore => offset + limit < count;

  /// Get the current page number (1-based)
  int get currentPage => (offset ~/ limit) + 1;

  /// Get the total number of pages
  int get totalPages => (count / limit).ceil();

  // Convenience getters for common resource types
  /// Convenience getter for products (same as data)
  List<T> get products => data;

  /// Convenience getter for orders (same as data)
  List<T> get orders => data;

  /// Convenience getter for customers (same as data)
  List<T> get customers => data;

  /// Convenience getter for collections (same as data)
  List<T> get collections => data;

  /// Convenience getter for categories (same as data)
  List<T> get categories => data;

  /// Convenience getter for items (same as data)
  List<T> get items => data;
}

/// Response wrapper for delete operations
@JsonSerializable(fieldRename: FieldRename.snake)
class DeleteResponse {
  /// ID of the deleted resource
  final String id;

  /// Type of the deleted resource
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const DeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory DeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteResponseToJson(this);
}

/// Response wrapper for batch operations
@JsonSerializable(
  genericArgumentFactories: true,
  fieldRename: FieldRename.snake,
)
class BatchResponse<T> {
  /// The created items
  final List<T> created;

  /// The updated items
  final List<T> updated;

  /// The deleted items
  final List<DeleteResponse> deleted;

  const BatchResponse({
    required this.created,
    required this.updated,
    required this.deleted,
  });

  factory BatchResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BatchResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BatchResponseToJson(this, toJsonT);
}

/// Order status enumeration
enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('archived')
  archived,
  @JsonValue('canceled')
  canceled,
  @JsonValue('requires_action')
  requiresAction,
}

/// Fulfillment status enumeration
enum FulfillmentStatus {
  @JsonValue('not_fulfilled')
  notFulfilled,
  @JsonValue('partially_fulfilled')
  partiallyFulfilled,
  @JsonValue('fulfilled')
  fulfilled,
  @JsonValue('partially_shipped')
  partiallyShipped,
  @JsonValue('shipped')
  shipped,
  @JsonValue('partially_returned')
  partiallyReturned,
  @JsonValue('returned')
  returned,
  @JsonValue('canceled')
  canceled,
  @JsonValue('requires_action')
  requiresAction,
}

/// Payment status enumeration
enum PaymentStatus {
  @JsonValue('not_paid')
  notPaid,
  @JsonValue('awaiting')
  awaiting,
  @JsonValue('captured')
  captured,
  @JsonValue('partially_refunded')
  partiallyRefunded,
  @JsonValue('refunded')
  refunded,
  @JsonValue('canceled')
  canceled,
  @JsonValue('requires_action')
  requiresAction,
}

/// Cart type enumeration
enum CartType {
  @JsonValue('default')
  defaultCart,
  @JsonValue('swap')
  swap,
  @JsonValue('draft_order')
  draftOrder,
  @JsonValue('payment_link')
  paymentLink,
  @JsonValue('claim')
  claim,
}

/// Product status enumeration
enum ProductStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('proposed')
  proposed,
  @JsonValue('published')
  published,
  @JsonValue('rejected')
  rejected,
}

/// Product collection status enumeration
enum CollectionStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('published')
  published,
}

/// Product category visibility enumeration
enum CategoryVisibility {
  @JsonValue('public')
  public,
  @JsonValue('private')
  private,
}

/// Payment session status enumeration
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

/// Shipping option price type enumeration
enum ShippingOptionPriceType {
  @JsonValue('flat')
  flat,
  @JsonValue('calculated')
  calculated,
}
