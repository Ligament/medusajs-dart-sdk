import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin stock location management resource
class AdminStockLocationResource extends AdminResource {
  const AdminStockLocationResource(super.client);

  String get resourcePath => '$basePath/stock-locations';

  /// List stock locations
  Future<PaginatedResponse<AdminStockLocation>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminStockLocation>(
      endpoint: resourcePath,
      dataKey: 'stock_locations',
      fromJson: AdminStockLocation.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a stock location by ID
  Future<AdminStockLocation?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminStockLocation>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'stock_location',
      fromJson: AdminStockLocation.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new stock location
  Future<AdminStockLocation?> create(
    AdminCreateStockLocation body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminStockLocation>(
      body: body.toJson(),
      endpoint: resourcePath,
      dataKey: 'stock_location',
      fromJson: AdminStockLocation.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a stock location
  Future<AdminStockLocation?> update(
    String id,
    AdminUpdateStockLocation body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminStockLocation>(
      id: id,
      body: body.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'stock_location',
      fromJson: AdminStockLocation.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a stock location
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

  /// Get inventory levels for a stock location
  Future<PaginatedResponse<AdminInventoryLevel>> getInventoryLevels(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/inventory-levels',
      query: query,
      headers: headers,
    );

    final items =
        (response['inventory_levels'] as List? ?? [])
            .map(
              (json) =>
                  AdminInventoryLevel.fromJson(json as Map<String, dynamic>),
            )
            .toList();

    return PaginatedResponse(
      data: items,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Update inventory level for a stock location
  Future<AdminInventoryLevel?> updateInventoryLevel(
    String id,
    String inventoryItemId,
    AdminUpdateInventoryLevel body, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/inventory-levels/$inventoryItemId',
      method: 'POST',
      body: body.toJson(),
      headers: headers,
    );

    final inventoryLevel = response['inventory_level'];
    return inventoryLevel != null
        ? AdminInventoryLevel.fromJson(inventoryLevel as Map<String, dynamic>)
        : null;
  }

  /// Get fulfillment sets for a stock location
  Future<PaginatedResponse<Map<String, dynamic>>> getFulfillmentSets(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillment-sets',
      query: query,
      headers: headers,
    );

    final items =
        (response['fulfillment_sets'] as List? ?? [])
            .map((json) => json as Map<String, dynamic>)
            .toList();

    return PaginatedResponse(
      data: items,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Add fulfillment set to stock location
  Future<Map<String, dynamic>> addFulfillmentSet(
    String id,
    String fulfillmentSetId, {
    ClientHeaders? headers,
  }) async {
    final request = AdminAddFulfillmentSetRequest(
      fulfillmentSetId: fulfillmentSetId,
    );
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillment-sets',
      method: 'POST',
      body: request.toJson(),
      headers: headers,
    );
  }

  /// Remove fulfillment set from stock location
  Future<Map<String, dynamic>> removeFulfillmentSet(
    String id,
    String fulfillmentSetId, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillment-sets/$fulfillmentSetId',
      method: 'DELETE',
      headers: headers,
    );
  }
}
