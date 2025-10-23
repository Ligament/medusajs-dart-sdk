/// Batch operations for efficient API calls
///
/// Provides utilities for batching multiple API operations together
/// to reduce the number of HTTP requests and improve performance.
library;

import 'dart:async';
import '../types/types.dart';
import '../client/client.dart';

/// Batch operation request
class BatchRequest {
  final String method;
  final String path;
  final Map<String, dynamic>? body;
  final QueryParams? query;
  final String? id;

  const BatchRequest({
    required this.method,
    required this.path,
    this.body,
    this.query,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'path': path,
      if (body != null) 'body': body,
      if (query != null) 'query': query,
      if (id != null) 'id': id,
    };
  }
}

/// Batch operation response
class BatchOperationResponse {
  final String? id;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? error;

  const BatchOperationResponse({
    this.id,
    required this.statusCode,
    this.data,
    this.error,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
  bool get isError => !isSuccess;

  factory BatchOperationResponse.fromJson(Map<String, dynamic> json) {
    return BatchOperationResponse(
      id: json['id'],
      statusCode: json['status_code'] ?? 200,
      data: json['data'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'status_code': statusCode,
      if (data != null) 'data': data,
      if (error != null) 'error': error,
    };
  }
}

/// Batch operations manager
class BatchManager {
  final MedusaClient _client;
  final List<BatchRequest> _requests = [];
  final int _maxBatchSize;

  BatchManager(this._client, {int maxBatchSize = 50})
    : _maxBatchSize = maxBatchSize;

  /// Add a request to the batch
  void add(BatchRequest request) {
    if (_requests.length >= _maxBatchSize) {
      throw Exception('Batch size limit exceeded: $_maxBatchSize');
    }
    _requests.add(request);
  }

  /// Add multiple requests to the batch
  void addAll(List<BatchRequest> requests) {
    for (final request in requests) {
      add(request);
    }
  }

  /// Execute all batched requests
  Future<List<BatchOperationResponse>> execute({ClientHeaders? headers}) async {
    if (_requests.isEmpty) {
      return [];
    }

    final batchPayload = {
      'requests': _requests.map((r) => r.toJson()).toList(),
    };

    try {
      final response = await _client.fetch<Map<String, dynamic>>(
        '/batch',
        method: 'POST',
        body: batchPayload,
        headers: headers,
        useCache: false, // Don't cache batch operations
      );

      final results = response['results'] as List?;
      if (results == null) {
        throw Exception('Invalid batch response format');
      }

      return results
          .map(
            (r) => BatchOperationResponse.fromJson(r as Map<String, dynamic>),
          )
          .toList();
    } finally {
      // Clear requests after execution
      clear();
    }
  }

  /// Clear all pending requests
  void clear() {
    _requests.clear();
  }

  /// Get the number of pending requests
  int get size => _requests.length;

  /// Check if the batch is empty
  bool get isEmpty => _requests.isEmpty;

  /// Check if the batch is full
  bool get isFull => _requests.length >= _maxBatchSize;

  /// Get remaining capacity
  int get remainingCapacity => _maxBatchSize - _requests.length;
}

/// Batch operation builder for specific resource types
abstract class BatchBuilder<T> {
  final BatchManager _manager;
  final String _basePath;

  BatchBuilder(this._manager, this._basePath);

  /// Create a new item
  BatchBuilder<T> create(Map<String, dynamic> data, {String? id}) {
    _manager.add(
      BatchRequest(method: 'POST', path: _basePath, body: data, id: id),
    );
    return this;
  }

  /// Update an existing item
  BatchBuilder<T> update(
    String itemId,
    Map<String, dynamic> data, {
    String? id,
  }) {
    _manager.add(
      BatchRequest(
        method: 'POST',
        path: '$_basePath/$itemId',
        body: data,
        id: id,
      ),
    );
    return this;
  }

  /// Delete an item
  BatchBuilder<T> delete(String itemId, {String? id}) {
    _manager.add(
      BatchRequest(method: 'DELETE', path: '$_basePath/$itemId', id: id),
    );
    return this;
  }

  /// Execute the batch operations
  Future<List<BatchOperationResponse>> execute({ClientHeaders? headers}) {
    return _manager.execute(headers: headers);
  }

  /// Get batch statistics
  Map<String, dynamic> getStats() {
    return {
      'pending_requests': _manager.size,
      'remaining_capacity': _manager.remainingCapacity,
      'is_full': _manager.isFull,
    };
  }
}

/// Product batch operations builder
class ProductBatchBuilder extends BatchBuilder<Map<String, dynamic>> {
  ProductBatchBuilder(BatchManager manager) : super(manager, '/admin/products');

  /// Add product variants
  ProductBatchBuilder addVariants(
    String productId,
    List<Map<String, dynamic>> variants, {
    String? id,
  }) {
    _manager.add(
      BatchRequest(
        method: 'POST',
        path: '/admin/products/$productId/variants',
        body: {'variants': variants},
        id: id,
      ),
    );
    return this;
  }

  /// Update product variants
  ProductBatchBuilder updateVariants(
    String productId,
    Map<String, List<Map<String, dynamic>>> updates, {
    String? id,
  }) {
    _manager.add(
      BatchRequest(
        method: 'POST',
        path: '/admin/products/$productId/variants/batch',
        body: updates,
        id: id,
      ),
    );
    return this;
  }

  /// Set product categories
  ProductBatchBuilder setCategories(
    String productId,
    List<String> categoryIds, {
    String? id,
  }) {
    _manager.add(
      BatchRequest(
        method: 'POST',
        path: '/admin/products/$productId/categories',
        body: {'category_ids': categoryIds},
        id: id,
      ),
    );
    return this;
  }
}

/// Order batch operations builder
class OrderBatchBuilder extends BatchBuilder<Map<String, dynamic>> {
  OrderBatchBuilder(BatchManager manager) : super(manager, '/admin/orders');

  /// Cancel multiple orders
  OrderBatchBuilder cancelOrders(List<String> orderIds, {String? id}) {
    for (final orderId in orderIds) {
      _manager.add(
        BatchRequest(
          method: 'POST',
          path: '/admin/orders/$orderId/cancel',
          id: id != null ? '${id}_$orderId' : null,
        ),
      );
    }
    return this;
  }

  /// Capture payments for multiple orders
  OrderBatchBuilder capturePayments(
    Map<String, Map<String, dynamic>> orderPayments, {
    String? id,
  }) {
    for (final entry in orderPayments.entries) {
      _manager.add(
        BatchRequest(
          method: 'POST',
          path: '/admin/orders/${entry.key}/capture',
          body: entry.value,
          id: id != null ? '${id}_${entry.key}' : null,
        ),
      );
    }
    return this;
  }

  /// Fulfill multiple orders
  OrderBatchBuilder fulfillOrders(
    Map<String, Map<String, dynamic>> orderFulfillments, {
    String? id,
  }) {
    for (final entry in orderFulfillments.entries) {
      _manager.add(
        BatchRequest(
          method: 'POST',
          path: '/admin/orders/${entry.key}/fulfillment',
          body: entry.value,
          id: id != null ? '${id}_${entry.key}' : null,
        ),
      );
    }
    return this;
  }
}

/// Customer batch operations builder
class CustomerBatchBuilder extends BatchBuilder<Map<String, dynamic>> {
  CustomerBatchBuilder(BatchManager manager)
    : super(manager, '/admin/customers');

  /// Update customer groups
  CustomerBatchBuilder updateGroups(
    Map<String, List<String>> customerGroups, {
    String? id,
  }) {
    for (final entry in customerGroups.entries) {
      _manager.add(
        BatchRequest(
          method: 'POST',
          path: '/admin/customers/${entry.key}/groups',
          body: {'group_ids': entry.value},
          id: id != null ? '${id}_${entry.key}' : null,
        ),
      );
    }
    return this;
  }

  /// Send password reset emails
  CustomerBatchBuilder sendPasswordResets(
    List<String> customerIds, {
    String? id,
  }) {
    for (final customerId in customerIds) {
      _manager.add(
        BatchRequest(
          method: 'POST',
          path: '/admin/customers/$customerId/password-token',
          id: id != null ? '${id}_$customerId' : null,
        ),
      );
    }
    return this;
  }
}

/// Auto-batching manager for automatic request batching
class AutoBatchManager {
  final BatchManager _batchManager;
  final Duration _batchDelay;
  final int _maxBatchSize;
  Timer? _batchTimer;
  final List<Completer<BatchOperationResponse>> _completers = [];

  AutoBatchManager(
    MedusaClient client, {
    Duration batchDelay = const Duration(milliseconds: 100),
    int maxBatchSize = 50,
  }) : _batchManager = BatchManager(client, maxBatchSize: maxBatchSize),
       _batchDelay = batchDelay,
       _maxBatchSize = maxBatchSize;

  /// Add a request to the auto-batch queue
  Future<BatchOperationResponse> add(BatchRequest request) {
    final completer = Completer<BatchOperationResponse>();

    _batchManager.add(request);
    _completers.add(completer);

    // Start or reset the batch timer
    _resetBatchTimer();

    // Execute immediately if batch is full
    if (_batchManager.isFull) {
      _executeBatch();
    }

    return completer.future;
  }

  /// Reset the batch timer
  void _resetBatchTimer() {
    _batchTimer?.cancel();
    _batchTimer = Timer(_batchDelay, () {
      if (!_batchManager.isEmpty) {
        _executeBatch();
      }
    });
  }

  /// Execute the current batch
  Future<void> _executeBatch() async {
    _batchTimer?.cancel();

    if (_batchManager.isEmpty) return;

    final currentCompleters = List<Completer<BatchOperationResponse>>.from(
      _completers,
    );
    _completers.clear();

    try {
      final results = await _batchManager.execute();

      // Complete the futures with results
      for (int i = 0; i < currentCompleters.length && i < results.length; i++) {
        currentCompleters[i].complete(results[i]);
      }

      // Handle any remaining completers (in case of mismatched results)
      for (int i = results.length; i < currentCompleters.length; i++) {
        currentCompleters[i].completeError(
          Exception('Batch operation failed: no result returned'),
        );
      }
    } catch (e) {
      // Complete all futures with the error
      for (final completer in currentCompleters) {
        if (!completer.isCompleted) {
          completer.completeError(e);
        }
      }
    }
  }

  /// Flush any pending requests immediately
  Future<void> flush() async {
    if (!_batchManager.isEmpty) {
      await _executeBatch();
    }
  }

  /// Dispose the auto-batch manager
  void dispose() {
    _batchTimer?.cancel();

    // Complete any pending requests with an error
    for (final completer in _completers) {
      if (!completer.isCompleted) {
        completer.completeError(Exception('AutoBatchManager disposed'));
      }
    }
    _completers.clear();
  }
}
