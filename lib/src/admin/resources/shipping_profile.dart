import '../../resources/base_resource.dart';
import '../../models/models.dart' hide ShippingOption;
import '../../types/types.dart';
import '../../models/fulfillment.dart' show ShippingProfile, ShippingOption;

/// Admin shipping profile management resource
class AdminShippingProfileResource extends AdminResource {
  const AdminShippingProfileResource(super.client);

  String get resourcePath => '$basePath/shipping-profiles';

  /// List shipping profiles
  Future<PaginatedResponse<ShippingProfile>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<ShippingProfile>(
      endpoint: resourcePath,
      dataKey: 'shipping_profiles',
      fromJson: ShippingProfile.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a shipping profile by ID
  Future<ShippingProfile?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<ShippingProfile>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'shipping_profile',
      fromJson: ShippingProfile.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new shipping profile
  Future<ShippingProfile?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<ShippingProfile>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'shipping_profile',
      fromJson: ShippingProfile.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a shipping profile
  Future<ShippingProfile?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<ShippingProfile>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'shipping_profile',
      fromJson: ShippingProfile.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a shipping profile
  Future<Map<String, dynamic>> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    return await deleteGeneric(
      id: id,
      endpoint: '$resourcePath/$id',
      headers: headers,
    );
  }

  /// Get shipping profile by type
  Future<PaginatedResponse<ShippingProfile>> byType(
    String type, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['type'] = type;

    return list(query: query, headers: headers);
  }

  /// Get shipping options for a shipping profile
  Future<PaginatedResponse<ShippingOption>> getShippingOptions(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<ShippingOption>(
      endpoint: '$resourcePath/$id/shipping-options',
      dataKey: 'shipping_options',
      fromJson: ShippingOption.fromJson,
      query: query,
      headers: headers,
    );
  }
}
