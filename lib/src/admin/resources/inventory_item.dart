import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin inventory item resource for managing inventory items
class AdminInventoryItemResource extends AdminResource {
  const AdminInventoryItemResource(super.client);

  String get resourcePath => '$basePath/inventory-items';

  /// List inventory items
  Future<PaginatedResponse<AdminInventoryItem>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminInventoryItem>(
      endpoint: resourcePath,
      dataKey: 'inventory_items',
      fromJson: AdminInventoryItem.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve an inventory item by ID
  Future<AdminInventoryItem?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminInventoryItem>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'inventory_item',
      fromJson: AdminInventoryItem.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create an inventory item
  Future<AdminInventoryItem?> create(
    AdminCreateInventoryItem body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminInventoryItem>(
      endpoint: resourcePath,
      body: body.toJson(),
      dataKey: 'inventory_item',
      fromJson: AdminInventoryItem.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update an inventory item
  Future<AdminInventoryItem?> update(
    String id,
    AdminUpdateInventoryItem body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminInventoryItem>(
      id: id,
      endpoint: '$resourcePath/$id',
      body: body.toJson(),
      dataKey: 'inventory_item',
      fromJson: AdminInventoryItem.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete an inventory item
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

  /// Get inventory levels for an item
  Future<PaginatedResponse<AdminInventoryLevel>> getInventoryLevels(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/location-levels',
      query: query,
      headers: headers,
    );

    final levels =
        (response['inventory_levels'] as List? ?? [])
            .map(
              (json) =>
                  AdminInventoryLevel.fromJson(json as Map<String, dynamic>),
            )
            .toList();

    return PaginatedResponse(
      data: levels,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Update inventory level at location
  Future<AdminInventoryLevel?> updateInventoryLevel(
    String id,
    String locationId,
    AdminUpdateInventoryLevel body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/location-levels/$locationId',
      method: 'POST',
      body: body.toJson(),
      query: query,
      headers: headers,
    );

    final inventoryLevel = response['inventory_level'];
    return inventoryLevel != null
        ? AdminInventoryLevel.fromJson(inventoryLevel as Map<String, dynamic>)
        : null;
  }

  /// Create inventory level at location
  Future<AdminInventoryLevel?> createInventoryLevel(
    String id,
    AdminCreateInventoryLevel body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/location-levels',
      method: 'POST',
      body: body.toJson(),
      query: query,
      headers: headers,
    );

    final inventoryLevel = response['inventory_level'];
    return inventoryLevel != null
        ? AdminInventoryLevel.fromJson(inventoryLevel as Map<String, dynamic>)
        : null;
  }

  /// Delete inventory level at location
  Future<Map<String, dynamic>> deleteInventoryLevel(
    String id,
    String locationId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/location-levels/$locationId',
      method: 'DELETE',
      headers: headers,
    );

    return response;
  }

  /// Search inventory items by SKU
  Future<PaginatedResponse<AdminInventoryItem>> bySku(
    String sku, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['sku'] = sku;

    return list(query: query, headers: headers);
  }

  /// Get inventory items by location
  Future<PaginatedResponse<AdminInventoryItem>> byLocation(
    String locationId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['location_id'] = locationId;

    return list(query: query, headers: headers);
  }
}
