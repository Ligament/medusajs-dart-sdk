import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin product category management resource
///
/// Manages hierarchical product categories for organizing products
/// with support for parent-child relationships, visibility controls, and ranking.
class AdminCategoryResource extends AdminResource {
  const AdminCategoryResource(super.client);

  String get resourcePath => '$basePath/product-categories';

  /// List categories
  Future<AdminProductCategoryListResponse> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      resourcePath,
      query: query,
      headers: headers,
    );

    return AdminProductCategoryListResponse.fromJson(response);
  }

  /// Retrieve a category by ID
  Future<AdminProductCategory?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminProductCategory>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'product_category',
      fromJson: AdminProductCategory.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new category
  Future<AdminProductCategory?> create(
    AdminCreateProductCategory createData, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminProductCategory>(
      body: createData.toJson(),
      endpoint: resourcePath,
      dataKey: 'product_category',
      fromJson: AdminProductCategory.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a category
  Future<AdminProductCategory?> update(
    String id,
    AdminUpdateProductCategory updateData, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminProductCategory>(
      id: id,
      body: updateData.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'product_category',
      fromJson: AdminProductCategory.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a category
  Future<AdminProductCategoryDeleteResponse> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id',
      method: 'DELETE',
      headers: headers,
    );

    return AdminProductCategoryDeleteResponse.fromJson(response);
  }

  /// Search categories
  Future<AdminCategorySearchResponse> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    final startTime = DateTime.now();
    final listResponse = await list(query: query, headers: headers);
    final executionTime = DateTime.now().difference(startTime).inMilliseconds;

    return AdminCategorySearchResponse(
      categories: listResponse.productCategories,
      totalCount: listResponse.count,
      executionTime: executionTime,
    );
  }

  /// Get child categories
  Future<AdminProductCategoryListResponse> getChildren(
    String parentId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['parent_category_id'] = parentId;

    return list(query: query, headers: headers);
  }

  /// Get root categories (no parent)
  Future<AdminProductCategoryListResponse> getRoots({
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['parent_category_id'] = 'null';

    return list(query: query, headers: headers);
  }

  /// Add products to category
  Future<AdminCategoryProductBatchResponse?> addProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final batch = AdminCategoryProductBatch(productIds: productIds);

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'POST',
      body: batch.toJson(),
      headers: headers,
    );

    // If response contains batch information, return batch response
    if (response.containsKey('processed') || response.containsKey('failed')) {
      return AdminCategoryProductBatchResponse.fromJson(response);
    }

    // Otherwise, return category data wrapped in batch response
    final categoryData = response['product_category'];
    if (categoryData != null) {
      final category = AdminProductCategory.fromJson(
        categoryData as Map<String, dynamic>,
      );
      return AdminCategoryProductBatchResponse(
        productCategory: category,
        processed: productIds,
      );
    }

    return null;
  }

  /// Remove products from category
  Future<AdminCategoryProductBatchResponse?> removeProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final batch = AdminCategoryProductBatch(productIds: productIds);

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'DELETE',
      body: batch.toJson(),
      headers: headers,
    );

    // If response contains batch information, return batch response
    if (response.containsKey('processed') || response.containsKey('failed')) {
      return AdminCategoryProductBatchResponse.fromJson(response);
    }

    // Otherwise, return category data wrapped in batch response
    final categoryData = response['product_category'];
    if (categoryData != null) {
      final category = AdminProductCategory.fromJson(
        categoryData as Map<String, dynamic>,
      );
      return AdminCategoryProductBatchResponse(
        productCategory: category,
        processed: productIds,
      );
    }

    return null;
  }

  /// Get products in category
  Future<PaginatedResponse<AdminCategoryProduct>> getProducts(
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
                  AdminCategoryProduct.fromJson(json as Map<String, dynamic>),
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
