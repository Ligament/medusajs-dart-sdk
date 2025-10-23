import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store region resource for region operations
///
/// Uses Store models from store_infrastructure.dart
/// for 100% @medusajs/types v2.10.1 compatibility
class StoreRegionResource extends StoreResource {
  const StoreRegionResource(super.client);

  String get resourcePath => '$basePath/regions';

  /// List regions
  Future<PaginatedResponse<StoreRegion>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<StoreRegion>(
      endpoint: resourcePath,
      dataKey: 'regions',
      fromJson: StoreRegion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a region by ID
  Future<StoreRegion?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<StoreRegion>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'region',
      fromJson: StoreRegion.fromJson,
      query: query,
      headers: headers,
    );
  }
}
