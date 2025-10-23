import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store product resource for customer-facing product operations
///
/// Uses Store models from store_product.dart
/// for 100% @medusajs/types v2.10.1 compatibility
class StoreProductResource extends StoreResource {
  const StoreProductResource(super.client);

  String get resourcePath => '$basePath/products';

  /// List products
  Future<PaginatedResponse<StoreProduct>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<StoreProduct>(
      endpoint: resourcePath,
      dataKey: 'products',
      fromJson: StoreProduct.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a product by ID
  Future<StoreProduct?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<StoreProduct>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'product',
      fromJson: StoreProduct.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Search products
  Future<PaginatedResponse<StoreProduct>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }

  /// Get products by category
  Future<PaginatedResponse<StoreProduct>> byCategory(
    String categoryId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['category_id'] = categoryId;

    return list(query: query, headers: headers);
  }

  /// Get products by collection
  Future<PaginatedResponse<StoreProduct>> byCollection(
    String collectionId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['collection_id'] = collectionId;

    return list(query: query, headers: headers);
  }

  /// Get products in price range
  Future<PaginatedResponse<StoreProduct>> inPriceRange(
    double minPrice,
    double maxPrice, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['price_gte'] = minPrice;
    query['price_lte'] = maxPrice;

    return list(query: query, headers: headers);
  }

  /// Get featured products
  Future<PaginatedResponse<StoreProduct>> featured({
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['is_featured'] = true;

    return list(query: query, headers: headers);
  }
}
