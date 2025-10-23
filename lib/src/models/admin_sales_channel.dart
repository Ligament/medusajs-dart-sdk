///  Admin Sales Channel models from @medusajs/types v2.10.1
///
/// Comprehensive sales channel management models following Medusa v2.10 specifications.
/// Covers sales channels, product associations, and channel-based commerce operations.

import 'package:json_annotation/json_annotation.dart';

part 'admin_sales_channel.g.dart';

// ==========================================
// Core Admin Sales Channel Models
// ==========================================

/// Admin sales channel from @medusajs/types AdminSalesChannel
///
/// Represents a sales channel for organizing products and managing
/// multi-channel commerce operations across different storefronts.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannel {
  /// The sales channel's ID
  final String id;

  /// The sales channel's name
  final String name;

  /// The sales channel's description
  final String description;

  /// Whether the sales channel is disabled
  final bool isDisabled;

  /// The sales channel's metadata
  final Map<String, dynamic> metadata;

  /// The date the sales channel was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the sales channel was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the sales channel was deleted
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminSalesChannel({
    required this.id,
    required this.name,
    required this.description,
    required this.isDisabled,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminSalesChannel.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelToJson(this);
}

// ==========================================
// Admin Sales Channel Request/Response Models
// ==========================================

/// Admin sales channel response wrapper from @medusajs/types AdminSalesChannelResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelResponse {
  /// The sales channel's details
  final AdminSalesChannel salesChannel;

  const AdminSalesChannelResponse({required this.salesChannel});

  factory AdminSalesChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelResponseToJson(this);
}

/// Admin sales channel list response wrapper
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelListResponse {
  /// The sales channels list
  final List<AdminSalesChannel> salesChannels;

  /// The total count of sales channels
  final int count;

  /// The number of sales channels to skip when retrieving
  final int offset;

  /// The number of items per page
  final int limit;

  const AdminSalesChannelListResponse({
    required this.salesChannels,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminSalesChannelListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelListResponseToJson(this);
}

/// Admin sales channel delete response from @medusajs/types AdminSalesChannelDeleteResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelDeleteResponse {
  /// The sales channel's ID
  final String id;

  /// The name of the deleted object
  final String object;

  /// Whether the sales channel was deleted
  final bool deleted;

  const AdminSalesChannelDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminSalesChannelDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminSalesChannelDeleteResponseToJson(this);
}

/// Admin create sales channel request from @medusajs/types AdminCreateSalesChannel
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateSalesChannel {
  /// The sales channel's name
  final String name;

  /// The sales channel's description
  final String? description;

  /// Whether the sales channel is disabled
  final bool? isDisabled;

  /// The sales channel's metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateSalesChannel({
    required this.name,
    this.description,
    this.isDisabled,
    this.metadata,
  });

  factory AdminCreateSalesChannel.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateSalesChannelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateSalesChannelToJson(this);
}

/// Admin update sales channel request from @medusajs/types AdminUpdateSalesChannel
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateSalesChannel {
  /// The sales channel's name
  final String? name;

  /// The sales channel's description
  final String? description;

  /// Whether the sales channel is disabled
  final bool? isDisabled;

  /// The sales channel's metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateSalesChannel({
    this.name,
    this.description,
    this.isDisabled,
    this.metadata,
  });

  factory AdminUpdateSalesChannel.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateSalesChannelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateSalesChannelToJson(this);
}

// ==========================================
// Admin Sales Channel Product Association Models
// ==========================================

/// Admin sales channel product batch request for adding/removing products
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelProductBatch {
  /// The product IDs to add to the sales channel
  final List<String>? add;

  /// The product IDs to remove from the sales channel
  final List<String>? remove;

  const AdminSalesChannelProductBatch({this.add, this.remove});

  factory AdminSalesChannelProductBatch.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelProductBatchFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelProductBatchToJson(this);
}

/// Admin sales channel product batch response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelProductBatchResponse {
  /// The products that were added
  final List<String> added;

  /// The products that were removed
  final List<String> removed;

  /// Any products that failed to be processed
  final List<String>? failed;

  const AdminSalesChannelProductBatchResponse({
    required this.added,
    required this.removed,
    this.failed,
  });

  factory AdminSalesChannelProductBatchResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminSalesChannelProductBatchResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminSalesChannelProductBatchResponseToJson(this);
}

// ==========================================
// Admin Sales Channel Statistics Models
// ==========================================

/// Admin sales channel statistics for analytics and reporting
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelStats {
  /// The sales channel ID
  final String salesChannelId;

  /// Total number of products in the sales channel
  final int productCount;

  /// Total number of active products
  final int activeProductCount;

  /// Total number of orders placed through this channel
  final int orderCount;

  /// Total revenue generated through this channel
  final double totalRevenue;

  /// Average order value for this channel
  final double averageOrderValue;

  /// The date these statistics were calculated
  final DateTime calculatedAt;

  const AdminSalesChannelStats({
    required this.salesChannelId,
    required this.productCount,
    required this.activeProductCount,
    required this.orderCount,
    required this.totalRevenue,
    required this.averageOrderValue,
    required this.calculatedAt,
  });

  factory AdminSalesChannelStats.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelStatsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelStatsToJson(this);
}

/// Admin sales channel analytics response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelAnalyticsResponse {
  /// The sales channel statistics
  final AdminSalesChannelStats stats;

  /// Additional metrics and insights
  final Map<String, dynamic>? insights;

  const AdminSalesChannelAnalyticsResponse({
    required this.stats,
    this.insights,
  });

  factory AdminSalesChannelAnalyticsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminSalesChannelAnalyticsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminSalesChannelAnalyticsResponseToJson(this);
}

// ==========================================
// Admin Sales Channel Configuration Models
// ==========================================

/// Admin sales channel configuration settings
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelConfig {
  /// The sales channel ID
  final String salesChannelId;

  /// Default currency for the sales channel
  final String? defaultCurrency;

  /// Available payment methods for this channel
  final List<String>? paymentMethods;

  /// Available shipping options for this channel
  final List<String>? shippingOptions;

  /// Tax configuration for this channel
  final Map<String, dynamic>? taxConfig;

  /// Inventory allocation strategy
  final String? inventoryAllocation;

  /// Custom settings specific to this channel
  final Map<String, dynamic>? customSettings;

  const AdminSalesChannelConfig({
    required this.salesChannelId,
    this.defaultCurrency,
    this.paymentMethods,
    this.shippingOptions,
    this.taxConfig,
    this.inventoryAllocation,
    this.customSettings,
  });

  factory AdminSalesChannelConfig.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelConfigToJson(this);
}

/// Admin sales channel configuration response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelConfigResponse {
  /// The sales channel configuration
  final AdminSalesChannelConfig config;

  const AdminSalesChannelConfigResponse({required this.config});

  factory AdminSalesChannelConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelConfigResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminSalesChannelConfigResponseToJson(this);
}

// ==========================================
// Admin Sales Channel Relationship Models
// ==========================================

/// Admin sales channel product association details
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelProduct {
  /// The sales channel ID
  final String salesChannelId;

  /// The product ID
  final String productId;

  /// The date the product was added to the channel
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Priority or ordering within the channel
  final int? priority;

  /// Channel-specific product configuration
  final Map<String, dynamic>? config;

  const AdminSalesChannelProduct({
    required this.salesChannelId,
    required this.productId,
    required this.createdAt,
    this.priority,
    this.config,
  });

  factory AdminSalesChannelProduct.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelProductFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelProductToJson(this);
}

/// Admin sales channel location association for multi-location commerce
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminSalesChannelLocation {
  /// The sales channel ID
  final String salesChannelId;

  /// The stock location ID
  final String locationId;

  /// Whether this location is the default for this channel
  final bool isDefault;

  /// Priority for inventory allocation from this location
  final int priority;

  /// The date the location was associated with the channel
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const AdminSalesChannelLocation({
    required this.salesChannelId,
    required this.locationId,
    required this.isDefault,
    required this.priority,
    required this.createdAt,
  });

  factory AdminSalesChannelLocation.fromJson(Map<String, dynamic> json) =>
      _$AdminSalesChannelLocationFromJson(json);

  Map<String, dynamic> toJson() => _$AdminSalesChannelLocationToJson(this);
}
