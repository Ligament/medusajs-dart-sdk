import 'package:json_annotation/json_annotation.dart';

part 'admin_product.g.dart';

/// AdminProduct model from official @medusajs/types v2.10.1
///
/// Admin-specific product model with enhanced management capabilities.
/// Extends BaseProduct with admin-specific fields, metadata, and relationships.
///
/// Key differences from StoreProduct:
/// - Created/updated by tracking
/// - Enhanced metadata and status management
/// - Admin-specific associations (collections, campaigns, etc.)
/// - Detailed sales channel relationships
///
/// Official Type: AdminProduct extends BaseProduct
@JsonSerializable(explicitToJson: true)
class AdminProduct {
  /// The product's ID
  final String id;

  /// The product's title
  final String title;

  /// The product's handle
  final String handle;

  /// The product's subtitle
  final String? subtitle;

  /// The product's description
  final String? description;

  /// Whether the product is a gift card
  @JsonKey(name: 'is_giftcard')
  final bool isGiftcard;

  /// The product's status
  final String status; // "draft" | "proposed" | "published" | "rejected"

  /// The product's thumbnail URL
  final String? thumbnail;

  /// The product's weight
  final double? weight;

  /// The product's length
  final double? length;

  /// The product's height
  final double? height;

  /// The product's width
  final double? width;

  /// The product's origin country
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  /// The product's HS code
  @JsonKey(name: 'hs_code')
  final String? hsCode;

  /// The product's material
  final String? material;

  /// The product's mid code
  @JsonKey(name: 'mid_code')
  final String? midCode;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The user who created the product
  @JsonKey(name: 'created_by')
  final String? createdBy;

  /// The date the product was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the product was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the product was deleted
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminProduct({
    required this.id,
    required this.title,
    required this.handle,
    this.subtitle,
    this.description,
    required this.isGiftcard,
    required this.status,
    this.thumbnail,
    this.weight,
    this.length,
    this.height,
    this.width,
    this.originCountry,
    this.hsCode,
    this.material,
    this.midCode,
    this.metadata,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminProduct.fromJson(Map<String, dynamic> json) =>
      _$AdminProductFromJson(json);

  Map<String, dynamic> toJson() => _$AdminProductToJson(this);

  @override
  String toString() => 'AdminProduct(id: $id, title: $title, status: $status)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminProduct &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
