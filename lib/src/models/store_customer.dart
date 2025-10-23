import 'package:json_annotation/json_annotation.dart';

part 'store_customer.g.dart';

/// StoreCustomer model from official @medusajs/types v2.10.1
///
/// Extends BaseCustomer (omitting created_by) with addresses as StoreCustomerAddress[]
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreCustomer {
  /// The customer's ID
  final String id;

  /// Customer's email address
  final String email;

  /// The ID of the customer's default billing address
  final String? defaultBillingAddressId;

  /// The ID of the customer's default shipping address
  final String? defaultShippingAddressId;

  /// Customer's company name
  final String? companyName;

  /// Customer's first name
  final String? firstName;

  /// Customer's last name
  final String? lastName;

  /// Customer's addresses
  final List<StoreCustomerAddress>? addresses;

  /// Customer's groups (simplified customer response)
  final List<dynamic>? groups;

  /// Customer's phone number
  final String? phone;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date the customer was deleted
  final DateTime? deletedAt;

  /// The date the customer was created
  final DateTime? createdAt;

  /// The date the customer was updated
  final DateTime? updatedAt;

  const StoreCustomer({
    required this.id,
    required this.email,
    this.defaultBillingAddressId,
    this.defaultShippingAddressId,
    this.companyName,
    this.firstName,
    this.lastName,
    this.addresses,
    this.groups,
    this.phone,
    this.metadata,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreCustomer.fromJson(Map<String, dynamic> json) =>
      _$StoreCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCustomerToJson(this);

  @override
  String toString() => 'StoreCustomer(id: $id, email: $email)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreCustomer &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// StoreCustomerAddress model from official @medusajs/types v2.10.1
///
/// Extends BaseCustomerAddress with all official fields using correct naming
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreCustomerAddress {
  /// The address's ID
  final String? id;

  /// The address's name
  final String? addressName;

  /// Whether the address is used by default for shipping
  final bool? isDefaultShipping;

  /// Whether the address is used by default for billing
  final bool? isDefaultBilling;

  /// The ID of the customer this address belongs to
  final String? customerId;

  /// The address's company
  final String? company;

  /// The address's first name
  final String? firstName;

  /// The address's last name
  final String? lastName;

  /// The address's first line (official field name: address_1)
  @JsonKey(name: 'address_1')
  final String? address1;

  /// The address's second line (official field name: address_2)
  @JsonKey(name: 'address_2')
  final String? address2;

  /// The address's city
  final String? city;

  /// The address's country code
  final String? countryCode;

  /// The address's province (lower-case ISO 3166-2)
  final String? province;

  /// The address's postal code
  final String? postalCode;

  /// The address's phone number
  final String? phone;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The date the address was created
  final DateTime? createdAt;

  /// The date the address was updated
  final DateTime? updatedAt;

  const StoreCustomerAddress({
    this.id,
    this.addressName,
    this.isDefaultShipping,
    this.isDefaultBilling,
    this.customerId,
    this.company,
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.countryCode,
    this.province,
    this.postalCode,
    this.phone,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreCustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$StoreCustomerAddressFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCustomerAddressToJson(this);

  @override
  String toString() => 'StoreCustomerAddress(id: $id)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreCustomerAddress &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
