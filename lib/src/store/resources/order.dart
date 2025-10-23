import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store order resource for order operations
class StoreOrderResource extends StoreResource {
  const StoreOrderResource(super.client);

  String get resourcePath => '$basePath/orders';

  /// List orders for current customer
  Future<PaginatedResponse<StoreOrder>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<StoreOrder>(
      endpoint: resourcePath,
      dataKey: 'orders',
      fromJson: StoreOrder.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve an order by ID
  Future<StoreOrder?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<StoreOrder>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'order',
      fromJson: StoreOrder.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve order by cart ID
  Future<StoreOrder?> retrieveByCartId(
    String cartId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/cart/$cartId',
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? StoreOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Request order transfer
  Future<StoreOrder?> requestTransfer(
    String id,
    String email, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/transfer',
      method: 'POST',
      body: {'email': email},
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? StoreOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Cancel order transfer
  Future<StoreOrder?> cancelTransfer(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/transfer/cancel',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? StoreOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Accept order transfer
  Future<StoreOrder?> acceptTransfer(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/transfer/accept',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? StoreOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Decline order transfer
  Future<StoreOrder?> declineTransfer(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/transfer/decline',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final orderData = response['order'];
    return orderData != null
        ? StoreOrder.fromJson(orderData as Map<String, dynamic>)
        : null;
  }

  /// Request return for order
  Future<Map<String, dynamic>> requestReturn(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/returns',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );
  }

  /// Request exchange for order
  Future<Map<String, dynamic>> requestExchange(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/exchanges',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );
  }

  /// Request claim for order
  Future<Map<String, dynamic>> requestClaim(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/claims',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );
  }

  /// Get order status history
  Future<List<Map<String, dynamic>>> getStatusHistory(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/status-history',
      headers: headers,
    );

    return List<Map<String, dynamic>>.from(response['history'] ?? []);
  }
}
