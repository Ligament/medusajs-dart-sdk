import 'package:json_annotation/json_annotation.dart';
import 'common.dart';
import 'product_variant.dart';
import 'product_image.dart';
import 'product_option.dart';
import 'product_tag.dart';
import 'product_type.dart';
import 'sales_channel.dart';
// import 'store_collection.dart';
import 'category.dart';

// part 'product.g.dart';

// /// Represents a product in the Medusa system
// @JsonSerializable(fieldRename: FieldRename.snake)
// class Product {
//   /// Unique identifier for the product
//   final String id;

//   /// Product title
//   final String? title;

//   /// Product subtitle
//   final String? subtitle;

//   /// Product description
//   final String? description;

//   /// Product handle (URL slug)
//   final String? handle;

//   /// Whether the product is a gift card
//   final bool isGiftcard;

//   /// Product status
//   final ProductStatus? status;

//   /// Product thumbnail URL
//   final String? thumbnail;

//   /// Product weight
//   final int? weight;

//   /// Product length
//   final int? length;

//   /// Product height
//   final int? height;

//   /// Product width
//   final int? width;

//   /// Product origin country
//   final String? originCountry;

//   /// Product harmonized system code
//   final String? hsCode;

//   /// Product material composition
//   final String? material;

//   /// Mid code
//   final String? midCode;

//   /// Whether discounts can be applied to this product
//   final bool discountable;

//   /// External ID for integration purposes
//   final String? externalId;

//   /// Product metadata
//   final Map<String, dynamic>? metadata;

//   /// Product images
//   final List<ProductImage>? images;

//   /// Product variants
//   final List<ProductVariant>? variants;

//   /// Product options
//   final List<ProductOption>? options;

//   /// Product tags
//   final List<ProductTag>? tags;

//   /// Product type
//   final ProductType? type;

//   /// Product collection
//   final Collection? collection;

//   /// Product categories
//   final List<Category>? categories;

//   /// Sales channels where this product is available
//   final List<SalesChannel>? salesChannels;

//   /// When the product was created
//   final DateTime? createdAt;

//   /// When the product was last updated
//   final DateTime? updatedAt;

//   /// When the product was deleted (if soft deleted)
//   final DateTime? deletedAt;

//   const Product({
//     required this.id,
//     this.title,
//     this.subtitle,
//     this.description,
//     this.handle,
//     this.isGiftcard = false,
//     this.status,
//     this.thumbnail,
//     this.weight,
//     this.length,
//     this.height,
//     this.width,
//     this.originCountry,
//     this.hsCode,
//     this.material,
//     this.midCode,
//     this.discountable = true,
//     this.externalId,
//     this.metadata,
//     this.images,
//     this.variants,
//     this.options,
//     this.tags,
//     this.type,
//     this.collection,
//     this.categories,
//     this.salesChannels,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) =>
//       _$ProductFromJson(json);
//   Map<String, dynamic> toJson() => _$ProductToJson(this);

//   /// Check if product is published
//   bool get isPublished => status == ProductStatus.published;

//   /// Check if product is draft
//   bool get isDraft => status == ProductStatus.draft || status == null;

//   /// Check if product is proposed
//   bool get isProposed => status == ProductStatus.proposed;

//   /// Check if product is rejected
//   bool get isRejected => status == ProductStatus.rejected;

//   /// Check if product has dimensions
//   bool get hasDimensions => length != null && height != null && width != null;

//   /// Check if product has weight
//   bool get hasWeight => weight != null;

//   /// Get product dimensions as a formatted string
//   String get formattedDimensions {
//     if (!hasDimensions) return 'N/A';
//     return '${length}x${width}x$height';
//   }

//   /// Get product weight formatted
//   String get formattedWeight {
//     if (!hasWeight) return 'N/A';
//     return '${weight}g';
//   }
// }
