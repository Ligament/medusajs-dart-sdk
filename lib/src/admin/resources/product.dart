import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin product management resource
///
/// Uses AdminProduct model from @medusajs/types v2.10.1
/// for enhanced admin-specific product management capabilities.
class AdminProductResource extends AdminResource {
  const AdminProductResource(super.client);

  String get resourcePath => '$basePath/products';

  /// List products
  Future<PaginatedResponse<AdminProduct>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminProduct>(
      endpoint: resourcePath,
      dataKey: 'products',
      fromJson: AdminProduct.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a product by ID
  Future<AdminProduct?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminProduct>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'product',
      fromJson: AdminProduct.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new product
  Future<AdminProduct?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminProduct>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'product',
      fromJson: AdminProduct.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a product
  Future<AdminProduct?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminProduct>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'product',
      fromJson: AdminProduct.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a product
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

  /// Search products
  Future<PaginatedResponse<AdminProduct>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }

  /// Get products by category
  Future<PaginatedResponse<AdminProduct>> byCategory(
    String categoryId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['category_id'] = categoryId;

    return list(query: query, headers: headers);
  }

  /// Get products by collection
  Future<PaginatedResponse<AdminProduct>> byCollection(
    String collectionId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['collection_id'] = collectionId;

    return list(query: query, headers: headers);
  }
}
