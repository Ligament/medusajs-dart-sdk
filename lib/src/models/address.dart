import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

/// Represents an address in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class Address {
  final String? id;
  final String? customerId;
  final String? company;
  final String? firstName;
  final String? lastName;
  final String? address1;
  final String? address2;
  final String? city;
  final String? countryCode;
  final String? province;
  final String? postalCode;
  final String? phone;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // deletedAt is not in StoreCartAddress, so remove it

  const Address({
    this.id,
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

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  /// Get full name from first and last name
  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    return '$first $last'.trim();
  }

  /// Get formatted address string (null-safe)
  String get formattedAddress {
    final parts =
        <String>[
          if (company != null && company!.isNotEmpty) company!,
          if (address1 != null && address1!.isNotEmpty) address1!,
          if (address2 != null && address2!.isNotEmpty) address2!,
          [
            if (city != null && city!.isNotEmpty) city!,
            if (province != null && province!.isNotEmpty) province!,
            if (postalCode != null && postalCode!.isNotEmpty) postalCode!,
          ].join(', '),
          if (countryCode != null && countryCode!.isNotEmpty)
            countryCode!.toUpperCase(),
        ].where((e) => e.isNotEmpty).toList();
    return parts.join('\n');
  }

  /// Get single line address string (null-safe)
  String get singleLineAddress {
    final parts = <String>[
      if (address1 != null && address1!.isNotEmpty) address1!,
      if (address2 != null && address2!.isNotEmpty) address2!,
      if (city != null && city!.isNotEmpty) city!,
      if (province != null && province!.isNotEmpty) province!,
      if (postalCode != null && postalCode!.isNotEmpty) postalCode!,
      if (countryCode != null && countryCode!.isNotEmpty)
        countryCode!.toUpperCase(),
    ];
    return parts.where((e) => e.isNotEmpty).join(', ');
  }

  /// Check if address has complete information
  bool get isComplete {
    return address1 != null &&
        address1!.isNotEmpty &&
        city != null &&
        city!.isNotEmpty &&
        countryCode != null &&
        countryCode!.isNotEmpty;
  }
}
