import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store collection resource for browsing collections
///
/// Provides customer-facing collection functionality for browsing
/// and discovering product collections.
class StoreCollectionResource extends StoreResource {
  const StoreCollectionResource(super.client);

  String get resourcePath => '$basePath/collections';

  /// List collections
  Future<PaginatedResponse<StoreCollection>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<StoreCollection>(
      endpoint: resourcePath,
      dataKey: 'collections',
      fromJson: StoreCollection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a collection by ID
  Future<StoreCollection?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<StoreCollection>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'collection',
      fromJson: StoreCollection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Get products in collection
  Future<PaginatedResponse<StoreProduct>> getProducts(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products',
      query: query,
      headers: headers,
    );

    final products =
        (response['products'] as List? ?? [])
            .map((json) => StoreProduct.fromJson(json as Map<String, dynamic>))
            .toList();

    return PaginatedResponse(
      data: products,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Search collections
  Future<PaginatedResponse<StoreCollection>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }
}
