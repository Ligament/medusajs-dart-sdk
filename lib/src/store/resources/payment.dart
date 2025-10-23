import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store payment resource for payment operations
class StorePaymentResource extends StoreResource {
  const StorePaymentResource(super.client);

  String get resourcePath => '$basePath/payment-providers';

  /// List payment providers
  Future<PaginatedResponse<Map<String, dynamic>>> listPaymentProviders({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      resourcePath,
      query: query,
      headers: headers,
    );

    return PaginatedResponse(
      data: List<Map<String, dynamic>>.from(
        response['payment_providers'] ?? [],
      ),
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Initiate payment session for cart
  Future<StorePaymentCollection> initiatePaymentSession(
    StoreCart cart,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    String? paymentCollectionId = cart.paymentCollection?.id;
    // Create payment collection if it doesn't exist
    if (paymentCollectionId == null) {
      final collectionBody = {'cart_id': cart.id};

      final collectionResponse = await client.fetch<Map<String, dynamic>>(
        '/store/payment-collections',
        method: 'POST',
        body: collectionBody,
        headers: headers,
      );

      paymentCollectionId = collectionResponse['payment_collection']['id'];
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '/store/payment-collections/$paymentCollectionId/payment-sessions',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    return StorePaymentCollection.fromJson(response['payment_collection']);
  }

  /// Update payment session
  Future<Map<String, dynamic>> updatePaymentSession(
    String paymentCollectionId,
    String paymentSessionId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/store/payment-collections/$paymentCollectionId/payment-sessions/$paymentSessionId',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Authorize payment session
  Future<Map<String, dynamic>> authorizePaymentSession(
    String paymentCollectionId,
    String paymentSessionId, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/store/payment-collections/$paymentCollectionId/payment-sessions/$paymentSessionId/authorize',
      method: 'POST',
      body: body ?? {},
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Delete payment session
  Future<Map<String, dynamic>> deletePaymentSession(
    String paymentCollectionId,
    String paymentSessionId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/store/payment-collections/$paymentCollectionId/payment-sessions/$paymentSessionId',
      method: 'DELETE',
      headers: headers,
    );

    return response;
  }

  /// Complete payment collection
  Future<Map<String, dynamic>> completePaymentCollection(
    String paymentCollectionId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/store/payment-collections/$paymentCollectionId/complete',
      method: 'POST',
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Refresh payment session
  Future<Map<String, dynamic>> refreshPaymentSession(
    String paymentCollectionId,
    String paymentSessionId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/store/payment-collections/$paymentCollectionId/payment-sessions/$paymentSessionId/refresh',
      method: 'POST',
      query: query,
      headers: headers,
    );

    return response;
  }

  /// Get payment collection
  Future<Map<String, dynamic>> getPaymentCollection(
    String paymentCollectionId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/store/payment-collections/$paymentCollectionId',
      query: query,
      headers: headers,
    );

    return response;
  }
}
