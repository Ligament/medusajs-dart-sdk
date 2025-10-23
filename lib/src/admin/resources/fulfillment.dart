import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin fulfillment management resource with models
///
/// Provides comprehensive fulfillment management capabilities including:
/// - Creation, update, and cancellation of fulfillments
/// - Status management (packed, shipped, delivered)
/// - Tracking information management
/// - Provider and location-based operations
/// - Business logic helpers for fulfillment workflows
class AdminFulfillmentResource extends AdminResource {
  const AdminFulfillmentResource(super.client);

  String get resourcePath => '$basePath/fulfillments';

  /// List fulfillments with comprehensive filtering
  ///
  /// Example:
  /// ```dart
  /// final filters = AdminFulfillmentFilters(
  ///   status: ['shipped', 'delivered'],
  ///   locationId: ['loc_123'],
  ///   expand: ['items', 'provider'],
  /// );
  /// final response = await admin.fulfillments.list(filters: filters);
  /// ```
  Future<PaginatedResponse<AdminFulfillment>> list({
    AdminFulfillmentFilters? filters,
    ClientHeaders? headers,
  }) async {
    final query = filters?.toQueryParameters() ?? <String, dynamic>{};

    return await listGeneric<AdminFulfillment>(
      endpoint: resourcePath,
      dataKey: 'fulfillments',
      fromJson: AdminFulfillment.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a fulfillment by ID with optional expansions
  ///
  /// Example:
  /// ```dart
  /// final fulfillment = await admin.fulfillments.retrieve(
  ///   'ful_123',
  ///   expand: ['items', 'order', 'provider'],
  /// );
  /// ```
  Future<AdminFulfillment?> retrieve(
    String id, {
    List<String>? expand,
    List<String>? fields,
    ClientHeaders? headers,
  }) async {
    final query = <String, dynamic>{};
    if (expand != null && expand.isNotEmpty) {
      query['expand'] = expand.join(',');
    }
    if (fields != null && fields.isNotEmpty) {
      query['fields'] = fields.join(',');
    }

    return await retrieveGeneric<AdminFulfillment>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'fulfillment',
      fromJson: AdminFulfillment.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new fulfillment for order items
  ///
  /// Example:
  /// ```dart
  /// final request = AdminCreateFulfillment(
  ///   items: [
  ///     AdminCreateFulfillmentItem(itemId: 'item_123', quantity: 2),
  ///   ],
  ///   locationId: 'loc_warehouse1',
  ///   providerId: 'provider_fedex',
  ///   notifyCustomer: true,
  /// );
  /// final fulfillment = await admin.fulfillments.create(request);
  /// ```
  Future<AdminFulfillment?> create(
    AdminCreateFulfillment request, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminFulfillment>(
      body: request.toJson(),
      endpoint: resourcePath,
      dataKey: 'fulfillment',
      fromJson: AdminFulfillment.fromJson,
      headers: headers,
    );
  }

  /// Update a fulfillment's details
  ///
  /// Example:
  /// ```dart
  /// final request = AdminUpdateFulfillment(
  ///   trackingNumbers: ['TRACK123', 'TRACK456'],
  ///   metadata: {'priority': 'high'},
  /// );
  /// await admin.fulfillments.update('ful_123', request);
  /// ```
  Future<AdminFulfillment?> update(
    String id,
    AdminUpdateFulfillment request, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminFulfillment>(
      id: id,
      body: request.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'fulfillment',
      fromJson: AdminFulfillment.fromJson,
      headers: headers,
    );
  }

  /// Cancel a fulfillment
  ///
  /// Example:
  /// ```dart
  /// final request = AdminCancelFulfillment(notifyCustomer: true);
  /// await admin.fulfillments.cancel('ful_123', request);
  /// ```
  Future<AdminFulfillment?> cancel(
    String id,
    AdminCancelFulfillment request, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminFulfillment>(
      id: id,
      body: request.toJson(),
      endpoint: '$resourcePath/$id/cancel',
      dataKey: 'fulfillment',
      fromJson: AdminFulfillment.fromJson,
      headers: headers,
    );
  }

  /// Mark fulfillment as shipped with tracking information
  ///
  /// Example:
  /// ```dart
  /// final request = AdminShipFulfillment(
  ///   trackingNumbers: ['TRACK123'],
  ///   trackingLinks: [{'url': 'https://track.example.com/TRACK123'}],
  ///   notifyCustomer: true,
  /// );
  /// await admin.fulfillments.ship('ful_123', request);
  /// ```
  Future<AdminFulfillment?> ship(
    String id,
    AdminShipFulfillment request, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminFulfillment>(
      id: id,
      body: request.toJson(),
      endpoint: '$resourcePath/$id/ship',
      dataKey: 'fulfillment',
      fromJson: AdminFulfillment.fromJson,
      headers: headers,
    );
  }

  /// Mark fulfillment as delivered
  ///
  /// Example:
  /// ```dart
  /// final request = AdminDeliverFulfillment(notifyCustomer: true);
  /// await admin.fulfillments.deliver('ful_123', request);
  /// ```
  Future<AdminFulfillment?> deliver(
    String id,
    AdminDeliverFulfillment request, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminFulfillment>(
      id: id,
      body: request.toJson(),
      endpoint: '$resourcePath/$id/deliver',
      dataKey: 'fulfillment',
      fromJson: AdminFulfillment.fromJson,
      headers: headers,
    );
  }

  /// List fulfillments by order ID
  ///
  /// Example:
  /// ```dart
  /// final fulfillments = await admin.fulfillments.listByOrder(
  ///   'order_123',
  ///   additionalFilters: AdminFulfillmentFilters(
  ///     status: ['shipped'],
  ///     expand: ['items'],
  ///   ),
  /// );
  /// ```
  Future<PaginatedResponse<AdminFulfillment>> listByOrder(
    String orderId, {
    AdminFulfillmentFilters? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters =
        additionalFilters?.byOrder(orderId) ??
        AdminFulfillmentFilters(orderId: [orderId]);

    return list(filters: filters, headers: headers);
  }

  /// List fulfillments by location ID
  ///
  /// Example:
  /// ```dart
  /// final fulfillments = await admin.fulfillments.listByLocation(
  ///   'loc_warehouse1',
  ///   additionalFilters: AdminFulfillmentFilters(
  ///     status: ['packed', 'shipped'],
  ///   ),
  /// );
  /// ```
  Future<PaginatedResponse<AdminFulfillment>> listByLocation(
    String locationId, {
    AdminFulfillmentFilters? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = additionalFilters ?? AdminFulfillmentFilters();
    final updatedFilters = AdminFulfillmentFilters(
      id: filters.id,
      locationId: [locationId],
      providerId: filters.providerId,
      orderId: filters.orderId,
      shippingOptionId: filters.shippingOptionId,
      status: filters.status,
      trackingNumbers: filters.trackingNumbers,
      createdAt: filters.createdAt,
      updatedAt: filters.updatedAt,
      shippedAt: filters.shippedAt,
      deliveredAt: filters.deliveredAt,
      canceledAt: filters.canceledAt,
      deletedAt: filters.deletedAt,
      requiresShipping: filters.requiresShipping,
      q: filters.q,
      offset: filters.offset,
      limit: filters.limit,
      order: filters.order,
      expand: filters.expand,
      fields: filters.fields,
    );

    return list(filters: updatedFilters, headers: headers);
  }

  /// List fulfillments by provider ID
  ///
  /// Example:
  /// ```dart
  /// final fulfillments = await admin.fulfillments.listByProvider(
  ///   'provider_fedex',
  ///   additionalFilters: AdminFulfillmentFilters(
  ///     status: ['shipped'],
  ///     expand: ['tracking_links'],
  ///   ),
  /// );
  /// ```
  Future<PaginatedResponse<AdminFulfillment>> listByProvider(
    String providerId, {
    AdminFulfillmentFilters? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = additionalFilters ?? AdminFulfillmentFilters();
    final updatedFilters = AdminFulfillmentFilters(
      id: filters.id,
      locationId: filters.locationId,
      providerId: [providerId],
      orderId: filters.orderId,
      shippingOptionId: filters.shippingOptionId,
      status: filters.status,
      trackingNumbers: filters.trackingNumbers,
      createdAt: filters.createdAt,
      updatedAt: filters.updatedAt,
      shippedAt: filters.shippedAt,
      deliveredAt: filters.deliveredAt,
      canceledAt: filters.canceledAt,
      deletedAt: filters.deletedAt,
      requiresShipping: filters.requiresShipping,
      q: filters.q,
      offset: filters.offset,
      limit: filters.limit,
      order: filters.order,
      expand: filters.expand,
      fields: filters.fields,
    );

    return list(filters: updatedFilters, headers: headers);
  }

  /// List fulfillments by status
  ///
  /// Example:
  /// ```dart
  /// final shippedFulfillments = await admin.fulfillments.listByStatus(
  ///   'shipped',
  ///   additionalFilters: AdminFulfillmentFilters(
  ///     locationId: ['loc_warehouse1'],
  ///     expand: ['items', 'order'],
  ///   ),
  /// );
  /// ```
  Future<PaginatedResponse<AdminFulfillment>> listByStatus(
    String status, {
    AdminFulfillmentFilters? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters =
        additionalFilters?.byStatus(status) ??
        AdminFulfillmentFilters(status: [status]);

    return list(filters: filters, headers: headers);
  }

  /// Search fulfillments by tracking numbers
  ///
  /// Example:
  /// ```dart
  /// final fulfillments = await admin.fulfillments.searchByTracking(
  ///   ['TRACK123', 'TRACK456'],
  ///   additionalFilters: AdminFulfillmentFilters(
  ///     expand: ['order', 'items'],
  ///   ),
  /// );
  /// ```
  Future<PaginatedResponse<AdminFulfillment>> searchByTracking(
    List<String> trackingNumbers, {
    AdminFulfillmentFilters? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final filters = additionalFilters ?? AdminFulfillmentFilters();
    final updatedFilters = AdminFulfillmentFilters(
      id: filters.id,
      locationId: filters.locationId,
      providerId: filters.providerId,
      orderId: filters.orderId,
      shippingOptionId: filters.shippingOptionId,
      status: filters.status,
      trackingNumbers: trackingNumbers,
      createdAt: filters.createdAt,
      updatedAt: filters.updatedAt,
      shippedAt: filters.shippedAt,
      deliveredAt: filters.deliveredAt,
      canceledAt: filters.canceledAt,
      deletedAt: filters.deletedAt,
      requiresShipping: filters.requiresShipping,
      q: filters.q,
      offset: filters.offset,
      limit: filters.limit,
      order: filters.order,
      expand: filters.expand,
      fields: filters.fields,
    );

    return list(filters: updatedFilters, headers: headers);
  }

  /// Get tracking information for a fulfillment
  ///
  /// Example:
  /// ```dart
  /// final trackingInfo = await admin.fulfillments.getTracking('ful_123');
  /// print('Tracking numbers: ${trackingInfo['tracking_numbers']}');
  /// ```
  Future<Map<String, dynamic>?> getTracking(
    String id, {
    ClientHeaders? headers,
  }) async {
    try {
      final response = await client.fetch<Map<String, dynamic>>(
        '$resourcePath/$id/tracking',
        headers: headers,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  /// Update tracking information for a fulfillment
  ///
  /// Example:
  /// ```dart
  /// final trackingData = {
  ///   'tracking_numbers': ['NEW_TRACK123'],
  ///   'tracking_links': [
  ///     {'url': 'https://track.example.com/NEW_TRACK123', 'service': 'FedEx'}
  ///   ],
  /// };
  /// await admin.fulfillments.updateTracking('ful_123', trackingData);
  /// ```
  Future<AdminFulfillment?> updateTracking(
    String id,
    Map<String, dynamic> trackingData, {
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminFulfillment>(
      id: id,
      body: trackingData,
      endpoint: '$resourcePath/$id/tracking',
      dataKey: 'fulfillment',
      fromJson: AdminFulfillment.fromJson,
      headers: headers,
    );
  }

  // ===========================
  // Business Logic Helpers
  // ===========================

  /// Check if fulfillment can be canceled
  Future<bool> canCancel(String id, {ClientHeaders? headers}) async {
    final fulfillment = await retrieve(id, headers: headers);
    return fulfillment?.canCancel ?? false;
  }

  /// Check if fulfillment can be shipped
  Future<bool> canShip(String id, {ClientHeaders? headers}) async {
    final fulfillment = await retrieve(id, headers: headers);
    return fulfillment?.canShip ?? false;
  }

  /// Get fulfillment status
  Future<String?> getStatus(String id, {ClientHeaders? headers}) async {
    final fulfillment = await retrieve(id, headers: headers);
    return fulfillment?.status;
  }

  /// Check if fulfillment is complete (delivered)
  Future<bool> isComplete(String id, {ClientHeaders? headers}) async {
    final fulfillment = await retrieve(id, headers: headers);
    return fulfillment?.isComplete ?? false;
  }

  /// Get primary tracking number for fulfillment
  Future<String?> getPrimaryTrackingNumber(
    String id, {
    ClientHeaders? headers,
  }) async {
    final fulfillment = await retrieve(id, headers: headers);
    return fulfillment?.primaryTrackingNumber;
  }

  /// Count total items in fulfillment
  Future<int> getItemsCount(String id, {ClientHeaders? headers}) async {
    final fulfillment = await retrieve(id, headers: headers);
    return fulfillment?.itemsCount ?? 0;
  }

  /// Get total quantity fulfilled
  Future<int> getTotalQuantity(String id, {ClientHeaders? headers}) async {
    final fulfillment = await retrieve(id, headers: headers);
    return fulfillment?.totalQuantity ?? 0;
  }
}
