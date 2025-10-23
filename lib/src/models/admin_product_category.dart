///  Admin Product Category models from @medusajs/types v2.10.1
///
/// Comprehensive product category management models following Medusa v2.10 specifications.
/// Covers hierarchical category structures, product associations, and catalog organization for structured product taxonomy.

import 'package:json_annotation/json_annotation.dart';

part 'admin_product_category.g.dart';

// ==========================================
// Core Admin Product Category Models
// ==========================================

/// Admin product category from @medusajs/types AdminProductCategory
///
/// Represents a hierarchical product category for organizing products
/// with support for parent-child relationships, visibility controls, and ranking.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminProductCategory {
  /// The category's ID
  final String id;

  /// The category's name
  final String name;

  /// The category's description
  final String? description;

  /// The category's unique handle
  final String handle;

  /// Whether the category is active (visible in storefront)
  final bool isActive;

  /// Whether the category is internal (admin-only)
  final bool isInternal;

  /// The category's rank among sibling categories
  final double rank;

  /// The ID of the category's parent
  final String? parentCategoryId;

  /// The category's parent category
  final AdminProductCategory? parentCategory;

  /// The category's child categories
  final List<AdminProductCategory>? categoryChildren;

  /// The category's products
  final List<AdminCategoryProduct>? products;

  /// The category's metadata
  final Map<String, dynamic>? metadata;

  /// The category's creation date
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The category's update date
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The category's deletion date
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminProductCategory({
    required this.id,
    required this.name,
    required this.handle,
    required this.isActive,
    required this.isInternal,
    required this.rank,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.parentCategoryId,
    this.parentCategory,
    this.categoryChildren,
    this.products,
    this.metadata,
    this.deletedAt,
  });

  factory AdminProductCategory.fromJson(Map<String, dynamic> json) =>
      _$AdminProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AdminProductCategoryToJson(this);
}

/// Admin category product from BaseProduct for category association
///
/// Represents a simplified product view within category contexts.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategoryProduct {
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

  const AdminCategoryProduct({
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

  factory AdminCategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$AdminCategoryProductFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCategoryProductToJson(this);
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
// Admin Product Category Request/Response Models
// ==========================================

/// Admin product category response wrapper from @medusajs/types AdminProductCategoryResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminProductCategoryResponse {
  /// The product category's details
  final AdminProductCategory productCategory;

  const AdminProductCategoryResponse({required this.productCategory});

  factory AdminProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminProductCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminProductCategoryResponseToJson(this);
}

/// Admin product category list response from @medusajs/types AdminProductCategoryListResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminProductCategoryListResponse {
  /// The maximum number of items returned
  final int limit;

  /// The number of items skipped before retrieving the returned results
  final int offset;

  /// The total number of items
  final int count;

  /// The list of product categories
  final List<AdminProductCategory> productCategories;

  /// The estimated count retrieved from the PostgreSQL query planner
  final int? estimateCount;

  const AdminProductCategoryListResponse({
    required this.limit,
    required this.offset,
    required this.count,
    required this.productCategories,
    this.estimateCount,
  });

  factory AdminProductCategoryListResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminProductCategoryListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminProductCategoryListResponseToJson(this);
}

/// Admin product category delete response from @medusajs/types AdminProductCategoryDeleteResponse
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminProductCategoryDeleteResponse {
  /// The product category's ID
  final String id;

  /// The name of the deleted object
  final String object;

  /// Whether the product category was deleted
  final bool deleted;

  const AdminProductCategoryDeleteResponse({
    required this.id,
    required this.object,
    required this.deleted,
  });

  factory AdminProductCategoryDeleteResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminProductCategoryDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminProductCategoryDeleteResponseToJson(this);
}

/// Admin create product category request from @medusajs/types AdminCreateProductCategory
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateProductCategory {
  /// The product category's name
  final String name;

  /// The product category's description
  final String? description;

  /// The product category's handle
  final String? handle;

  /// Whether the product category is only used and seen by admin users
  final bool? isInternal;

  /// Whether the product category is active
  final bool? isActive;

  /// The ID of a category that's the parent of this one
  final String? parentCategoryId;

  /// The sorting order of the product category among sibling categories
  final double? rank;

  /// The product category's metadata
  final Map<String, dynamic>? metadata;

  const AdminCreateProductCategory({
    required this.name,
    this.description,
    this.handle,
    this.isInternal,
    this.isActive,
    this.parentCategoryId,
    this.rank,
    this.metadata,
  });

  factory AdminCreateProductCategory.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateProductCategoryToJson(this);
}

/// Admin update product category request
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateProductCategory {
  /// The product category's name
  final String? name;

  /// The product category's description
  final String? description;

  /// The product category's handle
  final String? handle;

  /// Whether the product category is only used and seen by admin users
  final bool? isInternal;

  /// Whether the product category is active
  final bool? isActive;

  /// The ID of a category that's the parent of this one
  final String? parentCategoryId;

  /// The sorting order of the product category among sibling categories
  final double? rank;

  /// The product category's metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateProductCategory({
    this.name,
    this.description,
    this.handle,
    this.isInternal,
    this.isActive,
    this.parentCategoryId,
    this.rank,
    this.metadata,
  });

  factory AdminUpdateProductCategory.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateProductCategoryToJson(this);
}

// ==========================================
// Admin Category Product Association Models
// ==========================================

/// Admin category product batch request for adding/removing products
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategoryProductBatch {
  /// The product IDs to add to the category
  final List<String>? productIds;

  const AdminCategoryProductBatch({this.productIds});

  factory AdminCategoryProductBatch.fromJson(Map<String, dynamic> json) =>
      _$AdminCategoryProductBatchFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCategoryProductBatchToJson(this);
}

/// Admin category product batch response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategoryProductBatchResponse {
  /// The updated category with new product associations
  final AdminProductCategory productCategory;

  /// The products that were processed
  final List<String> processed;

  /// Any products that failed to be processed
  final List<String>? failed;

  const AdminCategoryProductBatchResponse({
    required this.productCategory,
    required this.processed,
    this.failed,
  });

  factory AdminCategoryProductBatchResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCategoryProductBatchResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminCategoryProductBatchResponseToJson(this);
}

// ==========================================
// Admin Category Hierarchy Models
// ==========================================

/// Admin category hierarchy tree structure
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategoryTree {
  /// The root category
  final AdminProductCategory category;

  /// The depth level in the hierarchy
  final int level;

  /// Whether this category has children
  final bool hasChildren;

  /// The number of direct children
  final int childrenCount;

  /// The total number of descendants
  final int descendantsCount;

  /// The path from root to this category
  final List<String> categoryPath;

  /// Custom display properties
  final Map<String, dynamic>? displayProperties;

  const AdminCategoryTree({
    required this.category,
    required this.level,
    required this.hasChildren,
    required this.childrenCount,
    required this.descendantsCount,
    required this.categoryPath,
    this.displayProperties,
  });

  factory AdminCategoryTree.fromJson(Map<String, dynamic> json) =>
      _$AdminCategoryTreeFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCategoryTreeToJson(this);
}

/// Admin category hierarchy response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategoryHierarchyResponse {
  /// The category trees
  final List<AdminCategoryTree> trees;

  /// The maximum depth in the hierarchy
  final int maxDepth;

  /// The total number of categories
  final int totalCategories;

  const AdminCategoryHierarchyResponse({
    required this.trees,
    required this.maxDepth,
    required this.totalCategories,
  });

  factory AdminCategoryHierarchyResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCategoryHierarchyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCategoryHierarchyResponseToJson(this);
}

// ==========================================
// Admin Category Analytics Models
// ==========================================

/// Admin category statistics for analytics and reporting
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategoryStats {
  /// The category ID
  final String categoryId;

  /// Total number of products in the category
  final int productCount;

  /// Total number of published products
  final int publishedProductCount;

  /// Total number of draft products
  final int draftProductCount;

  /// Total number of direct child categories
  final int directChildrenCount;

  /// Total number of all descendant categories
  final int allDescendantsCount;

  /// Average product price in the category
  final double? averageProductPrice;

  /// Total revenue generated from products in this category
  final double totalRevenue;

  /// The date these statistics were calculated
  final DateTime calculatedAt;

  const AdminCategoryStats({
    required this.categoryId,
    required this.productCount,
    required this.publishedProductCount,
    required this.draftProductCount,
    required this.directChildrenCount,
    required this.allDescendantsCount,
    required this.totalRevenue,
    required this.calculatedAt,
    this.averageProductPrice,
  });

  factory AdminCategoryStats.fromJson(Map<String, dynamic> json) =>
      _$AdminCategoryStatsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCategoryStatsToJson(this);
}

/// Admin category analytics response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategoryAnalyticsResponse {
  /// The category statistics
  final AdminCategoryStats stats;

  /// Additional insights and metrics
  final Map<String, dynamic>? insights;

  const AdminCategoryAnalyticsResponse({required this.stats, this.insights});

  factory AdminCategoryAnalyticsResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCategoryAnalyticsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCategoryAnalyticsResponseToJson(this);
}

// ==========================================
// Admin Category Search Models
// ==========================================

/// Admin category search parameters
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategorySearchParams {
  /// Search query string
  final String? q;

  /// Filter by name
  final String? name;

  /// Filter by handle
  final String? handle;

  /// Filter by parent category ID
  final String? parentCategoryId;

  /// Filter by active status
  final bool? isActive;

  /// Filter by internal status
  final bool? isInternal;

  /// Filter by creation date
  @JsonKey(name: 'created_at')
  final Map<String, dynamic>? createdAt;

  /// Filter by update date
  @JsonKey(name: 'updated_at')
  final Map<String, dynamic>? updatedAt;

  /// Include deleted categories
  final bool? includeDeleted;

  /// Include descendants in results
  final bool? includeDescendants;

  /// Minimum product count
  final int? minProductCount;

  /// Maximum product count
  final int? maxProductCount;

  /// Maximum depth to search
  final int? maxDepth;

  const AdminCategorySearchParams({
    this.q,
    this.name,
    this.handle,
    this.parentCategoryId,
    this.isActive,
    this.isInternal,
    this.createdAt,
    this.updatedAt,
    this.includeDeleted,
    this.includeDescendants,
    this.minProductCount,
    this.maxProductCount,
    this.maxDepth,
  });

  factory AdminCategorySearchParams.fromJson(Map<String, dynamic> json) =>
      _$AdminCategorySearchParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCategorySearchParamsToJson(this);
}

/// Admin category search response
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCategorySearchResponse {
  /// The matching categories
  final List<AdminProductCategory> categories;

  /// Total number of matches
  final int totalCount;

  /// Search execution time in milliseconds
  final int executionTime;

  /// Search relevance scores (if applicable)
  final Map<String, double>? relevanceScores;

  /// Hierarchy information for matching categories
  final List<AdminCategoryTree>? hierarchyInfo;

  const AdminCategorySearchResponse({
    required this.categories,
    required this.totalCount,
    required this.executionTime,
    this.relevanceScores,
    this.hierarchyInfo,
  });

  factory AdminCategorySearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCategorySearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCategorySearchResponseToJson(this);
}
