import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin payment resource for payment management and processing
/// Comprehensive payment operations with capture, refund, and cancellation
class AdminPaymentResource extends AdminResource {
  const AdminPaymentResource(super.client);

  String get resourcePath => '$basePath/payments';

  /// List payments with advanced filtering
  Future<PaginatedResponse<AdminPayment>> list({
    AdminPaymentFilters? filters,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final queryParams = <String, dynamic>{};

    // Add filters if provided
    if (filters != null) {
      queryParams.addAll(filters.toQueryParameters());
    }

    // Add additional query parameters
    if (query != null) {
      queryParams.addAll(query);
    }

    return await listGeneric<AdminPayment>(
      endpoint: resourcePath,
      dataKey: 'payments',
      fromJson: AdminPayment.fromJson,
      query: queryParams.isNotEmpty ? queryParams : null,
      headers: headers,
    );
  }

  /// Retrieve a payment by ID
  Future<AdminPayment?> retrieve(
    String id, {
    List<String>? expand,
    List<String>? fields,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final queryParams = <String, dynamic>{};

    if (expand != null && expand.isNotEmpty) {
      queryParams['expand'] = expand.join(',');
    }
    if (fields != null && fields.isNotEmpty) {
      queryParams['fields'] = fields.join(',');
    }
    if (query != null) {
      queryParams.addAll(query);
    }

    return await retrieveGeneric<AdminPayment>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'payment',
      fromJson: AdminPayment.fromJson,
      query: queryParams.isNotEmpty ? queryParams : null,
      headers: headers,
    );
  }

  /// Capture a payment
  Future<AdminPayment?> capture(
    String id,
    AdminCapturePayment captureRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/capture',
      method: 'POST',
      body: captureRequest.toJson(),
      query: query,
      headers: headers,
    );

    final paymentData = response['payment'] as Map<String, dynamic>?;
    return paymentData != null ? AdminPayment.fromJson(paymentData) : null;
  }

  /// Refund a payment
  Future<AdminRefund?> refund(
    String id,
    AdminRefundPayment refundRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/refund',
      method: 'POST',
      body: refundRequest.toJson(),
      query: query,
      headers: headers,
    );

    final refundData = response['refund'] as Map<String, dynamic>?;
    return refundData != null ? AdminRefund.fromJson(refundData) : null;
  }

  /// Cancel a payment
  Future<AdminPayment?> cancel(
    String id, {
    AdminCancelPayment? cancelRequest,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final body = cancelRequest?.toJson() ?? <String, dynamic>{};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/cancel',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final paymentData = response['payment'] as Map<String, dynamic>?;
    return paymentData != null ? AdminPayment.fromJson(paymentData) : null;
  }

  /// Update a payment
  Future<AdminPayment?> update(
    String id,
    AdminUpdatePayment updateRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminPayment>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'payment',
      fromJson: AdminPayment.fromJson,
      body: updateRequest.toJson(),
      query: query,
      headers: headers,
    );
  }

  // ===== Convenience Methods =====

  /// Get payments by order
  Future<PaginatedResponse<AdminPayment>> byOrder(
    String orderId, {
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = AdminPaymentFilters(orderId: [orderId], expand: expand);

    return list(filters: filters, query: additionalFilters, headers: headers);
  }

  /// Get payments by customer
  Future<PaginatedResponse<AdminPayment>> byCustomer(
    String customerId, {
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = AdminPaymentFilters(
      customerId: [customerId],
      expand: expand,
    );

    return list(filters: filters, query: additionalFilters, headers: headers);
  }

  /// Get payments by status
  Future<PaginatedResponse<AdminPayment>> byStatus(
    String status, {
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = AdminPaymentFilters(status: [status], expand: expand);

    return list(filters: filters, query: additionalFilters, headers: headers);
  }

  /// Get payments by provider
  Future<PaginatedResponse<AdminPayment>> byProvider(
    String providerId, {
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = AdminPaymentFilters(
      providerId: [providerId],
      expand: expand,
    );

    return list(filters: filters, query: additionalFilters, headers: headers);
  }

  /// Get payments by currency
  Future<PaginatedResponse<AdminPayment>> byCurrency(
    String currencyCode, {
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = AdminPaymentFilters(
      currencyCode: [currencyCode],
      expand: expand,
    );

    return list(filters: filters, query: additionalFilters, headers: headers);
  }

  /// Search payments
  Future<PaginatedResponse<AdminPayment>> search(
    String query, {
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = AdminPaymentFilters(q: query, expand: expand);

    return list(filters: filters, query: additionalFilters, headers: headers);
  }

  /// Get authorized payments
  Future<PaginatedResponse<AdminPayment>> authorized({
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    return byStatus(
      'authorized',
      expand: expand,
      additionalFilters: additionalFilters,
      headers: headers,
    );
  }

  /// Get captured payments
  Future<PaginatedResponse<AdminPayment>> captured({
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    return byStatus(
      'captured',
      expand: expand,
      additionalFilters: additionalFilters,
      headers: headers,
    );
  }

  /// Get canceled payments
  Future<PaginatedResponse<AdminPayment>> canceled({
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    return byStatus(
      'canceled',
      expand: expand,
      additionalFilters: additionalFilters,
      headers: headers,
    );
  }

  /// Get pending payments
  Future<PaginatedResponse<AdminPayment>> pending({
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    return byStatus(
      'pending',
      expand: expand,
      additionalFilters: additionalFilters,
      headers: headers,
    );
  }

  /// Get payments requiring action
  Future<PaginatedResponse<AdminPayment>> requiresAction({
    List<String>? expand,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    return byStatus(
      'requires_action',
      expand: expand,
      additionalFilters: additionalFilters,
      headers: headers,
    );
  }
}
