import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin exchange management resource
///
/// Uses AdminExchange model from @medusajs/types v2.10.1
/// for enhanced admin-specific exchange management capabilities.
class AdminExchangeResource extends AdminResource {
  const AdminExchangeResource(super.client);

  String get resourcePath => '$basePath/exchanges';

  /// List exchanges with enhanced filtering
  ///
  /// Supports comprehensive filtering by status, payment status,
  /// fulfillment status, order ID, and date ranges.
  ///
  /// Example:
  /// ```dart
  /// final exchanges = await medusa.admin.exchange.list();
  /// final pendingExchanges = await medusa.admin.exchange.list(
  ///   query: AdminExchangeFilters(
  ///     status: [AdminExchangeStatus.requested],
  ///     paymentStatus: [AdminExchangePaymentStatus.notPaid],
  ///   ).toQueryParameters(),
  /// );
  /// ```
  Future<PaginatedResponse<AdminExchange>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminExchange>(
      endpoint: resourcePath,
      dataKey: 'exchanges',
      fromJson: AdminExchange.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve an exchange by ID
  ///
  /// Returns detailed exchange information including items,
  /// payment status, and fulfillment details.
  ///
  /// Example:
  /// ```dart
  /// final exchange = await medusa.admin.exchange.retrieve('exc_123');
  /// ```
  Future<AdminExchange?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminExchange>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new exchange
  ///
  /// Creates an exchange with items to be returned and
  /// optionally additional items to be sent to the customer.
  ///
  /// Example:
  /// ```dart
  /// final exchange = await medusa.admin.exchange.create(
  ///   AdminCreateExchange(
  ///     orderId: 'order_123',
  ///     exchangeItems: [
  ///       AdminCreateExchangeItem(
  ///         orderItemId: 'item_123',
  ///         quantity: 1,
  ///         note: 'Defective item',
  ///       ),
  ///     ],
  ///     additionalItems: [
  ///       AdminCreateAdditionalExchangeItem(
  ///         variantId: 'var_456',
  ///         quantity: 1,
  ///       ),
  ///     ],
  ///   ),
  /// );
  /// ```
  Future<AdminExchange?> create(
    AdminCreateExchange createRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminExchange>(
      body: createRequest.toJson(),
      endpoint: resourcePath,
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update an exchange
  ///
  /// Updates exchange properties such as notes and notification settings.
  ///
  /// Example:
  /// ```dart
  /// final updated = await medusa.admin.exchange.update(
  ///   'exc_123',
  ///   AdminUpdateExchange(
  ///     note: 'Updated processing note',
  ///     noNotification: true,
  ///   ),
  /// );
  /// ```
  Future<AdminExchange?> update(
    String id,
    AdminUpdateExchange updateRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminExchange>(
      id: id,
      body: updateRequest.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete an exchange
  ///
  /// Permanently removes an exchange and all associated data.
  /// This action cannot be undone.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.exchange.delete('exc_123');
  /// ```
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

  /// Cancel an exchange
  ///
  /// Cancels an exchange and updates its status to canceled.
  /// Optional notification settings control customer communication.
  ///
  /// Example:
  /// ```dart
  /// final canceled = await medusa.admin.exchange.cancel(
  ///   'exc_123',
  ///   AdminCancelExchange(noNotification: false),
  /// );
  /// ```
  Future<AdminExchange?> cancel(
    String id,
    AdminCancelExchange cancelRequest, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminExchange>(
      id: id,
      body: cancelRequest.toJson(),
      endpoint: '$resourcePath/$id/cancel',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      headers: headers,
    );
  }

  /// Confirm an exchange
  ///
  /// Confirms a requested exchange, moving it to the confirmed state
  /// and initiating the exchange process.
  ///
  /// Example:
  /// ```dart
  /// final confirmed = await medusa.admin.exchange.confirm('exc_123');
  /// ```
  Future<AdminExchange?> confirm(String id, {ClientHeaders? headers}) async {
    return await updateGeneric<AdminExchange>(
      id: id,
      body: {},
      endpoint: '$resourcePath/$id/confirm',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      headers: headers,
    );
  }

  /// List exchanges by order
  ///
  /// Retrieves all exchanges associated with a specific order.
  ///
  /// Example:
  /// ```dart
  /// final orderExchanges = await medusa.admin.exchange.byOrder('order_123');
  /// ```
  Future<PaginatedResponse<AdminExchange>> byOrder(
    String orderId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['order_id'] = orderId;

    return list(query: query, headers: headers);
  }

  /// List exchanges by status
  ///
  /// Filters exchanges by their current status.
  ///
  /// Example:
  /// ```dart
  /// final requestedExchanges = await medusa.admin.exchange.byStatus(
  ///   AdminExchangeStatus.requested,
  /// );
  /// ```
  Future<PaginatedResponse<AdminExchange>> byStatus(
    AdminExchangeStatus status, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['status'] = status.value;

    return list(query: query, headers: headers);
  }

  /// Add return items to exchange
  ///
  /// Adds items to be returned as part of the exchange process.
  ///
  /// Example:
  /// ```dart
  /// final updated = await medusa.admin.exchange.addReturnItems(
  ///   'exc_123',
  ///   [
  ///     AdminCreateExchangeItem(
  ///       orderItemId: 'item_456',
  ///       quantity: 2,
  ///     ),
  ///   ],
  /// );
  /// ```
  Future<AdminExchange?> addReturnItems(
    String id,
    List<AdminCreateExchangeItem> returnItems, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminExchange>(
      body: {'return_items': returnItems.map((item) => item.toJson()).toList()},
      endpoint: '$resourcePath/$id/return-items',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      headers: headers,
    );
  }

  /// Add additional items to exchange
  ///
  /// Adds new items to be sent to the customer as part of the exchange.
  ///
  /// Example:
  /// ```dart
  /// final updated = await medusa.admin.exchange.addAdditionalItems(
  ///   'exc_123',
  ///   [
  ///     AdminCreateAdditionalExchangeItem(
  ///       variantId: 'var_789',
  ///       quantity: 1,
  ///     ),
  ///   ],
  /// );
  /// ```
  Future<AdminExchange?> addAdditionalItems(
    String id,
    List<AdminCreateAdditionalExchangeItem> additionalItems, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminExchange>(
      body: {
        'additional_items':
            additionalItems.map((item) => item.toJson()).toList(),
      },
      endpoint: '$resourcePath/$id/additional-items',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      headers: headers,
    );
  }

  /// Create fulfillment for exchange
  ///
  /// Creates a fulfillment to ship the additional items in the exchange.
  ///
  /// Example:
  /// ```dart
  /// final fulfilled = await medusa.admin.exchange.createFulfillment(
  ///   'exc_123',
  ///   {
  ///     'items': [
  ///       {'item_id': 'item_123', 'quantity': 1}
  ///     ],
  ///     'location_id': 'loc_123',
  ///   },
  /// );
  /// ```
  Future<AdminExchange?> createFulfillment(
    String id,
    Map<String, dynamic> fulfillmentData, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminExchange>(
      body: fulfillmentData,
      endpoint: '$resourcePath/$id/fulfillments',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      headers: headers,
    );
  }

  /// Create shipment for exchange
  ///
  /// Creates a shipment tracking entry for exchange fulfillment.
  ///
  /// Example:
  /// ```dart
  /// final shipped = await medusa.admin.exchange.createShipment(
  ///   'exc_123',
  ///   {
  ///     'fulfillment_id': 'ful_123',
  ///     'tracking_number': 'TRACK123',
  ///   },
  /// );
  /// ```
  Future<AdminExchange?> createShipment(
    String id,
    Map<String, dynamic> shipmentData, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminExchange>(
      body: shipmentData,
      endpoint: '$resourcePath/$id/shipments',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      headers: headers,
    );
  }

  /// Process exchange payment
  ///
  /// Processes payment for exchanges where the customer owes additional money.
  ///
  /// Example:
  /// ```dart
  /// final processed = await medusa.admin.exchange.processPayment(
  ///   'exc_123',
  ///   AdminProcessExchangePayment(amount: 1500), // $15.00 in cents
  /// );
  /// ```
  Future<AdminExchange?> processPayment(
    String id,
    AdminProcessExchangePayment paymentRequest, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminExchange>(
      body: paymentRequest.toJson(),
      endpoint: '$resourcePath/$id/process-payment',
      dataKey: 'exchange',
      fromJson: AdminExchange.fromJson,
      headers: headers,
    );
  }
}
