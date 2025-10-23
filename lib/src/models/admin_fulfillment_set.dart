/// Canonical Admin Fulfillment Set models based on @medusajs/types v2.10.1
///
/// Provides fulfillment set management functionality with complete
/// API compatibility and type safety.

import 'package:json_annotation/json_annotation.dart';

part 'admin_fulfillment_set.g.dart';

// =============================================================================
// FULFILLMENT SET MODELS (Canonical v2.10.1)
// =============================================================================

/// Geo zone type enumeration
enum GeoZoneType {
  @JsonValue('country')
  country,
  @JsonValue('province')
  province,
  @JsonValue('city')
  city,
  @JsonValue('zip')
  zip,
}

/// Admin geo zone as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminGeoZone {
  /// The geo zone's ID
  final String id;

  /// The geo zone's type
  final GeoZoneType type;

  /// The geo zone's country code
  final String countryCode;

  /// The geo zone's lower-case ISO 3166-2 province code
  final String? provinceCode;

  /// The geo zone's city
  final String? city;

  /// The geo zone's postal expression
  final Map<String, dynamic>? postalExpression;

  /// The date the geo zone was created
  final DateTime createdAt;

  /// The date the geo zone was updated
  final DateTime updatedAt;

  /// The date the geo zone was deleted
  final DateTime? deletedAt;

  const AdminGeoZone({
    required this.id,
    required this.type,
    required this.countryCode,
    this.provinceCode,
    this.city,
    this.postalExpression,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminGeoZone.fromJson(Map<String, dynamic> json) =>
      _$AdminGeoZoneFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGeoZoneToJson(this);
}

/// Admin service zone as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminServiceZone {
  /// The service zone's ID
  final String id;

  /// The service zone's name
  final String name;

  /// The ID of the fulfillment set this service zone belongs to
  final String fulfillmentSetId;

  /// The fulfillment set this service zone belongs to
  final AdminFulfillmentSet? fulfillmentSet;

  /// The service zone's geo zones
  final List<AdminGeoZone>? geoZones;

  /// The shipping options that can be used in this service zone
  final List<Map<String, dynamic>>? shippingOptions;

  /// The date the service zone is created
  final DateTime createdAt;

  /// The date the service zone is updated
  final DateTime updatedAt;

  /// The date the service zone is deleted
  final DateTime? deletedAt;

  const AdminServiceZone({
    required this.id,
    required this.name,
    required this.fulfillmentSetId,
    this.fulfillmentSet,
    this.geoZones,
    this.shippingOptions,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminServiceZone.fromJson(Map<String, dynamic> json) =>
      _$AdminServiceZoneFromJson(json);

  Map<String, dynamic> toJson() => _$AdminServiceZoneToJson(this);
}

/// Admin fulfillment set as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentSet {
  /// The fulfillment set's ID
  final String id;

  /// The fulfillment set's name
  final String name;

  /// The fulfillment set's type
  final String type;

  /// The stock location associated with this fulfillment set
  final Map<String, dynamic>? location;

  /// The fulfillment set's service zones
  final List<AdminServiceZone>? serviceZones;

  /// The date the fulfillment set is created
  final DateTime createdAt;

  /// The date the fulfillment set is updated
  final DateTime updatedAt;

  /// The date the fulfillment set is deleted
  final DateTime? deletedAt;

  const AdminFulfillmentSet({
    required this.id,
    required this.name,
    required this.type,
    this.location,
    this.serviceZones,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminFulfillmentSet.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentSetFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentSetToJson(this);
}

// =============================================================================
// FULFILLMENT SET PAYLOADS (CRUD Operations)
// =============================================================================

/// Base upsert geo zone interface
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpsertGeoZone {
  /// The geo zone's type
  final GeoZoneType type;

  /// The geo zone's country code
  final String countryCode;

  /// Key-value pairs of custom data
  final Map<String, dynamic>? metadata;

  const AdminUpsertGeoZone({
    required this.type,
    required this.countryCode,
    this.metadata,
  });

  factory AdminUpsertGeoZone.fromJson(Map<String, dynamic> json) =>
      _$AdminUpsertGeoZoneFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpsertGeoZoneToJson(this);
}

/// Country geo zone for fulfillment set service zone
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpsertFulfillmentSetServiceZoneCountry extends AdminUpsertGeoZone {
  const AdminUpsertFulfillmentSetServiceZoneCountry({
    required super.countryCode,
    super.metadata,
  }) : super(type: GeoZoneType.country);

  factory AdminUpsertFulfillmentSetServiceZoneCountry.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpsertFulfillmentSetServiceZoneCountryFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpsertFulfillmentSetServiceZoneCountryToJson(this);
}

/// Province geo zone for fulfillment set service zone
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpsertFulfillmentSetServiceZoneProvince extends AdminUpsertGeoZone {
  /// The geo zone's lower-case ISO 3166-2 province code
  final String provinceCode;

  const AdminUpsertFulfillmentSetServiceZoneProvince({
    required super.countryCode,
    required this.provinceCode,
    super.metadata,
  }) : super(type: GeoZoneType.province);

  factory AdminUpsertFulfillmentSetServiceZoneProvince.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpsertFulfillmentSetServiceZoneProvinceFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpsertFulfillmentSetServiceZoneProvinceToJson(this);
}

/// City geo zone for fulfillment set service zone
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpsertFulfillmentSetServiceZoneCity extends AdminUpsertGeoZone {
  /// The geo zone's lower-case ISO 3166-2 province code
  final String provinceCode;

  /// The geo zone's city
  final String city;

  const AdminUpsertFulfillmentSetServiceZoneCity({
    required super.countryCode,
    required this.provinceCode,
    required this.city,
    super.metadata,
  }) : super(type: GeoZoneType.city);

  factory AdminUpsertFulfillmentSetServiceZoneCity.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpsertFulfillmentSetServiceZoneCityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpsertFulfillmentSetServiceZoneCityToJson(this);
}

/// ZIP geo zone for fulfillment set service zone
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpsertFulfillmentSetServiceZoneZip extends AdminUpsertGeoZone {
  /// The geo zone's lower-case ISO 3166-2 province code
  final String provinceCode;

  /// The geo zone's city
  final String city;

  /// The geo zone's postal expression or ZIP code
  final Map<String, dynamic> postalExpression;

  const AdminUpsertFulfillmentSetServiceZoneZip({
    required super.countryCode,
    required this.provinceCode,
    required this.city,
    required this.postalExpression,
    super.metadata,
  }) : super(type: GeoZoneType.zip);

  factory AdminUpsertFulfillmentSetServiceZoneZip.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpsertFulfillmentSetServiceZoneZipFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpsertFulfillmentSetServiceZoneZipToJson(this);
}

/// Create fulfillment set service zone payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateFulfillmentSetServiceZone {
  /// The service zone's name
  final String name;

  /// The service zone's geo zones to restrict it to specific geographical locations
  final List<Map<String, dynamic>> geoZones;

  const AdminCreateFulfillmentSetServiceZone({
    required this.name,
    required this.geoZones,
  });

  factory AdminCreateFulfillmentSetServiceZone.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCreateFulfillmentSetServiceZoneFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminCreateFulfillmentSetServiceZoneToJson(this);
}

/// Update fulfillment set service zone payload
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateFulfillmentSetServiceZone {
  /// The service zone's name
  final String? name;

  /// The service zone's geo zones to restrict it to specific geographical locations
  final List<Map<String, dynamic>>? geoZones;

  const AdminUpdateFulfillmentSetServiceZone({this.name, this.geoZones});

  factory AdminUpdateFulfillmentSetServiceZone.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminUpdateFulfillmentSetServiceZoneFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpdateFulfillmentSetServiceZoneToJson(this);
}

// =============================================================================
// FULFILLMENT SET RESPONSES
// =============================================================================

/// Admin service zone response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminServiceZoneResponse {
  /// The service zone's details
  final AdminServiceZone serviceZone;

  const AdminServiceZoneResponse({required this.serviceZone});

  factory AdminServiceZoneResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminServiceZoneResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminServiceZoneResponseToJson(this);
}

/// Admin service zone delete response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminServiceZoneDeleteResponse {
  /// The ID of the deleted service zone
  final String id;

  /// The type of object that was deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  /// The parent fulfillment set
  final AdminFulfillmentSet? parent;

  const AdminServiceZoneDeleteResponse({
    required this.id,
    this.object = 'service_zone',
    this.deleted = true,
    this.parent,
  });

  factory AdminServiceZoneDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminServiceZoneDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminServiceZoneDeleteResponseToJson(this);
}

/// Admin fulfillment set response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentSetResponse {
  /// The fulfillment set's details
  final AdminFulfillmentSet fulfillmentSet;

  const AdminFulfillmentSetResponse({required this.fulfillmentSet});

  factory AdminFulfillmentSetResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminFulfillmentSetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminFulfillmentSetResponseToJson(this);
}

/// Admin fulfillment set delete response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminFulfillmentSetDeleteResponse {
  /// The ID of the deleted fulfillment set
  final String id;

  /// The type of object that was deleted
  final String object;

  /// Whether the deletion was successful
  final bool deleted;

  const AdminFulfillmentSetDeleteResponse({
    required this.id,
    this.object = 'fulfillment_set',
    this.deleted = true,
  });

  factory AdminFulfillmentSetDeleteResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminFulfillmentSetDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminFulfillmentSetDeleteResponseToJson(this);
}
