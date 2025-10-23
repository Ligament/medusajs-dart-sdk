import 'package:json_annotation/json_annotation.dart';

part 'store_customer_requests.g.dart';

/// StoreCreateCustomer payload from official @medusajs/types v2.10.1
///
/// Extends BaseCreateCustomer with all optional fields
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreCreateCustomer {
  /// The customer's email (required)
  final String email;

  /// The customer's company name
  final String? companyName;

  /// The customer's first name
  final String? firstName;

  /// The customer's last name
  final String? lastName;

  /// The customer's phone number
  final String? phone;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  const StoreCreateCustomer({
    required this.email,
    this.companyName,
    this.firstName,
    this.lastName,
    this.phone,
    this.metadata,
  });

  factory StoreCreateCustomer.fromJson(Map<String, dynamic> json) =>
      _$StoreCreateCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCreateCustomerToJson(this);
}

/// StoreUpdateCustomer payload from official @medusajs/types v2.10.1
///
/// Extends BaseUpdateCustomer with all optional fields
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreUpdateCustomer {
  /// The customer's company name
  final String? companyName;

  /// The customer's first name
  final String? firstName;

  /// The customer's last name
  final String? lastName;

  /// The customer's phone number
  final String? phone;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  const StoreUpdateCustomer({
    this.companyName,
    this.firstName,
    this.lastName,
    this.phone,
    this.metadata,
  });

  factory StoreUpdateCustomer.fromJson(Map<String, dynamic> json) =>
      _$StoreUpdateCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$StoreUpdateCustomerToJson(this);
}

/// StoreCreateCustomerAddress payload from official @medusajs/types v2.10.1
///
/// Extends BaseCreateCustomerAddress with official fields
/// Note: customer_id is NOT included as it's passed in the URL path
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreCreateCustomerAddress {
  /// The address's first name
  final String? firstName;

  /// The address's last name
  final String? lastName;

  /// The address's phone
  final String? phone;

  /// The address's company
  final String? company;

  /// The address's first line (official: address_1)
  @JsonKey(name: 'address_1')
  final String? address1;

  /// The address's second line (official: address_2)
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

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The address's name
  final String? addressName;

  /// Whether the address is used by default for shipping
  final bool? isDefaultShipping;

  /// Whether the address is used by default for billing
  final bool? isDefaultBilling;

  const StoreCreateCustomerAddress({
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
    this.addressName,
    this.isDefaultShipping,
    this.isDefaultBilling,
  });

  factory StoreCreateCustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$StoreCreateCustomerAddressFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCreateCustomerAddressToJson(this);
}

/// StoreUpdateCustomerAddress payload from official @medusajs/types v2.10.1
///
/// Extends BaseUpdateCustomerAddress with all fields optional
@JsonSerializable(fieldRename: FieldRename.snake)
class StoreUpdateCustomerAddress {
  /// The address's first name
  final String? firstName;

  /// The address's last name
  final String? lastName;

  /// The address's phone
  final String? phone;

  /// The address's company
  final String? company;

  /// The address's first line (official: address_1)
  @JsonKey(name: 'address_1')
  final String? address1;

  /// The address's second line (official: address_2)
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

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  /// The address's name
  final String? addressName;

  /// Whether the address is used by default for shipping
  final bool? isDefaultShipping;

  /// Whether the address is used by default for billing
  final bool? isDefaultBilling;

  const StoreUpdateCustomerAddress({
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
    this.addressName,
    this.isDefaultShipping,
    this.isDefaultBilling,
  });

  factory StoreUpdateCustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$StoreUpdateCustomerAddressFromJson(json);

  Map<String, dynamic> toJson() => _$StoreUpdateCustomerAddressToJson(this);
}
