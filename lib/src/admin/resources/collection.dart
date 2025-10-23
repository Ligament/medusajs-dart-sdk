import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin product collection management resource
///
/// Manages product collections for organizing and grouping
/// products with shared characteristics or themes.
class AdminCollectionResource extends AdminResource {
  const AdminCollectionResource(super.client);

  String get resourcePath => '$basePath/collections';

  /// List collections
  Future<AdminCollectionListResponse> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      resourcePath,
      query: query,
      headers: headers,
    );

    return AdminCollectionListResponse.fromJson(response);
  }

  /// Retrieve a collection by ID
  Future<AdminCollection?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminCollection>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'collection',
      fromJson: AdminCollection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new collection
  Future<AdminCollection?> create(
    AdminCreateCollection createData, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminCollection>(
      body: createData.toJson(),
      endpoint: resourcePath,
      dataKey: 'collection',
      fromJson: AdminCollection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a collection
  Future<AdminCollection?> update(
    String id,
    AdminUpdateCollection updateData, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminCollection>(
      id: id,
      body: updateData.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'collection',
      fromJson: AdminCollection.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a collection
  Future<AdminCollectionDeleteResponse> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id',
      method: 'DELETE',
      headers: headers,
    );

    return AdminCollectionDeleteResponse.fromJson(response);
  }

  /// Search collections
  Future<AdminCollectionSearchResponse> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    final startTime = DateTime.now();
    final listResponse = await list(query: query, headers: headers);
    final executionTime = DateTime.now().difference(startTime).inMilliseconds;

    return AdminCollectionSearchResponse(
      collections: listResponse.collections,
      totalCount: listResponse.count,
      executionTime: executionTime,
    );
  }

  /// Add products to collection
  Future<AdminCollectionProductBatchResponse?> addProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final batch = AdminCollectionProductBatch(productIds: productIds);

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'POST',
      body: batch.toJson(),
      headers: headers,
    );

    // If response contains batch information, return batch response
    if (response.containsKey('processed') || response.containsKey('failed')) {
      return AdminCollectionProductBatchResponse.fromJson(response);
    }

    // Otherwise, return collection data wrapped in batch response
    final collectionData = response['collection'];
    if (collectionData != null) {
      final collection = AdminCollection.fromJson(
        collectionData as Map<String, dynamic>,
      );
      return AdminCollectionProductBatchResponse(
        collection: collection,
        processed: productIds,
      );
    }

    return null;
  }

  /// Remove products from collection
  Future<AdminCollectionProductBatchResponse?> removeProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final batch = AdminCollectionProductBatch(productIds: productIds);

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'DELETE',
      body: batch.toJson(),
      headers: headers,
    );

    // If response contains batch information, return batch response
    if (response.containsKey('processed') || response.containsKey('failed')) {
      return AdminCollectionProductBatchResponse.fromJson(response);
    }

    // Otherwise, return collection data wrapped in batch response
    final collectionData = response['collection'];
    if (collectionData != null) {
      final collection = AdminCollection.fromJson(
        collectionData as Map<String, dynamic>,
      );
      return AdminCollectionProductBatchResponse(
        collection: collection,
        processed: productIds,
      );
    }

    return null;
  }

  /// Get products in collection
  Future<PaginatedResponse<AdminCollectionProduct>> getProducts(
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
            .map(
              (json) =>
                  AdminCollectionProduct.fromJson(json as Map<String, dynamic>),
            )
            .toList();

    return PaginatedResponse(
      data: products,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }
}
