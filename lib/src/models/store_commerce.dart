/// Store Commerce Models: Cart, Order, Payment canonical implementations
/// Following official @medusajs/types v2.10.1 specifications
///
/// This file contains canonical Store-specific commerce models that mirror the
/// official TypeScript interfaces exactly, ensuring type safety and API compatibility.
///
/// Key models included:
/// - Cart & LineItem management
/// - Order & fulfillment processing
/// - Payment collection & sessions

import 'package:json_annotation/json_annotation.dart';
import 'store_customer.dart';
import 'store_product.dart';
import 'store_infrastructure.dart';

part 'store_commerce.g.dart';

// Helper function to handle dynamic Map casting from JSON
Map<String, dynamic>? _metadataFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) return json;
  if (json is Map) {
    return json.cast<String, dynamic>();
  }
  return null;
}

dynamic _metadataToJson(Map<String, dynamic>? metadata) => metadata;

// Helper function to convert postal_code (can be int or String) to String
String? _postalCodeFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  if (value is int) return value.toString();
  return value.toString();
}

dynamic _postalCodeToJson(String? value) => value;

// =============================================================================
// CORE CART MODELS - Store Cart Management System
// =============================================================================

/// StoreCart - Main shopping cart entity for store customers
///
/// Extends BaseCart with Store-specific associations and features:
/// - Store-specific address types (billing/shipping)
/// - Store product/variant line items
/// - Store payment collection integration
/// - Store region association
/// - Promotion application tracking
///
/// Official Type: StoreCart extends Omit<BaseCart, "items">
@JsonSerializable(explicitToJson: true)
class StoreCart {
  /// The ID of the cart
  final String id;

  /// The ID of the region the cart belongs to
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// The ID of the associated customer
  @JsonKey(name: 'customer_id')
  final String? customerId;

  /// The ID of the sales channel the cart belongs to
  @JsonKey(name: 'sales_channel_id')
  final String? salesChannelId;

  /// The email of the customer that owns the cart
  final String? email;

  /// The currency of the cart
  @JsonKey(name: 'currency_code')
  final String? currencyCode;

  /// Holds custom data in key-value pairs
  final Map<String, dynamic>? metadata;

  /// When the cart was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the cart was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// When the cart was completed (placed as order)
  @JsonKey(name: 'completed_at')
  final String? completedAt;

  /// The ID of the shipping address
  @JsonKey(name: 'shipping_address_id')
  final String? shippingAddressId;

  // Original totals (before promotions/adjustments)
  @JsonKey(name: 'original_item_total')
  final double? originalItemTotal;

  @JsonKey(name: 'original_item_subtotal')
  final double? originalItemSubtotal;

  @JsonKey(name: 'original_item_tax_total')
  final double? originalItemTaxTotal;

  @JsonKey(name: 'original_total')
  final double? originalTotal;

  @JsonKey(name: 'original_subtotal')
  final double? originalSubtotal;

  @JsonKey(name: 'original_tax_total')
  final double? originalTaxTotal;

  @JsonKey(name: 'original_shipping_total')
  final double? originalShippingTotal;

  @JsonKey(name: 'original_shipping_subtotal')
  final double? originalShippingSubtotal;

  @JsonKey(name: 'original_shipping_tax_total')
  final double? originalShippingTaxTotal;

  // Current totals (after promotions/adjustments)
  @JsonKey(name: 'item_total')
  final double? itemTotal;

  @JsonKey(name: 'item_subtotal')
  final double? itemSubtotal;

  @JsonKey(name: 'item_tax_total')
  final double? itemTaxTotal;

  final double? total;
  final double? subtotal;

  @JsonKey(name: 'tax_total')
  final double? taxTotal;

  @JsonKey(name: 'discount_total')
  final double? discountTotal;

  @JsonKey(name: 'discount_subtotal')
  final double? discountSubtotal;

  @JsonKey(name: 'discount_tax_total')
  final double? discountTaxTotal;

  @JsonKey(name: 'gift_card_total')
  final double? giftCardTotal;

  @JsonKey(name: 'gift_card_tax_total')
  final double? giftCardTaxTotal;

  @JsonKey(name: 'shipping_total')
  final double? shippingTotal;

  @JsonKey(name: 'shipping_subtotal')
  final double? shippingSubtotal;

  @JsonKey(name: 'shipping_tax_total')
  final double? shippingTaxTotal;

  // Credit line totals
  @JsonKey(name: 'credit_line_subtotal')
  final double? creditLineSubtotal;

  @JsonKey(name: 'credit_line_tax_total')
  final double? creditLineTaxTotal;

  @JsonKey(name: 'credit_line_total')
  final double? creditLineTotal;

  // Store-specific associations
  /// The cart's shipping address
  @JsonKey(name: 'shipping_address')
  final StoreCartAddress? shippingAddress;

  /// The cart's billing address
  @JsonKey(name: 'billing_address')
  final StoreCartAddress? billingAddress;

  /// The cart's items
  final List<StoreCartLineItem>? items;

  /// The cart's shipping methods
  @JsonKey(name: 'shipping_methods')
  final List<StoreCartShippingMethod>? shippingMethods;

  /// The cart's payment collection
  @JsonKey(name: 'payment_collection')
  final StorePaymentCollection? paymentCollection;

  /// The cart's region
  final StoreRegion? region;

  /// The customer associated with the cart
  final StoreCustomer? customer;

  /// Credit lines applied to the cart
  @JsonKey(name: 'credit_lines')
  final List<Map<String, dynamic>>? creditLines;

  /// The promotions applied to the cart
  final List<StoreCartPromotion>? promotions;

  const StoreCart({
    required this.id,
    this.regionId,
    this.customerId,
    this.salesChannelId,
    this.email,
    this.currencyCode,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.shippingAddressId,
    this.originalItemTotal,
    this.originalItemSubtotal,
    this.originalItemTaxTotal,
    this.originalTotal,
    this.originalSubtotal,
    this.originalTaxTotal,
    this.originalShippingTotal,
    this.originalShippingSubtotal,
    this.originalShippingTaxTotal,
    this.itemTotal,
    this.itemSubtotal,
    this.itemTaxTotal,
    this.total,
    this.subtotal,
    this.taxTotal,
    this.discountTotal,
    this.discountSubtotal,
    this.discountTaxTotal,
    this.giftCardTotal,
    this.giftCardTaxTotal,
    this.shippingTotal,
    this.shippingSubtotal,
    this.shippingTaxTotal,
    this.creditLineSubtotal,
    this.creditLineTaxTotal,
    this.creditLineTotal,
    this.shippingAddress,
    this.billingAddress,
    this.items,
    this.shippingMethods,
    this.paymentCollection,
    this.region,
    this.customer,
    this.creditLines,
    this.promotions = const [],
  });

  factory StoreCart.fromJson(Map<String, dynamic> json) =>
      _$StoreCartFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartToJson(this);
}

/// StoreCartLineItem - Individual item in a shopping cart
///
/// Represents a product variant added to the cart with quantity and pricing.
/// Includes detailed product/variant information for display and calculation.
///
/// Official Type: StoreCartLineItem extends Omit<BaseCartLineItem, "product" | "variant" | "cart">
@JsonSerializable(explicitToJson: true)
class StoreCartLineItem {
  /// The ID of the line item
  final String id;

  /// The title of the line item
  final String? title;

  /// The subtitle of the line item
  final String? subtitle;

  /// The line item's thumbnail
  final String? thumbnail;

  /// The line item's quantity in the cart
  final int? quantity;

  /// The ID of the associated product
  @JsonKey(name: 'product_id')
  final String? productId;

  /// The ID of the associated product type
  @JsonKey(name: 'product_type_id')
  final String? productTypeId;

  /// The title of the associated product
  @JsonKey(name: 'product_title')
  final String? productTitle;

  /// The description of the associated product
  @JsonKey(name: 'product_description')
  final String? productDescription;

  /// The subtitle of the associated product
  @JsonKey(name: 'product_subtitle')
  final String? productSubtitle;

  /// The type of the associated product
  @JsonKey(name: 'product_type')
  final String? productType;

  /// The collection of the associated product
  @JsonKey(name: 'product_collection')
  final String? productCollection;

  /// The handle of the associated product
  @JsonKey(name: 'product_handle')
  final String? productHandle;

  /// The associated variant's ID of the line item
  @JsonKey(name: 'variant_id')
  final String? variantId;

  /// The sku of the associated variant
  @JsonKey(name: 'variant_sku')
  final String? variantSku;

  /// The barcode of the associated variant
  @JsonKey(name: 'variant_barcode')
  final String? variantBarcode;

  /// The title of the associated variant
  @JsonKey(name: 'variant_title')
  final String? variantTitle;

  /// The option values of the associated variant
  @JsonKey(name: 'variant_option_values', fromJson: _metadataFromJson)
  final Map<String, dynamic>? variantOptionValues;

  /// Whether the line item requires shipping
  @JsonKey(name: 'requires_shipping')
  final bool? requiresShipping;

  /// Whether the line item is discountable
  @JsonKey(name: 'is_discountable')
  final bool? isDiscountable;

  /// Whether the line item price is tax inclusive
  @JsonKey(name: 'is_tax_inclusive')
  final bool? isTaxInclusive;

  /// The calculated price of the line item
  @JsonKey(name: 'compare_at_unit_price')
  final double? compareAtUnitPrice;

  /// The unit price of the item
  @JsonKey(name: 'unit_price')
  final double? unitPrice;

  /// The ID of the associated cart
  @JsonKey(name: 'cart_id')
  final String? cartId;

  /// Holds custom data in key-value pairs
  @JsonKey(fromJson: _metadataFromJson, toJson: _metadataToJson)
  final Map<String, dynamic>? metadata;

  /// When the line item was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the line item was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// When the line item was deleted
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  // Totals (from BaseCartLineItemTotals)
  @JsonKey(name: 'original_total')
  final double? originalTotal;

  @JsonKey(name: 'original_subtotal')
  final double? originalSubtotal;

  @JsonKey(name: 'original_tax_total')
  final double? originalTaxTotal;

  @JsonKey(name: 'item_total')
  final double? itemTotal;

  @JsonKey(name: 'item_subtotal')
  final double? itemSubtotal;

  @JsonKey(name: 'item_tax_total')
  final double? itemTaxTotal;

  final double? total;
  final double? subtotal;

  @JsonKey(name: 'tax_total')
  final double? taxTotal;

  @JsonKey(name: 'discount_total')
  final double? discountTotal;

  @JsonKey(name: 'discount_tax_total')
  final double? discountTaxTotal;

  // Store-specific associations
  /// The product this item is created for
  final StoreProduct? product;

  /// The variant added to the cart
  final StoreProductVariant? variant;

  /// The cart this item belongs to
  final StoreCart? cart;

  /// The item's tax lines
  @JsonKey(name: 'tax_lines')
  final List<StoreLineItemTaxLine>? taxLines;

  /// The item's adjustments
  final List<StoreLineItemAdjustment>? adjustments;

  const StoreCartLineItem({
    required this.id,
    this.title,
    this.subtitle,
    this.thumbnail,
    this.quantity,
    this.productId,
    this.productTypeId,
    this.productTitle,
    this.productDescription,
    this.productSubtitle,
    this.productType,
    this.productCollection,
    this.productHandle,
    this.variantId,
    this.variantSku,
    this.variantBarcode,
    this.variantTitle,
    this.variantOptionValues,
    this.requiresShipping,
    this.isDiscountable,
    this.isTaxInclusive,
    this.compareAtUnitPrice,
    this.unitPrice,
    this.cartId,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.originalTotal,
    this.originalSubtotal,
    this.originalTaxTotal,
    this.itemTotal,
    this.itemSubtotal,
    this.itemTaxTotal,
    this.total,
    this.subtotal,
    this.taxTotal,
    this.discountTotal,
    this.discountTaxTotal,
    this.product,
    this.variant,
    this.cart,
    this.taxLines,
    this.adjustments,
  });

  factory StoreCartLineItem.fromJson(Map<String, dynamic> json) =>
      _$StoreCartLineItemFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartLineItemToJson(this);
}

/// StoreCartAddress - Shipping and billing address for cart
///
/// Store-specific implementation of cart addresses with all required fields
/// for shipping calculation and order processing.
///
/// Official Type: StoreCartAddress extends BaseCartAddress
@JsonSerializable(explicitToJson: true)
class StoreCartAddress {
  /// The ID of the address
  final String id;

  /// The customer ID of the address
  @JsonKey(name: 'customer_id')
  final String? customerId;

  /// The first name of the address
  @JsonKey(name: 'first_name')
  final String? firstName;

  /// The last name of the address
  @JsonKey(name: 'last_name')
  final String? lastName;

  /// The phone number of the address
  final String? phone;

  /// The company of the address
  final String? company;

  /// The first address line of the address
  @JsonKey(name: 'address_1')
  final String? address1;

  /// The second address line of the address
  @JsonKey(name: 'address_2')
  final String? address2;

  /// The city of the address
  final String? city;

  /// The country code of the address
  @JsonKey(name: 'country_code')
  final String? countryCode;

  /// The lower-case ISO 3166-2 province/state of the address
  final String? province;

  /// The postal code of the address (can be numeric or string in API)
  @JsonKey(name: 'postal_code', fromJson: _postalCodeFromJson, toJson: _postalCodeToJson)
  final String? postalCode;

  /// Holds custom data in key-value pairs
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? metadata;

  /// When the address was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the address was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  const StoreCartAddress({
    required this.id,
    this.customerId,
    this.firstName,
    this.lastName,
    this.phone,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.countryCode,
    this.province,
    this.postalCode,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreCartAddress.fromJson(Map<String, dynamic> json) =>
      _$StoreCartAddressFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartAddressToJson(this);
}

/// StoreCartShippingMethod - Shipping method selected for cart
///
/// Represents a shipping option selected for the cart with pricing,
/// tax calculations, and adjustment applications.
///
/// Official Type: StoreCartShippingMethod extends BaseCartShippingMethod
@JsonSerializable(explicitToJson: true)
class StoreCartShippingMethod {
  /// The ID of the shipping method
  final String id;

  /// The ID of the associated cart
  @JsonKey(name: 'cart_id')
  final String? cartId;

  /// The name of the shipping method
  final String? name;

  /// The description of the shipping method
  final String? description;

  /// The price of the shipping method
  final double? amount;

  /// Whether the shipping method price is tax inclusive
  @JsonKey(name: 'is_tax_inclusive')
  final bool? isTaxInclusive;

  /// The ID of the shipping option the method was created from
  @JsonKey(name: 'shipping_option_id')
  final String? shippingOptionId;

  /// Additional data needed for fulfillment
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? data;

  /// Holds custom data in key-value pairs
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? metadata;

  /// When the shipping method was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the shipping method was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  // Totals
  @JsonKey(name: 'original_total')
  final double? originalTotal;

  @JsonKey(name: 'original_subtotal')
  final double? originalSubtotal;

  @JsonKey(name: 'original_tax_total')
  final double? originalTaxTotal;

  final double? total;
  final double? subtotal;

  @JsonKey(name: 'tax_total')
  final double? taxTotal;

  @JsonKey(name: 'discount_total')
  final double? discountTotal;

  @JsonKey(name: 'discount_tax_total')
  final double? discountTaxTotal;

  // Store-specific associations
  /// The shipping method's tax lines
  @JsonKey(name: 'tax_lines')
  final List<StoreShippingMethodTaxLine>? taxLines;

  /// The shipping method's adjustments
  final List<StoreShippingMethodAdjustment>? adjustments;

  const StoreCartShippingMethod({
    required this.id,
    this.cartId,
    this.name,
    this.description,
    this.amount,
    this.isTaxInclusive,
    this.shippingOptionId,
    this.data,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.originalTotal,
    this.originalSubtotal,
    this.originalTaxTotal,
    this.total,
    this.subtotal,
    this.taxTotal,
    this.discountTotal,
    this.discountTaxTotal,
    this.taxLines,
    this.adjustments,
  });

  factory StoreCartShippingMethod.fromJson(Map<String, dynamic> json) =>
      _$StoreCartShippingMethodFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartShippingMethodToJson(this);
}

/// StoreCartPromotion - Promotion applied to cart
///
/// Represents a discount or promotion applied to the cart with
/// application method details and value calculation.
///
/// Official Type: StoreCartPromotion
@JsonSerializable(explicitToJson: true)
class StoreCartPromotion {
  /// The promotion's ID
  final String id;

  /// The promotion's code
  final String? code;

  /// Whether the promotion is applied automatically
  @JsonKey(name: 'is_automatic')
  final bool? isAutomatic;

  /// Whether the promotion is tax inclusive
  @JsonKey(name: 'is_tax_inclusive')
  final bool? isTaxInclusive;

  /// How the promotion is applied
  @JsonKey(name: 'application_method')
  final StorePromotionApplicationMethod? applicationMethod;

  const StoreCartPromotion({
    required this.id,
    this.code,
    this.isAutomatic,
    this.applicationMethod,
    this.isTaxInclusive,
  });

  factory StoreCartPromotion.fromJson(Map<String, dynamic> json) =>
      _$StoreCartPromotionFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartPromotionToJson(this);
}

// Helper function to convert value (can be int or String) to String
String _valueFromJson(dynamic value) {
  if (value is String) return value;
  if (value is num) return value.toString();
  return value.toString();
}

dynamic _valueToJson(String value) => value;

/// StorePromotionApplicationMethod - How a promotion is applied
@JsonSerializable()
class StorePromotionApplicationMethod {
  /// The amount to be discounted (can be numeric or string in API)
  @JsonKey(fromJson: _valueFromJson, toJson: _valueToJson)
  final String value;

  /// The application method's type
  final String type; // ApplicationMethodTypeValues

  /// The currency code of the discount
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  const StorePromotionApplicationMethod({
    required this.value,
    required this.type,
    required this.currencyCode,
  });

  factory StorePromotionApplicationMethod.fromJson(Map<String, dynamic> json) =>
      _$StorePromotionApplicationMethodFromJson(json);
  Map<String, dynamic> toJson() =>
      _$StorePromotionApplicationMethodToJson(this);
}

// =============================================================================
// ORDER MODELS - Order Processing and Fulfillment
// =============================================================================

/// StoreOrder - Completed order from cart checkout
///
/// Represents a finalized order with payment, fulfillment tracking,
/// and detailed item/shipping information.
///
/// Official Type: StoreOrder extends Omit<BaseOrder, "items" | "version" | "transations">
@JsonSerializable(explicitToJson: true)
/// StoreOrder - Completed customer order
///
/// Official Type: HttpTypes.StoreOrder v2.10
@JsonSerializable(explicitToJson: true)
class StoreOrder {
  /// The ID of the order
  final String id;

  /// The display ID of the order
  @JsonKey(name: 'display_id')
  final int? displayId;

  /// The status of the order
  final String status;

  /// The payment status of the order
  @JsonKey(name: 'payment_status')
  final String? paymentStatus;

  /// The fulfillment status of the order
  @JsonKey(name: 'fulfillment_status')
  final String? fulfillmentStatus;

  /// The ID of the region the order belongs to
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// The ID of the associated customer
  @JsonKey(name: 'customer_id')
  final String? customerId;

  /// The ID of the sales channel the order belongs to
  @JsonKey(name: 'sales_channel_id')
  final String? salesChannelId;

  /// The email of the customer
  final String? email;

  /// The currency of the order
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// Holds custom data in key-value pairs
  final Map<String, dynamic>? metadata;

  /// When the order was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the order was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// When the order was canceled
  @JsonKey(name: 'canceled_at')
  final String? canceledAt;

  // Totals and pricing information
  /// The total of the order's items including taxes, excluding promotions
  @JsonKey(name: 'original_item_total')
  final double? originalItemTotal;

  /// The total of the order's items excluding taxes, including promotions
  @JsonKey(name: 'original_item_subtotal')
  final double? originalItemSubtotal;

  /// The tax total applied on the order's items, excluding promotions
  @JsonKey(name: 'original_item_tax_total')
  final double? originalItemTaxTotal;

  /// The total of the order's items including taxes and promotions
  @JsonKey(name: 'item_total')
  final double? itemTotal;

  /// The total of the order's items excluding taxes, including promotions
  @JsonKey(name: 'item_subtotal')
  final double? itemSubtotal;

  /// The tax total applied on the order's items, including promotions
  @JsonKey(name: 'item_tax_total')
  final double? itemTaxTotal;

  /// The promotion total applied on the order's items
  @JsonKey(name: 'item_discount_total')
  final double? itemDiscountTotal;

  /// The total of the order including taxes, excluding promotions
  @JsonKey(name: 'original_total')
  final double? originalTotal;

  /// The total of the order excluding taxes, including promotions
  @JsonKey(name: 'original_subtotal')
  final double? originalSubtotal;

  /// The tax total applied on the order, excluding promotions
  @JsonKey(name: 'original_tax_total')
  final double? originalTaxTotal;

  /// The total of the order including taxes and promotions
  final double? total;

  /// The total of the order excluding taxes, including promotions
  final double? subtotal;

  /// The tax total applied on the order, including promotions
  @JsonKey(name: 'tax_total')
  final double? taxTotal;

  /// The total amount discounted
  @JsonKey(name: 'discount_total')
  final double? discountTotal;

  /// The tax total applied on the order's discounted amount
  @JsonKey(name: 'discount_tax_total')
  final double? discountTaxTotal;

  /// The total gift card amount
  @JsonKey(name: 'gift_card_total')
  final double? giftCardTotal;

  /// The tax total applied on the order's gift card amount
  @JsonKey(name: 'gift_card_tax_total')
  final double? giftCardTaxTotal;

  /// The total of the order's shipping methods including taxes and promotions
  @JsonKey(name: 'shipping_total')
  final double? shippingTotal;

  /// The total of the order's shipping methods excluding taxes, including promotions
  @JsonKey(name: 'shipping_subtotal')
  final double? shippingSubtotal;

  /// The tax total applied on the order's shipping methods, including promotions
  @JsonKey(name: 'shipping_tax_total')
  final double? shippingTaxTotal;

  /// The promotion total applied on the order's shipping methods
  @JsonKey(name: 'shipping_discount_total')
  final double? shippingDiscountTotal;

  /// The total of the order's shipping methods including taxes, excluding promotions
  @JsonKey(name: 'original_shipping_total')
  final double? originalShippingTotal;

  /// The total of the order's shipping methods excluding taxes, including promotions
  @JsonKey(name: 'original_shipping_subtotal')
  final double? originalShippingSubtotal;

  /// The tax total applied on the order's shipping methods, excluding promotions
  @JsonKey(name: 'original_shipping_tax_total')
  final double? originalShippingTaxTotal;

  /// The total of the order's credit lines
  @JsonKey(name: 'credit_line_total')
  final double? creditLineTotal;

  // Store-specific associations
  /// The order's shipping address
  @JsonKey(name: 'shipping_address')
  final StoreOrderAddress? shippingAddress;

  /// The order's billing address
  @JsonKey(name: 'billing_address')
  final StoreOrderAddress? billingAddress;

  /// The order's items
  final List<StoreOrderLineItem>? items;

  /// The order's shipping methods
  @JsonKey(name: 'shipping_methods')
  final List<StoreOrderShippingMethod>? shippingMethods;

  /// The order's payment collections
  @JsonKey(name: 'payment_collections')
  final List<StorePaymentCollection>? paymentCollections;

  /// The order's fulfillments
  final List<StoreOrderFulfillment>? fulfillments;

  /// The order's transactions
  final List<Map<String, dynamic>>? transactions;

  /// The order's summary
  final Map<String, dynamic>? summary;

  /// The customer that placed the order
  final StoreCustomer? customer;

  const StoreOrder({
    required this.id,
    this.displayId,
    required this.status,
    this.paymentStatus,
    this.fulfillmentStatus,
    this.regionId,
    this.customerId,
    this.salesChannelId,
    this.email,
    required this.currencyCode,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.canceledAt,
    this.originalItemTotal,
    this.originalItemSubtotal,
    this.originalItemTaxTotal,
    this.itemTotal,
    this.itemSubtotal,
    this.itemTaxTotal,
    this.itemDiscountTotal,
    this.originalTotal,
    this.originalSubtotal,
    this.originalTaxTotal,
    this.total,
    this.subtotal,
    this.taxTotal,
    this.discountTotal,
    this.discountTaxTotal,
    this.giftCardTotal,
    this.giftCardTaxTotal,
    this.shippingTotal,
    this.shippingSubtotal,
    this.shippingTaxTotal,
    this.shippingDiscountTotal,
    this.originalShippingTotal,
    this.originalShippingSubtotal,
    this.originalShippingTaxTotal,
    this.creditLineTotal,
    this.shippingAddress,
    this.billingAddress,
    this.items,
    this.shippingMethods,
    this.paymentCollections,
    this.fulfillments,
    this.transactions,
    this.summary,
    this.customer,
  });

  factory StoreOrder.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderToJson(this);
}

/// StoreOrderLineItem - Individual item in a completed order
///
/// Official Type: StoreOrderLineItem extends Omit<BaseOrderLineItem, "product" | "variant">
@JsonSerializable(explicitToJson: true)
class StoreOrderLineItem {
  /// The ID of the line item
  final String id;

  /// The title of the line item
  final String title;

  /// The subtitle of the line item
  final String? subtitle;

  /// The line item's thumbnail
  final String? thumbnail;

  /// The variant ID
  @JsonKey(name: 'variant_id')
  final String? variantId;

  /// The product ID
  @JsonKey(name: 'product_id')
  final String? productId;

  /// The product title
  @JsonKey(name: 'product_title')
  final String? productTitle;

  /// The product description
  @JsonKey(name: 'product_description')
  final String? productDescription;

  /// The product subtitle
  @JsonKey(name: 'product_subtitle')
  final String? productSubtitle;

  /// The product handle
  @JsonKey(name: 'product_handle')
  final String? productHandle;

  /// The variant title
  @JsonKey(name: 'variant_title')
  final String? variantTitle;

  /// The variant SKU
  @JsonKey(name: 'variant_sku')
  final String? variantSku;

  /// The variant barcode
  @JsonKey(name: 'variant_barcode')
  final String? variantBarcode;

  /// The product type
  @JsonKey(name: 'product_type')
  final String? productType;

  /// The product type ID
  @JsonKey(name: 'product_type_id')
  final String? productTypeId;

  /// The product collection
  @JsonKey(name: 'product_collection')
  final String? productCollection;

  /// The variant option values
  @JsonKey(name: 'variant_option_values', fromJson: _metadataFromJson)
  final Map<String, dynamic>? variantOptionValues;

  /// Whether the item is a custom price
  @JsonKey(name: 'is_custom_price')
  final bool? isCustomPrice;

  /// Whether the item requires shipping
  @JsonKey(name: 'requires_shipping')
  final bool? requiresShipping;

  /// Whether the item is a gift card
  @JsonKey(name: 'is_giftcard')
  final bool? isGiftcard;

  /// Whether the item is discountable
  @JsonKey(name: 'is_discountable')
  final bool? isDiscountable;

  /// Whether tax is included in price
  @JsonKey(name: 'is_tax_inclusive')
  final bool? isTaxInclusive;

  /// Compare at unit price
  @JsonKey(name: 'compare_at_unit_price')
  final double? compareAtUnitPrice;

  /// The line item's quantity
  final int quantity;

  /// The unit price of the item
  @JsonKey(name: 'unit_price')
  final double unitPrice;

  /// The ID of the associated order
  @JsonKey(name: 'order_id')
  final String? orderId;

  /// Holds custom data in key-value pairs
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? metadata;

  /// When the line item was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the line item was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  // Store-specific associations
  /// The associated product variant
  final StoreProductVariant? variant;

  /// The associated product
  final StoreProduct? product;

  /// The item's tax lines
  @JsonKey(name: 'tax_lines')
  final List<StoreOrderLineItemTaxLine>? taxLines;

  /// The item's adjustments
  final List<StoreOrderLineItemAdjustment>? adjustments;

  /// The item's action details
  final StoreOrderItemDetail? detail;

  const StoreOrderLineItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.thumbnail,
    this.variantId,
    this.productId,
    this.productTitle,
    this.productDescription,
    this.productSubtitle,
    this.productHandle,
    this.variantTitle,
    this.variantSku,
    this.variantBarcode,
    this.productType,
    this.productTypeId,
    this.productCollection,
    this.variantOptionValues,
    this.isCustomPrice,
    this.requiresShipping,
    this.isGiftcard,
    this.isDiscountable,
    this.isTaxInclusive,
    this.compareAtUnitPrice,
    required this.quantity,
    required this.unitPrice,
    this.orderId,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.variant,
    this.product,
    this.taxLines,
    this.adjustments,
    this.detail,
  });

  factory StoreOrderLineItem.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderLineItemFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderLineItemToJson(this);
}

/// StoreOrderAddress - Address information for orders
///
/// Official Type: StoreOrderAddress extends BaseOrderAddress
@JsonSerializable(explicitToJson: true)
class StoreOrderAddress {
  /// The ID of the address
  final String? id;

  /// The customer ID of the address
  @JsonKey(name: 'customer_id')
  final String? customerId;

  /// The first name
  @JsonKey(name: 'first_name')
  final String? firstName;

  /// The last name
  @JsonKey(name: 'last_name')
  final String? lastName;

  /// The phone number
  final String? phone;

  /// The company
  final String? company;

  /// The first address line
  @JsonKey(name: 'address_1')
  final String? address1;

  /// The second address line
  @JsonKey(name: 'address_2')
  final String? address2;

  /// The city
  final String? city;

  /// The country code
  @JsonKey(name: 'country_code')
  final String? countryCode;

  /// The province/state
  final String? province;

  /// The postal code (can be numeric or string in API)
  @JsonKey(name: 'postal_code', fromJson: _postalCodeFromJson, toJson: _postalCodeToJson)
  final String? postalCode;

  /// Holds custom data in key-value pairs
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? metadata;

  /// When the address was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the address was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The address's country
  final StoreRegionCountry? country;

  const StoreOrderAddress({
    this.id,
    this.customerId,
    this.firstName,
    this.lastName,
    this.phone,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.countryCode,
    this.province,
    this.postalCode,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.country,
  });

  factory StoreOrderAddress.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderAddressFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderAddressToJson(this);
}

/// StoreOrderShippingMethod - Shipping method used in order
///
/// Official Type: StoreOrderShippingMethod extends BaseOrderShippingMethod
@JsonSerializable(explicitToJson: true)
class StoreOrderShippingMethod {
  /// The ID of the shipping method
  final String id;

  /// The ID of the associated order
  @JsonKey(name: 'order_id')
  final String? orderId;

  /// The name of the shipping method
  final String? name;

  /// The description of the shipping method
  final String? description;

  /// Whether tax is included in the price
  @JsonKey(name: 'is_tax_inclusive')
  final bool? isTaxInclusive;

  /// Whether this is a custom amount
  @JsonKey(name: 'is_custom_amount')
  final bool? isCustomAmount;

  /// The shipping option ID
  @JsonKey(name: 'shipping_option_id')
  final String? shippingOptionId;

  /// Additional data for the shipping method
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? data;

  /// Custom metadata for the shipping method
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? metadata;

  /// The price of the shipping method
  final double? amount;

  /// When the shipping method was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the shipping method was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The shipping method's tax lines
  @JsonKey(name: 'tax_lines')
  final List<StoreOrderShippingMethodTaxLine>? taxLines;

  /// The shipping method's adjustments
  final List<StoreOrderShippingMethodAdjustment>? adjustments;

  /// The shipping method's details
  final StoreOrderShippingDetail? detail;

  const StoreOrderShippingMethod({
    required this.id,
    this.orderId,
    this.name,
    this.description,
    this.isTaxInclusive,
    this.isCustomAmount,
    this.shippingOptionId,
    this.data,
    this.metadata,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.taxLines,
    this.adjustments,
    this.detail,
  });

  factory StoreOrderShippingMethod.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderShippingMethodFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderShippingMethodToJson(this);
}

/// StoreOrderFulfillment - Order fulfillment tracking
///
/// Official Type: StoreOrderFulfillment extends BaseOrderFulfillment
@JsonSerializable(explicitToJson: true)
class StoreOrderFulfillment {
  /// The fulfillment's ID
  final String id;

  /// The ID of the associated order
  @JsonKey(name: 'order_id')
  final String? orderId;

  /// The ID of the location the items are fulfilled from
  @JsonKey(name: 'location_id')
  final String? locationId;

  /// The date the fulfillment was packed
  @JsonKey(name: 'packed_at')
  final String? packedAt;

  /// The date the fulfillment was shipped
  @JsonKey(name: 'shipped_at')
  final String? shippedAt;

  /// The date the fulfillment was delivered
  @JsonKey(name: 'delivered_at')
  final String? deliveredAt;

  /// The date the fulfillment was canceled
  @JsonKey(name: 'canceled_at')
  final String? canceledAt;

  /// Whether the fulfillment requires shipping
  @JsonKey(name: 'requires_shipping')
  final bool? requiresShipping;

  /// Additional fulfillment data
  final Map<String, dynamic>? data;

  /// The ID of the fulfillment provider handling this fulfillment
  @JsonKey(name: 'provider_id')
  final String? providerId;

  /// The ID of the associated shipping option
  @JsonKey(name: 'shipping_option_id')
  final String? shippingOptionId;

  /// The tracking number
  @JsonKey(name: 'tracking_number')
  final String? trackingNumber;

  /// Key-value pairs of custom data
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? metadata;

  /// When the fulfillment was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the fulfillment was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  const StoreOrderFulfillment({
    required this.id,
    this.orderId,
    this.locationId,
    this.packedAt,
    this.shippedAt,
    this.deliveredAt,
    this.canceledAt,
    this.requiresShipping,
    this.data,
    this.providerId,
    this.shippingOptionId,
    this.trackingNumber,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreOrderFulfillment.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderFulfillmentFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderFulfillmentToJson(this);
}

// =============================================================================
// PAYMENT MODELS - Payment Processing System
// =============================================================================

/// StorePaymentCollection - Payment collection for cart/order
///
/// Manages payment sessions and provider integration for checkout process.
///
/// Official Type: StorePaymentCollection extends BasePaymentCollection
@JsonSerializable(explicitToJson: true)
class StorePaymentCollection {
  /// The ID of the payment collection
  final String id;

  /// The currency code of the payment collection
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// The region ID of the payment collection
  @JsonKey(name: 'region_id')
  final String? regionId;

  /// The amount of the payment collection
  final double amount;

  /// The authorized amount
  @JsonKey(name: 'authorized_amount')
  final double? authorizedAmount;

  /// The captured amount
  @JsonKey(name: 'captured_amount')
  final double? capturedAmount;

  /// The refunded amount
  @JsonKey(name: 'refunded_amount')
  final double? refundedAmount;

  /// The status of the payment collection
  final String? status;

  /// When the payment collection was completed
  @JsonKey(name: 'completed_at')
  final String? completedAt;

  /// Custom metadata for the payment collection
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? metadata;

  /// When the payment collection was created
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the payment collection was updated
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// When the payment collection was deleted
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  /// The payment collection's sessions
  @JsonKey(name: 'payment_sessions')
  final List<StorePaymentSession>? paymentSessions;

  /// The providers used for the payment collection's sessions
  @JsonKey(name: 'payment_providers')
  final List<StorePaymentProvider>? paymentProviders;

  const StorePaymentCollection({
    required this.id,
    required this.currencyCode,
    this.regionId,
    required this.amount,
    this.authorizedAmount,
    this.capturedAmount,
    this.refundedAmount,
    this.status,
    this.completedAt,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.paymentSessions,
    this.paymentProviders,
  });

  factory StorePaymentCollection.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$StorePaymentCollectionToJson(this);
}

/// StorePaymentSession - Individual payment session
///
/// Official Type: StorePaymentSession extends BasePaymentSession
@JsonSerializable(explicitToJson: true)
class StorePaymentSession {
  /// The ID of the payment session
  final String id;

  /// The payment provider ID
  @JsonKey(name: 'provider_id')
  final String providerId;

  /// The currency code
  @JsonKey(name: 'currency_code')
  final String currencyCode;

  /// The amount for this session
  final double amount;

  /// The session data from the provider
  final Map<String, dynamic>? data;

  /// The status of the payment session
  final String status;

  /// When the session was created
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// When the session was updated
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  /// The payment collection that the session belongs to
  @JsonKey(name: 'payment_collection')
  final StorePaymentCollection? paymentCollection;

  const StorePaymentSession({
    required this.id,
    required this.providerId,
    required this.currencyCode,
    required this.amount,
    this.data,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.paymentCollection,
  });

  factory StorePaymentSession.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentSessionFromJson(json);
  Map<String, dynamic> toJson() => _$StorePaymentSessionToJson(this);
}

/// StorePaymentProvider - Payment provider information
///
/// Official Type: StorePaymentProvider extends BasePaymentProvider
@JsonSerializable(explicitToJson: true)
class StorePaymentProvider {
  /// The ID of the payment provider
  final String id;

  /// The name of the payment provider
  final String? name;

  /// Whether the provider is enabled
  @JsonKey(name: 'is_enabled')
  final bool? isEnabled;

  const StorePaymentProvider({required this.id, this.name, this.isEnabled});

  factory StorePaymentProvider.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentProviderFromJson(json);
  Map<String, dynamic> toJson() => _$StorePaymentProviderToJson(this);
}

// =============================================================================
// TAX & ADJUSTMENT MODELS - Pricing Calculation System
// =============================================================================

/// StoreLineItemTaxLine - Tax calculation for line item
@JsonSerializable(explicitToJson: true)
class StoreLineItemTaxLine {
  /// The ID of the tax line
  final String id;

  /// The description of the tax line
  final String? description;

  /// The ID of the associated tax rate
  @JsonKey(name: 'tax_rate_id')
  final String? taxRateId;

  /// The code of the tax line
  final String code;

  /// The rate of the tax line
  final double rate;

  /// The ID of the associated provider
  @JsonKey(name: 'provider_id')
  final String? providerId;

  /// When the tax line was created
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// When the tax line was updated
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  /// The associated line item
  final StoreCartLineItem item;

  /// The ID of the associated line item
  @JsonKey(name: 'item_id')
  final String itemId;

  /// The total tax relative to the item
  final double total;

  /// The subtotal tax relative to the item
  final double subtotal;

  const StoreLineItemTaxLine({
    required this.id,
    this.description,
    this.taxRateId,
    required this.code,
    required this.rate,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    required this.item,
    required this.itemId,
    required this.total,
    required this.subtotal,
  });

  factory StoreLineItemTaxLine.fromJson(Map<String, dynamic> json) =>
      _$StoreLineItemTaxLineFromJson(json);
  Map<String, dynamic> toJson() => _$StoreLineItemTaxLineToJson(this);
}

/// StoreLineItemAdjustment - Price adjustment for line item
@JsonSerializable(explicitToJson: true)
class StoreLineItemAdjustment {
  /// The ID of the adjustment line
  final String id;

  /// The code of the promotion that lead to this adjustment
  final String? code;

  /// The amount to adjust the original amount with
  final double amount;

  /// The ID of the associated cart (nullable in adjustments)
  @JsonKey(name: 'cart_id')
  final String? cartId;

  /// The description of the adjustment line
  final String? description;

  /// The ID of the associated promotion
  @JsonKey(name: 'promotion_id')
  final String? promotionId;

  /// The ID of the associated provider
  @JsonKey(name: 'provider_id')
  final String? providerId;

  /// When the adjustment line was created (nullable in adjustments)
  @JsonKey(name: 'created_at')
  final String? createdAt;

  /// When the adjustment line was updated (nullable in adjustments)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  /// The associated line item (nullable in adjustments)
  final StoreCartLineItem? item;

  /// The ID of the associated line item (nullable in adjustments)
  @JsonKey(name: 'item_id')
  final String? itemId;

  const StoreLineItemAdjustment({
    required this.id,
    this.code,
    required this.amount,
    this.cartId,
    this.description,
    this.promotionId,
    this.providerId,
    this.createdAt,
    this.updatedAt,
    this.item,
    this.itemId,
  });

  factory StoreLineItemAdjustment.fromJson(Map<String, dynamic> json) =>
      _$StoreLineItemAdjustmentFromJson(json);
  Map<String, dynamic> toJson() => _$StoreLineItemAdjustmentToJson(this);
}

/// StoreShippingMethodTaxLine - Tax calculation for shipping method
@JsonSerializable(explicitToJson: true)
class StoreShippingMethodTaxLine {
  /// The ID of the tax line
  final String id;

  /// The description of the tax line
  final String? description;

  /// The ID of the associated tax rate
  @JsonKey(name: 'tax_rate_id')
  final String? taxRateId;

  /// The code of the tax line
  final String code;

  /// The rate of the tax line
  final double rate;

  /// The ID of the associated provider
  @JsonKey(name: 'provider_id')
  final String? providerId;

  /// When the tax line was created
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// When the tax line was updated
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  /// The associated shipping method
  @JsonKey(name: 'shipping_method')
  final StoreCartShippingMethod shippingMethod;

  /// The ID of the associated shipping method
  @JsonKey(name: 'shipping_method_id')
  final String shippingMethodId;

  /// The total tax relative to the shipping method
  final double total;

  /// The subtotal tax relative to the shipping method
  final double subtotal;

  const StoreShippingMethodTaxLine({
    required this.id,
    this.description,
    this.taxRateId,
    required this.code,
    required this.rate,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingMethod,
    required this.shippingMethodId,
    required this.total,
    required this.subtotal,
  });

  factory StoreShippingMethodTaxLine.fromJson(Map<String, dynamic> json) =>
      _$StoreShippingMethodTaxLineFromJson(json);
  Map<String, dynamic> toJson() => _$StoreShippingMethodTaxLineToJson(this);
}

/// StoreShippingMethodAdjustment - Price adjustment for shipping method
@JsonSerializable(explicitToJson: true)
class StoreShippingMethodAdjustment {
  /// The ID of the adjustment line
  final String id;

  /// The code of the promotion that lead to this adjustment
  final String? code;

  /// The amount to adjust the original amount with
  final double amount;

  /// The ID of the associated cart
  @JsonKey(name: 'cart_id')
  final String cartId;

  /// The description of the adjustment line
  final String? description;

  /// The ID of the associated promotion
  @JsonKey(name: 'promotion_id')
  final String? promotionId;

  /// The ID of the associated provider
  @JsonKey(name: 'provider_id')
  final String? providerId;

  /// When the adjustment line was created
  @JsonKey(name: 'created_at')
  final String createdAt;

  /// When the adjustment line was updated
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  /// The associated shipping method
  @JsonKey(name: 'shipping_method')
  final StoreCartShippingMethod shippingMethod;

  /// The ID of the associated shipping method
  @JsonKey(name: 'shipping_method_id')
  final String shippingMethodId;

  const StoreShippingMethodAdjustment({
    required this.id,
    this.code,
    required this.amount,
    required this.cartId,
    this.description,
    this.promotionId,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingMethod,
    required this.shippingMethodId,
  });

  factory StoreShippingMethodAdjustment.fromJson(Map<String, dynamic> json) =>
      _$StoreShippingMethodAdjustmentFromJson(json);
  Map<String, dynamic> toJson() => _$StoreShippingMethodAdjustmentToJson(this);
}

// Order-specific tax lines and adjustments
/// StoreOrderLineItemTaxLine - Tax calculation for order line item
@JsonSerializable(explicitToJson: true)
class StoreOrderLineItemTaxLine {
  final String id;
  final String? description;
  @JsonKey(name: 'tax_rate_id')
  final String? taxRateId;
  final String code;
  final double rate;
  @JsonKey(name: 'provider_id')
  final String? providerId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final StoreOrderLineItem item;
  @JsonKey(name: 'item_id')
  final String itemId;
  final double total;
  final double subtotal;

  const StoreOrderLineItemTaxLine({
    required this.id,
    this.description,
    this.taxRateId,
    required this.code,
    required this.rate,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    required this.item,
    required this.itemId,
    required this.total,
    required this.subtotal,
  });

  factory StoreOrderLineItemTaxLine.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderLineItemTaxLineFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderLineItemTaxLineToJson(this);
}

/// StoreOrderLineItemAdjustment - Price adjustment for order line item
@JsonSerializable(explicitToJson: true)
class StoreOrderLineItemAdjustment {
  final String id;
  final String? code;
  final double amount;
  @JsonKey(name: 'order_id')
  final String orderId;
  final String? description;
  @JsonKey(name: 'promotion_id')
  final String? promotionId;
  @JsonKey(name: 'provider_id')
  final String? providerId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final StoreOrderLineItem item;
  @JsonKey(name: 'item_id')
  final String itemId;

  const StoreOrderLineItemAdjustment({
    required this.id,
    this.code,
    required this.amount,
    required this.orderId,
    this.description,
    this.promotionId,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    required this.item,
    required this.itemId,
  });

  factory StoreOrderLineItemAdjustment.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderLineItemAdjustmentFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderLineItemAdjustmentToJson(this);
}

/// StoreOrderShippingMethodTaxLine - Tax calculation for order shipping method
@JsonSerializable(explicitToJson: true)
class StoreOrderShippingMethodTaxLine {
  final String id;
  final String? description;
  @JsonKey(name: 'tax_rate_id')
  final String? taxRateId;
  final String code;
  final double rate;
  @JsonKey(name: 'provider_id')
  final String? providerId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'shipping_method')
  final StoreOrderShippingMethod shippingMethod;
  @JsonKey(name: 'shipping_method_id')
  final String shippingMethodId;
  final double total;
  final double subtotal;

  const StoreOrderShippingMethodTaxLine({
    required this.id,
    this.description,
    this.taxRateId,
    required this.code,
    required this.rate,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingMethod,
    required this.shippingMethodId,
    required this.total,
    required this.subtotal,
  });

  factory StoreOrderShippingMethodTaxLine.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderShippingMethodTaxLineFromJson(json);
  Map<String, dynamic> toJson() =>
      _$StoreOrderShippingMethodTaxLineToJson(this);
}

/// StoreOrderShippingMethodAdjustment - Price adjustment for order shipping method
@JsonSerializable(explicitToJson: true)
class StoreOrderShippingMethodAdjustment {
  final String id;
  final String? code;
  final double amount;
  @JsonKey(name: 'order_id')
  final String orderId;
  final String? description;
  @JsonKey(name: 'promotion_id')
  final String? promotionId;
  @JsonKey(name: 'provider_id')
  final String? providerId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'shipping_method')
  final StoreOrderShippingMethod shippingMethod;
  @JsonKey(name: 'shipping_method_id')
  final String shippingMethodId;

  const StoreOrderShippingMethodAdjustment({
    required this.id,
    this.code,
    required this.amount,
    required this.orderId,
    this.description,
    this.promotionId,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingMethod,
    required this.shippingMethodId,
  });

  factory StoreOrderShippingMethodAdjustment.fromJson(
    Map<String, dynamic> json,
  ) => _$StoreOrderShippingMethodAdjustmentFromJson(json);
  Map<String, dynamic> toJson() =>
      _$StoreOrderShippingMethodAdjustmentToJson(this);
}

/// StoreOrderItemDetail - Action details for order line item
@JsonSerializable(explicitToJson: true)
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreOrderItemDetail {
  final String id;
  final int? version;
  @JsonKey(fromJson: _metadataFromJson)
  final Map<String, dynamic>? metadata;
  @JsonKey(name: 'order_id')
  final String? orderId;
  @JsonKey(name: 'item_id')
  final String? itemId;
  @JsonKey(name: 'unit_price')
  final double? unitPrice;

  @JsonKey(name: 'compare_at_unit_price')
  final double? compareAtUnitPrice;
  final int? quantity;
  @JsonKey(name: 'fulfilled_quantity')
  final int? fulfilledQuantity;
  @JsonKey(name: 'delivered_quantity')
  final int? deliveredQuantity;
  @JsonKey(name: 'shipped_quantity')
  final int? shippedQuantity;
  @JsonKey(name: 'return_requested_quantity')
  final int? returnRequestedQuantity;
  @JsonKey(name: 'return_received_quantity')
  final int? returnReceivedQuantity;
  @JsonKey(name: 'return_dismissed_quantity')
  final int? returnDismissedQuantity;
  @JsonKey(name: 'written_off_quantity')
  final int? writtenOffQuantity;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  const StoreOrderItemDetail({
    required this.id,
    this.version,
    this.metadata,
    this.orderId,
    this.itemId,
    this.unitPrice,
    this.compareAtUnitPrice,
    this.quantity,
    this.fulfilledQuantity,
    this.deliveredQuantity,
    this.shippedQuantity,
    this.returnRequestedQuantity,
    this.returnReceivedQuantity,
    this.returnDismissedQuantity,
    this.writtenOffQuantity,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StoreOrderItemDetail.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderItemDetailFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderItemDetailToJson(this);
}

/// StoreOrderShippingDetail - Shipping details for order shipping method
@JsonSerializable(explicitToJson: true)
class StoreOrderShippingDetail {
  final String id;
  final int? version;
  @JsonKey(name: 'order_id')
  final String? orderId;
  @JsonKey(name: 'return_id')
  final String? returnId;
  @JsonKey(name: 'exchange_id')
  final String? exchangeId;
  @JsonKey(name: 'claim_id')
  final String? claimId;
  @JsonKey(name: 'shipping_method_id')
  final String shippingMethodId;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  const StoreOrderShippingDetail({
    required this.id,
    this.version,
    this.orderId,
    this.returnId,
    this.exchangeId,
    this.claimId,
    required this.shippingMethodId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory StoreOrderShippingDetail.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderShippingDetailFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderShippingDetailToJson(this);
}

// =============================================================================
// API RESPONSE WRAPPERS
// =============================================================================

/// Response wrapper for single cart operations
@JsonSerializable(explicitToJson: true)
class StoreCartResponse {
  final StoreCart cart;

  const StoreCartResponse({required this.cart});

  factory StoreCartResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreCartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartResponseToJson(this);
}

/// Response wrapper for cart operations with multiple entities
@JsonSerializable(explicitToJson: true)
class StoreCartListResponse {
  final List<StoreCart> carts;
  final int count;
  final int offset;
  final int limit;

  const StoreCartListResponse({
    required this.carts,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory StoreCartListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreCartListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCartListResponseToJson(this);
}

/// Response wrapper for single order operations
@JsonSerializable(explicitToJson: true)
class StoreOrderResponse {
  final StoreOrder order;

  const StoreOrderResponse({required this.order});

  factory StoreOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderResponseToJson(this);
}

/// Response wrapper for order list operations
@JsonSerializable(explicitToJson: true)
class StoreOrderListResponse {
  final List<StoreOrder> orders;
  final int count;
  final int offset;
  final int limit;

  const StoreOrderListResponse({
    required this.orders,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory StoreOrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreOrderListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreOrderListResponseToJson(this);
}

/// Response wrapper for payment collection operations
@JsonSerializable(explicitToJson: true)
class StorePaymentCollectionResponse {
  @JsonKey(name: 'payment_collection')
  final StorePaymentCollection paymentCollection;

  const StorePaymentCollectionResponse({required this.paymentCollection});

  factory StorePaymentCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$StorePaymentCollectionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StorePaymentCollectionResponseToJson(this);
}

// =============================================================================
// CUSTOMER ADDRESS MODELS - Store Customer Address Management
// =============================================================================

/// Response wrapper for customer address list operations
///
/// Official Type: StoreCustomerAddressListResponse from @medusajs/types
@JsonSerializable(explicitToJson: true)
class StoreCustomerAddressListResponse {
  /// The list of customer addresses
  final List<StoreCustomerAddress> addresses;

  /// The total number of addresses available
  final int count;

  /// The number of addresses skipped before retrieving the returned addresses
  final int offset;

  /// The maximum number of addresses returned
  final int limit;

  const StoreCustomerAddressListResponse({
    required this.addresses,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory StoreCustomerAddressListResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$StoreCustomerAddressListResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$StoreCustomerAddressListResponseToJson(this);
}

/// Response wrapper for single customer address operations
///
/// Official Type: StoreCustomerAddressResponse from @medusajs/types
@JsonSerializable(explicitToJson: true)
class StoreCustomerAddressResponse {
  /// The customer address
  final StoreCustomerAddress address;

  const StoreCustomerAddressResponse({required this.address});

  factory StoreCustomerAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreCustomerAddressResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StoreCustomerAddressResponseToJson(this);
}
