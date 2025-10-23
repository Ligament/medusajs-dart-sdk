import 'package:json_annotation/json_annotation.dart';

part 'admin_customer.g.dart';

/// AdminCustomer model from official @medusajs/types v2.10.1
///
/// Admin-specific customer model with comprehensive customer management capabilities.
/// Extends BaseCustomer with admin-specific fields, metadata, and relationships.
///
/// Key features:
/// - Complete customer profile management
/// - Address and billing information
/// - Customer group associations
/// - Admin-specific metadata and tracking
///
/// Official Type: AdminCustomer extends BaseCustomer
@JsonSerializable(explicitToJson: true)
class AdminCustomer {
  /// The customer's ID
  final String id;

  /// The customer's email address
  final String email;

  /// The customer's first name
  @JsonKey(name: 'first_name')
  final String? firstName;

  /// The customer's last name
  @JsonKey(name: 'last_name')
  final String? lastName;

  /// The customer's phone number
  final String? phone;

  /// Whether the customer has an account
  @JsonKey(name: 'has_account')
  final bool hasAccount;

  /// The customer group IDs
  @JsonKey(name: 'group_ids')
  final List<String>? groupIds;

  /// Customer groups (expanded relationship)
  final List<CustomerGroup>? groups;

  /// Customer addresses
  final List<CustomerAddress>? addresses;

  /// Default billing address ID
  @JsonKey(name: 'default_billing_address_id')
  final String? defaultBillingAddressId;

  /// Default shipping address ID
  @JsonKey(name: 'default_shipping_address_id')
  final String? defaultShippingAddressId;

  /// Default billing address (expanded relationship)
  @JsonKey(name: 'default_billing_address')
  final CustomerAddress? defaultBillingAddress;

  /// Default shipping address (expanded relationship)
  @JsonKey(name: 'default_shipping_address')
  final CustomerAddress? defaultShippingAddress;

  /// Customer orders (expanded relationship) - IDs only to avoid circular references
  @JsonKey(name: 'order_ids')
  final List<String>? orderIds;

  /// Custom attributes and metadata
  final Map<String, dynamic>? metadata;

  /// When the customer was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the customer was last updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// When the customer was deleted (if soft deleted)
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  /// Who created this customer record
  @JsonKey(name: 'created_by')
  final String? createdBy;

  const AdminCustomer({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    required this.hasAccount,
    this.groupIds,
    this.groups,
    this.addresses,
    this.defaultBillingAddressId,
    this.defaultShippingAddressId,
    this.defaultBillingAddress,
    this.defaultShippingAddress,
    this.orderIds,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.createdBy,
  });

  factory AdminCustomer.fromJson(Map<String, dynamic> json) =>
      _$AdminCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCustomerToJson(this);
}

/// Customer Group for admin customer management
@JsonSerializable(explicitToJson: true)
class CustomerGroup {
  /// The customer group's ID
  final String id;

  /// The customer group's name
  final String name;

  /// The customer group's metadata
  final Map<String, dynamic>? metadata;

  /// When the customer group was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the customer group was last updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const CustomerGroup({
    required this.id,
    required this.name,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerGroup.fromJson(Map<String, dynamic> json) =>
      _$CustomerGroupFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerGroupToJson(this);
}

/// Customer Address for admin customer management
@JsonSerializable(explicitToJson: true)
class CustomerAddress {
  /// The address ID
  final String id;

  /// The customer ID this address belongs to
  @JsonKey(name: 'customer_id')
  final String customerId;

  /// Company name
  final String? company;

  /// First name
  @JsonKey(name: 'first_name')
  final String? firstName;

  /// Last name
  @JsonKey(name: 'last_name')
  final String? lastName;

  /// Address line 1
  @JsonKey(name: 'address_1')
  final String? address1;

  /// Address line 2
  @JsonKey(name: 'address_2')
  final String? address2;

  /// City
  final String? city;

  /// Country code (ISO 2 letter)
  @JsonKey(name: 'country_code')
  final String? countryCode;

  /// Province/state
  final String? province;

  /// Postal/zip code
  @JsonKey(name: 'postal_code')
  final String? postalCode;

  /// Phone number
  final String? phone;

  /// Address metadata
  final Map<String, dynamic>? metadata;

  /// When the address was created
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// When the address was last updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const CustomerAddress({
    required this.id,
    required this.customerId,
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerAddressToJson(this);
}
