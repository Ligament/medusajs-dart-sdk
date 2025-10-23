import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin sales channel management resource
///
/// Provides comprehensive sales channel management capabilities including
/// CRUD operations, product association management, and multi-channel
/// commerce operations for organizing products across different storefronts.
class AdminSalesChannelResource extends AdminResource {
  const AdminSalesChannelResource(super.client);

  String get resourcePath => '$basePath/sales-channels';

  /// List sales channels
  ///
  /// Retrieves a list of sales channels with pagination support and filtering capabilities.
  ///
  /// Example:
  /// ```dart
  /// final channels = await medusa.admin.salesChannel.list(
  ///   query: {'is_disabled': false, 'limit': 20}
  /// );
  /// ```
  Future<PaginatedResponse<AdminSalesChannel>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminSalesChannel>(
      endpoint: resourcePath,
      dataKey: 'sales_channels',
      fromJson: AdminSalesChannel.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a sales channel by ID
  ///
  /// Gets detailed information about a specific sales channel including
  /// metadata and configuration settings.
  ///
  /// Example:
  /// ```dart
  /// final channel = await medusa.admin.salesChannel.retrieve('sc_123');
  /// ```
  Future<AdminSalesChannel?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminSalesChannel>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'sales_channel',
      fromJson: AdminSalesChannel.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new sales channel
  ///
  /// Creates a new sales channel with the specified configuration.
  /// Supports creating channels with custom metadata and settings.
  ///
  /// Example:
  /// ```dart
  /// final newChannel = await medusa.admin.salesChannel.create(
  ///   AdminCreateSalesChannel(
  ///     name: 'Mobile App',
  ///     description: 'Sales channel for mobile application',
  ///     isDisabled: false,
  ///     metadata: {'platform': 'ios'},
  ///   )
  /// );
  /// ```
  Future<AdminSalesChannel?> create(
    AdminCreateSalesChannel createRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminSalesChannel>(
      body: createRequest.toJson(),
      endpoint: resourcePath,
      dataKey: 'sales_channel',
      fromJson: AdminSalesChannel.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a sales channel
  ///
  /// Updates an existing sales channel with new configuration.
  /// All fields in the update request are optional.
  ///
  /// Example:
  /// ```dart
  /// final updated = await medusa.admin.salesChannel.update(
  ///   'sc_123',
  ///   AdminUpdateSalesChannel(
  ///     description: 'Updated description',
  ///     isDisabled: true,
  ///   )
  /// );
  /// ```
  Future<AdminSalesChannel?> update(
    String id,
    AdminUpdateSalesChannel updateRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminSalesChannel>(
      id: id,
      body: updateRequest.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'sales_channel',
      fromJson: AdminSalesChannel.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a sales channel
  ///
  /// Removes a sales channel and its associations.
  /// This action cannot be undone.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.salesChannel.delete('sc_123');
  /// ```
  Future<AdminSalesChannelDeleteResponse> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await deleteGeneric(
      id: id,
      endpoint: '$resourcePath/$id',
      headers: headers,
    );

    return AdminSalesChannelDeleteResponse.fromJson(response);
  }

  /// Add products to a sales channel
  ///
  /// Associates multiple products with a sales channel in a batch operation.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.salesChannel.addProducts(
  ///   'sc_123',
  ///   ['prod_1', 'prod_2', 'prod_3']
  /// );
  /// ```
  Future<AdminSalesChannelProductBatchResponse> addProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final batchRequest = AdminSalesChannelProductBatch(add: productIds);

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'POST',
      body: batchRequest.toJson(),
      headers: headers,
    );

    return AdminSalesChannelProductBatchResponse.fromJson(response);
  }

  /// Remove products from a sales channel
  ///
  /// Disassociates multiple products from a sales channel in a batch operation.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.salesChannel.removeProducts(
  ///   'sc_123',
  ///   ['prod_1', 'prod_2']
  /// );
  /// ```
  Future<AdminSalesChannelProductBatchResponse> removeProducts(
    String id,
    List<String> productIds, {
    ClientHeaders? headers,
  }) async {
    final batchRequest = AdminSalesChannelProductBatch(remove: productIds);

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'POST',
      body: batchRequest.toJson(),
      headers: headers,
    );

    return AdminSalesChannelProductBatchResponse.fromJson(response);
  }

  /// Get products associated with a sales channel
  ///
  /// Retrieves all products that are available in the specified sales channel.
  ///
  /// Example:
  /// ```dart
  /// final channelProducts = await medusa.admin.salesChannel.getProducts(
  ///   'sc_123',
  ///   query: {'limit': 50}
  /// );
  /// ```
  Future<PaginatedResponse<AdminProduct>> getProducts(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminProduct>(
      endpoint: '$resourcePath/$id/products',
      dataKey: 'products',
      fromJson: AdminProduct.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Batch update product associations
  ///
  /// Adds and removes products from a sales channel in a single operation.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.salesChannel.batchUpdateProducts(
  ///   'sc_123',
  ///   AdminSalesChannelProductBatch(
  ///     add: ['prod_1', 'prod_2'],
  ///     remove: ['prod_3', 'prod_4'],
  ///   )
  /// );
  /// ```
  Future<AdminSalesChannelProductBatchResponse> batchUpdateProducts(
    String id,
    AdminSalesChannelProductBatch batchRequest, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/products/batch',
      method: 'POST',
      body: batchRequest.toJson(),
      headers: headers,
    );

    return AdminSalesChannelProductBatchResponse.fromJson(response);
  }
}
