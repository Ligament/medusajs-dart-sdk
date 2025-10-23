import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store category resource for browsing product categories
///
/// Provides customer-facing category functionality for browsing
/// and discovering product categories.
class StoreCategoryResource extends StoreResource {
  const StoreCategoryResource(super.client);

  String get resourcePath => '$basePath/product-categories';

  /// List categories
  Future<PaginatedResponse<StoreProductCategory>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<StoreProductCategory>(
      endpoint: resourcePath,
      dataKey: 'product_categories',
      fromJson: StoreProductCategory.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a category by ID
  Future<StoreProductCategory?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<StoreProductCategory>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'product_category',
      fromJson: StoreProductCategory.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Get products in category
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

  /// Get child categories
  Future<PaginatedResponse<StoreProductCategory>> getChildren(
    String parentId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['parent_category_id'] = parentId;

    return list(query: query, headers: headers);
  }

  /// Get root categories (no parent)
  Future<PaginatedResponse<StoreProductCategory>> getRoots({
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['parent_category_id'] = 'null';

    return list(query: query, headers: headers);
  }

  /// Search categories
  Future<PaginatedResponse<StoreProductCategory>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }
}
