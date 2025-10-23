///  Admin Collection models from @medusajs/types v2.10.1
///
/// Comprehensive product collection management models following Medusa v2.10 specifications.
/// Covers collections, product associations, and catalog organization for structured product management.

import 'package:json_annotation/json_annotation.dart';

part 'admin_collection.g.dart';

// ==========================================
// Core Admin Collection Models
// ==========================================

/// Admin collection from @medusajs/types AdminCollection
///
/// Represents a product collection for organizing and grouping
/// products with shared characteristics or themes for improved catalog management.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollection {
  /// The collection's ID
  final String id;

  /// The collection's title
  final String title;

  /// The collection's handle
  final String handle;

  /// The collection's products
  final List<AdminCollectionProduct>? products;

  /// The collection's metadata
  final Map<String, dynamic> metadata;

  /// The collection's creation date
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The collection's update date
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The collection's deletion date
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminCollection({
    required this.id,
    required this.title,
    required this.handle,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.products,
    this.deletedAt,
  });

  factory AdminCollection.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionToJson(this);
}

/// Admin collection product from BaseProduct for collection association
///
/// Represents a simplified product view within collection contexts.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionProduct {
  /// The product's ID
  final String id;

  /// The product's title
  final String title;

  /// The product's unique handle
  final String handle;

  /// The product's subtitle
  final String? subtitle;

  /// The product's description
  final String? description;

  /// The product's status
  final AdminProductStatus status;

  /// The product's thumbnail image URL
  final String? thumbnail;

  /// Whether the product is a gift card
  final bool isGiftcard;

  /// Whether the product can have discounts applied
  final bool discountable;

  /// The product's external ID
  final String? externalId;

  /// The product's metadata
  final Map<String, dynamic>? metadata;

  /// The date the product was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the product was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the product was deleted
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminCollectionProduct({
    required this.id,
    required this.title,
    required this.handle,
    required this.status,
    required this.isGiftcard,
    required this.discountable,
    required this.createdAt,
    required this.updatedAt,
    this.subtitle,
    this.description,
    this.thumbnail,
    this.externalId,
    this.metadata,
    this.deletedAt,
  });

  factory AdminCollectionProduct.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionProductFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionProductToJson(this);
}

/// Admin product status enumeration
enum AdminProductStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('proposed')
  proposed,
  @JsonValue('published')
  published,
  @JsonValue('rejected')
  rejected,
}

// ==========================================
// Admin Collection Request/Response Models
// ==========================================

/// Admin collection response wrapper from @medusajs/types AdminCollectionResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionResponse {
  /// The collection's details
  final AdminCollection collection;

  const AdminCollectionResponse({required this.collection});

  factory AdminCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionResponseToJson(this);
}

/// Admin collection list response from @medusajs/types AdminCollectionListResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionListResponse {
  /// The maximum number of items returned
  final int limit;

  /// The number of items skipped before retrieving the returned results
  final int offset;

  /// The total number of items
  final int count;

  /// The list of product collections
  final List<AdminCollection> collections;

  /// The estimated count retrieved from the PostgreSQL query planner
  final int? estimateCount;

  const AdminCollectionListResponse({
    required this.limit,
    required this.offset,
    required this.count,
    required this.collections,
    this.estimateCount,
  });

  factory AdminCollectionListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionListResponseToJson(this);
}

/// Admin collection delete response from @medusajs/types AdminCollectionDeleteResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionDeleteResponse {
  /// The collection's ID
  final String id;

  /// The name of the deleted object
  final String object;

  /// Whether the collection was deleted
  final bool deleted;

  const AdminCollectionDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminCollectionDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionDeleteResponseToJson(this);
}

/// Admin create collection request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateCollection {
  /// The collection's title
  final String title;

  /// The collection's handle
  final String? handle;

  /// The collection's metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateCollection({
    required this.title,
    this.handle,
    this.metadata,
  });

  factory AdminCreateCollection.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateCollectionToJson(this);
}

/// Admin update collection request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateCollection {
  /// The collection's title
  final String? title;

  /// The collection's handle
  final String? handle;

  /// The collection's metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateCollection({this.title, this.handle, this.metadata});

  factory AdminUpdateCollection.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateCollectionToJson(this);
}

// ==========================================
// Admin Collection Product Association Models
// ==========================================

/// Admin collection product batch request for adding/removing products
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionProductBatch {
  /// The product IDs to add to the collection
  final List<String>? productIds;

  const AdminCollectionProductBatch({this.productIds});

  factory AdminCollectionProductBatch.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionProductBatchFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionProductBatchToJson(this);
}

/// Admin collection product batch response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionProductBatchResponse {
  /// The updated collection with new product associations
  final AdminCollection collection;

  /// The products that were processed
  final List<String> processed;

  /// Any products that failed to be processed
  final List<String>? failed;

  const AdminCollectionProductBatchResponse({
    required this.collection,
    required this.processed,
    this.failed,
  });

  factory AdminCollectionProductBatchResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCollectionProductBatchResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminCollectionProductBatchResponseToJson(this);
}

// ==========================================
// Admin Collection Analytics Models
// ==========================================

/// Admin collection statistics for analytics and reporting
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionStats {
  /// The collection ID
  final String collectionId;

  /// Total number of products in the collection
  final int productCount;

  /// Total number of published products
  final int publishedProductCount;

  /// Total number of draft products
  final int draftProductCount;

  /// Total number of orders containing products from this collection
  final int orderCount;

  /// Total revenue generated from products in this collection
  final double totalRevenue;

  /// Average product price in the collection
  final double averageProductPrice;

  /// The date these statistics were calculated
  final DateTime calculatedAt;

  const AdminCollectionStats({
    required this.collectionId,
    required this.productCount,
    required this.publishedProductCount,
    required this.draftProductCount,
    required this.orderCount,
    required this.totalRevenue,
    required this.averageProductPrice,
    required this.calculatedAt,
  });

  factory AdminCollectionStats.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionStatsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionStatsToJson(this);
}

/// Admin collection analytics response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionAnalyticsResponse {
  /// The collection statistics
  final AdminCollectionStats stats;

  /// Additional insights and metrics
  final Map<String, dynamic>? insights;

  const AdminCollectionAnalyticsResponse({required this.stats, this.insights});

  factory AdminCollectionAnalyticsResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCollectionAnalyticsResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminCollectionAnalyticsResponseToJson(this);
}

// ==========================================
// Admin Collection Configuration Models
// ==========================================

/// Admin collection configuration settings
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionConfig {
  /// The collection ID
  final String collectionId;

  /// Whether the collection is featured
  final bool isFeatured;

  /// Display order for featured collections
  final int? displayOrder;

  /// SEO configuration for the collection
  final Map<String, dynamic>? seoConfig;

  /// Visibility settings for different sales channels
  final Map<String, bool>? visibility;

  /// Custom sorting rules for products in this collection
  final Map<String, dynamic>? sortingRules;

  /// Collection-specific pricing rules
  final Map<String, dynamic>? pricingRules;

  const AdminCollectionConfig({
    required this.collectionId,
    required this.isFeatured,
    this.displayOrder,
    this.seoConfig,
    this.visibility,
    this.sortingRules,
    this.pricingRules,
  });

  factory AdminCollectionConfig.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionConfigToJson(this);
}

/// Admin collection configuration response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionConfigResponse {
  /// The collection configuration
  final AdminCollectionConfig config;

  const AdminCollectionConfigResponse({required this.config});

  factory AdminCollectionConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionConfigResponseToJson(this);
}

// ==========================================
// Admin Collection Search Models
// ==========================================

/// Admin collection search parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionSearchParams {
  /// Search query string
  final String? q;

  /// Filter by title
  final String? title;

  /// Filter by handle
  final String? handle;

  /// Filter by creation date
  @JsonKey(name: 'created_at')
  final Map<String, dynamic>? createdAt;

  /// Filter by update date
  @JsonKey(name: 'updated_at')
  final Map<String, dynamic>? updatedAt;

  /// Include deleted collections
  final bool? includeDeleted;

  /// Minimum product count
  final int? minProductCount;

  /// Maximum product count
  final int? maxProductCount;

  const AdminCollectionSearchParams({
    this.q,
    this.title,
    this.handle,
    this.createdAt,
    this.updatedAt,
    this.includeDeleted,
    this.minProductCount,
    this.maxProductCount,
  });

  factory AdminCollectionSearchParams.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionSearchParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionSearchParamsToJson(this);
}

/// Admin collection search response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCollectionSearchResponse {
  /// The matching collections
  final List<AdminCollection> collections;

  /// Total number of matches
  final int totalCount;

  /// Search execution time in milliseconds
  final int executionTime;

  /// Search relevance scores (if applicable)
  final Map<String, double>? relevanceScores;

  const AdminCollectionSearchResponse({
    required this.collections,
    required this.totalCount,
    required this.executionTime,
    this.relevanceScores,
  });

  factory AdminCollectionSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCollectionSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCollectionSearchResponseToJson(this);
}
