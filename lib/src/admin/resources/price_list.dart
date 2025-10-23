import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin price list resource for managing price lists
///
/// Provides comprehensive price list management capabilities including
/// CRUD operations and batch price management for promotional pricing,
/// customer-specific pricing, and sales campaigns.
class AdminPriceListResource extends AdminResource {
  const AdminPriceListResource(super.client);

  String get resourcePath => '$basePath/price-lists';

  /// List price lists
  ///
  /// Retrieves a list of price lists with pagination support and filtering capabilities.
  ///
  /// Example:
  /// ```dart
  /// final priceLists = await medusa.admin.priceList.list(
  ///   query: {'status': 'active', 'limit': 20}
  /// );
  /// ```
  Future<PaginatedResponse<AdminPriceList>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminPriceList>(
      endpoint: resourcePath,
      dataKey: 'price_lists',
      fromJson: AdminPriceList.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a price list by ID
  ///
  /// Gets detailed information about a specific price list including
  /// all associated prices and rules.
  ///
  /// Example:
  /// ```dart
  /// final priceList = await medusa.admin.priceList.retrieve('pl_123');
  /// ```
  Future<AdminPriceList?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminPriceList>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'price_list',
      fromJson: AdminPriceList.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a price list
  ///
  /// Creates a new price list with the specified configuration.
  /// Supports creating price lists with initial prices.
  ///
  /// Example:
  /// ```dart
  /// final newPriceList = await medusa.admin.priceList.create(
  ///   AdminCreatePriceList(
  ///     title: 'Summer Sale 2024',
  ///     description: 'Special pricing for summer promotion',
  ///     status: AdminPriceListStatus.active,
  ///     type: AdminPriceListType.sale,
  ///   )
  /// );
  /// ```
  Future<AdminPriceList?> create(
    AdminCreatePriceList createRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminPriceList>(
      endpoint: resourcePath,
      body: createRequest.toJson(),
      dataKey: 'price_list',
      fromJson: AdminPriceList.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a price list
  ///
  /// Updates an existing price list with new configuration.
  /// All fields in the update request are optional.
  ///
  /// Example:
  /// ```dart
  /// final updated = await medusa.admin.priceList.update(
  ///   'pl_123',
  ///   AdminUpdatePriceList(
  ///     status: AdminPriceListStatus.draft,
  ///     endsAt: '2024-12-31T23:59:59Z',
  ///   )
  /// );
  /// ```
  Future<AdminPriceList?> update(
    String id,
    AdminUpdatePriceList updateRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminPriceList>(
      id: id,
      endpoint: '$resourcePath/$id',
      body: updateRequest.toJson(),
      dataKey: 'price_list',
      fromJson: AdminPriceList.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a price list
  ///
  /// Removes a price list and all associated prices.
  /// This action cannot be undone.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.priceList.delete('pl_123');
  /// ```
  Future<AdminPriceListDeleteResponse> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await deleteGeneric(
      id: id,
      endpoint: '$resourcePath/$id',
      headers: headers,
    );

    return AdminPriceListDeleteResponse.fromJson(response);
  }
}
