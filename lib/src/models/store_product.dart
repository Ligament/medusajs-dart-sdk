import 'package:json_annotation/json_annotation.dart';

part 'store_product.g.dart';

/// StoreProduct model from official @medusajs/types v2.10.1
///
/// Extends BaseProduct with Store-specific associations and relationships
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProduct {
  /// The product's ID
  final String id;

  /// The product's title
  final String? title;

  /// The product's handle
  final String? handle;

  /// The product's subtitle
  final String? subtitle;

  /// The product's description
  final String? description;

  /// Whether the product is a gift card
  @JsonKey(name: 'is_giftcard')
  final bool? isGiftcard;

  /// The product's status
  final String? status;

  /// The product's thumbnail
  final String? thumbnail;

  /// The product's width
  final double? width;

  /// The product's weight
  final double? weight;

  /// The product's length
  final double? length;

  /// The product's height
  final double? height;

  /// The product's origin country
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  /// The product's HS code
  @JsonKey(name: 'hs_code')
  final String? hsCode;

  /// The product's MID code
  @JsonKey(name: 'mid_code')
  final String? midCode;

  /// The product's material
  final String? material;

  /// The ID of the associated product collection
  @JsonKey(name: 'collection_id')
  final String? collectionId;

  /// The ID of the associated product type
  @JsonKey(name: 'type_id')
  final String? typeId;

  /// Whether the product is discountable
  final bool? discountable;

  /// The ID of the product in external systems
  @JsonKey(name: 'external_id')
  final String? externalId;

  /// The date the product was created (nullable string)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// The date the product was updated (nullable string)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The date the product was deleted (nullable string)
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The product's collection
  final StoreCollection? collection;

  /// The product's categories
  final List<StoreProductCategory>? categories;

  /// The product's variants
  final List<StoreProductVariant>? variants;

  /// The product's type
  final StoreProductType? type;

  /// The product's tags
  final List<StoreProductTag>? tags;

  /// The product's options
  final List<StoreProductOption>? options;

  /// The product's images
  final List<StoreProductImage>? images;

  const StoreProduct({
    required this.id,
    this.title,
    this.handle,
    this.subtitle,
    this.description,
    this.isGiftcard,
    this.status,
    this.thumbnail,
    this.width,
    this.weight,
    this.length,
    this.height,
    this.originCountry,
    this.hsCode,
    this.midCode,
    this.material,
    this.collectionId,
    this.typeId,
    this.discountable,
    this.externalId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
    this.collection,
    this.categories,
    this.variants,
    this.type,
    this.tags,
    this.options,
    this.images,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) =>
      _$StoreProductFromJson(json);

  Map<String, dynamic> toJson() => _$StoreProductToJson(this);

  @override
  String toString() => 'StoreProduct(id: $id, title: $title)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreProduct &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// StoreProductVariant model from official @medusajs/types v2.10.1
///
/// Extends BaseProductVariant with Store-specific associations
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProductVariant {
  /// The variant's ID
  final String id;

  /// The variant's title
  final String? title;

  /// The variant's SKU
  final String? sku;

  /// The variant's barcode
  final String? barcode;

  /// The variant's EAN
  final String? ean;

  /// The variant's UPC
  final String? upc;

  /// Whether the variant can be ordered even if it's out of stock
  @JsonKey(name: 'allow_backorder')
  final bool? allowBackorder;

  /// Whether Medusa manages the variant's inventory
  @JsonKey(name: 'manage_inventory')
  final bool? manageInventory;

  /// The variant's inventory quantity (if manage_inventory is enabled)
  @JsonKey(name: 'inventory_quantity')
  final int? inventoryQuantity;

  /// The variant's HS code
  @JsonKey(name: 'hs_code')
  final String? hsCode;

  /// The variant's origin country
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  /// The variant's MID code
  @JsonKey(name: 'mid_code')
  final String? midCode;

  /// The variant's material
  final String? material;

  /// The variant's weight
  final double? weight;

  /// The variant's length
  final double? length;

  /// The variant's height
  final double? height;

  /// The variant's width
  final double? width;

  /// The variant's ranking among its siblings
  @JsonKey(name: 'variant_rank')
  final int? variantRank;

  /// The ID of the product that the variant belongs to
  @JsonKey(name: 'product_id')
  final String? productId;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The variant's pre-order configuration if available
  final StorePreorderVariant? preorderVariant;

  /// The variant's values for the product's options
  final List<StoreProductOptionValue>? options;

  /// The variant's product
  final StoreProduct? product;

  /// The variant's calculated price (if provided in context)
  @JsonKey(name: 'calculated_price')
  final Map<String, dynamic>? calculatedPrice;

  /// The date the variant was created (nullable string)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// The date the variant was updated (nullable string)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The date the variant was deleted (nullable string)
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  const StoreProductVariant({
    required this.id,
    this.title,
    this.sku,
    this.barcode,
    this.ean,
    this.upc,
    this.allowBackorder,
    this.manageInventory,
    this.inventoryQuantity,
    this.hsCode,
    this.originCountry,
    this.midCode,
    this.material,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.variantRank,
    this.productId,
    this.metadata,
    this.preorderVariant,
    this.options,
    this.product,
    this.calculatedPrice,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StoreProductVariant.fromJson(Map<String, dynamic> json) =>
      _$StoreProductVariantFromJson(json);

  Map<String, dynamic> toJson() => _$StoreProductVariantToJson(this);

  @override
  String toString() => 'StoreProductVariant(id: $id, title: $title)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreProductVariant &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// StorePreorderVariant model describing pre-order metadata for a variant
@JsonSerializable(fieldRename: FieldRename.snake)
class StorePreorderVariant {
  /// The pre-order configuration ID
  final String? id;

  /// The ID of the product variant this configuration applies to
  final String? variantId;

  /// The date when the variant becomes available
  final String? availableDate;

  /// The current pre-order status (enabled/disabled)
  final String? status;

  /// The date the configuration was created
  final String? createdAt;

  /// The date the configuration was last updated
  final String? updatedAt;

  /// The date the configuration was deleted
  final String? deletedAt;

  const StorePreorderVariant({
    this.id,
    this.variantId,
    this.availableDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StorePreorderVariant.fromJson(Map<String, dynamic> json) =>
      _$StorePreorderVariantFromJson(json);

  Map<String, dynamic> toJson() => _$StorePreorderVariantToJson(this);

  @override
  String toString() => 'StorePreorderVariant(id: $id, status: $status)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorePreorderVariant &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// StoreProductOption model from official @medusajs/types v2.10.1
///
/// Extends BaseProductOption with Store-specific associations
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProductOption {
  /// The option's ID
  final String id;

  /// The option's title
  final String title;

  /// The ID of the product that the option belongs to
  final String? productId;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The product the option belongs to
  final StoreProduct? product;

  /// The option's values
  final List<StoreProductOptionValue>? values;

  /// The date the option was created
  final DateTime? createdAt;

  /// The date the option was updated
  final DateTime? updatedAt;

  /// The date the option was deleted
  final DateTime? deletedAt;

  const StoreProductOption({
    required this.id,
    required this.title,
    this.productId,
    this.metadata,
    this.product,
    this.values,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StoreProductOption.fromJson(Map<String, dynamic> json) =>
      _$StoreProductOptionFromJson(json);

  Map<String, dynamic> toJson() => _$StoreProductOptionToJson(this);

  @override
  String toString() => 'StoreProductOption(id: $id, title: $title)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreProductOption &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// StoreProductImage model from official @medusajs/types v2.10.1
///
/// Extends BaseProductImage
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProductImage {
  /// The image's ID
  final String id;

  /// The image's URL
  final String url;

  /// The rank of the product image
  final int rank;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date the image was created
  final DateTime? createdAt;

  /// The date the image was updated
  final DateTime? updatedAt;

  /// The date the image was deleted
  final DateTime? deletedAt;

  const StoreProductImage({
    required this.id,
    required this.url,
    required this.rank,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StoreProductImage.fromJson(Map<String, dynamic> json) =>
      _$StoreProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$StoreProductImageToJson(this);

  @override
  String toString() => 'StoreProductImage(id: $id, url: $url)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreProductImage &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// StoreProductOptionValue model from official @medusajs/types v2.10.1
///
/// Extends BaseProductOptionValue with Store-specific associations
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProductOptionValue {
  /// The option value's ID
  final String id;

  /// The option's value
  final String value;

  /// The ID of the option
  final String? optionId;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The product's option
  final StoreProductOption? option;

  /// The date the option value was created
  final DateTime? createdAt;

  /// The date the option value was updated
  final DateTime? updatedAt;

  /// The date the option value was deleted
  final DateTime? deletedAt;

  const StoreProductOptionValue({
    required this.id,
    required this.value,
    this.optionId,
    this.metadata,
    this.option,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StoreProductOptionValue.fromJson(Map<String, dynamic> json) =>
      _$StoreProductOptionValueFromJson(json);

  Map<String, dynamic> toJson() => _$StoreProductOptionValueToJson(this);

  @override
  String toString() => 'StoreProductOptionValue(id: $id, value: $value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreProductOptionValue &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Use StoreCollection from collection.dart

@JsonSerializable(fieldRename: FieldRename.snake)
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class StoreProductCategory {
  final String? id;
  final String? name;
  final String? description;
  final String? handle;
  final int? rank;
  final String? parentCategoryId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final StoreProductCategory? parentCategory;
  final List<StoreProductCategory>? categoryChildren;
  final Map<String, dynamic>? metadata;
  final List<StoreProduct>? products;

  const StoreProductCategory({
    this.id,
    this.name,
    this.description,
    this.handle,
    this.rank,
    this.parentCategoryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.parentCategory,
    this.categoryChildren,
    this.metadata,
    this.products,
  });

  factory StoreProductCategory.fromJson(Map<String, dynamic> json) =>
      _$StoreProductCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoreProductCategoryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProductType {
  final String id;
  final String value;

  const StoreProductType({required this.id, required this.value});

  factory StoreProductType.fromJson(Map<String, dynamic> json) =>
      StoreProductType(id: json['id'], value: json['value']);

  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProductTag {
  final String id;
  final String value;

  const StoreProductTag({required this.id, required this.value});

  factory StoreProductTag.fromJson(Map<String, dynamic> json) =>
      StoreProductTag(id: json['id'], value: json['value']);

  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}

/// Store Product response wrapper
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProductResponse {
  /// The product data
  final StoreProduct product;

  const StoreProductResponse({required this.product});

  factory StoreProductResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreProductResponseToJson(this);
}

/// Store Products list response wrapper
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreProductListResponse {
  /// List of products
  final List<StoreProduct> products;

  /// Total count of products
  final int count;

  /// Offset used in pagination
  final int offset;

  /// Limit used in pagination
  final int limit;

  const StoreProductListResponse({
    required this.products,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory StoreProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreProductListResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StoreCollection {
  /// The collection's ID
  final String id;

  /// The collection's title
  final String title;

  /// The collection's handle
  final String? handle;

  /// The date the collection was created (nullable string)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// The date the collection was updated (nullable string)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The date the collection was deleted (nullable string)
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  /// Metadata associated with the collection
  final Map<String, dynamic>? metadata;

  /// The collection's products
  final List<StoreProduct>? products;

  const StoreCollection({
    required this.id,
    required this.title,
    this.handle,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
    this.products,
  });

  factory StoreCollection.fromJson(Map<String, dynamic> json) =>
      _$StoreCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCollectionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreCollection &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'StoreCollection(id: $id, title: $title)';
}
