import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin order management resource
///
/// Uses AdminOrder model from @medusajs/types v2.10.1
/// for enhanced admin-specific order management capabilities.
class AdminOrderResource extends AdminResource {
  const AdminOrderResource(super.client);

  String get resourcePath => '$basePath/orders';

  /// List orders
  Future<PaginatedResponse<AdminOrder>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminOrder>(
      endpoint: resourcePath,
      dataKey: 'orders',
      fromJson: AdminOrder.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve an order by ID
  Future<AdminOrder?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminOrder>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'order',
      fromJson: AdminOrder.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update an order
  Future<AdminOrder?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminOrder>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'order',
      fromJson: AdminOrder.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Cancel an order
  Future<AdminOrder?> cancel(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/cancel',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? AdminOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Complete an order
  Future<AdminOrder?> complete(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/complete',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? AdminOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Archive an order
  Future<AdminOrder?> archive(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/archive',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? AdminOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Capture payment for an order
  Future<AdminOrder?> capturePayment(
    String id, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/capture',
      method: 'POST',
      body: body ?? {},
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? AdminOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Create fulfillment for an order
  Future<AdminOrder?> createFulfillment(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillments',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? AdminOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Create shipment for fulfillment
  Future<AdminOrder?> createShipment(
    String id,
    String fulfillmentId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/fulfillments/$fulfillmentId/shipments',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? AdminOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }
}
