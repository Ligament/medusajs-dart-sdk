/// Real-time features for the Medusa SDK
///
/// Provides support for:
/// - Server-Sent Events (SSE)
/// - Real-time data subscriptions
/// - Live updates for resources
/// - Event-driven programming patterns
library;

import 'dart:async';
import 'dart:convert';
import '../client/client.dart';
import '../types/types.dart';

/// Real-time event types
enum RealtimeEventType {
  productUpdate,
  orderUpdate,
  customerUpdate,
  inventoryUpdate,
  paymentUpdate,
  fulfillmentUpdate,
  custom,
}

/// Real-time event data
class RealtimeEvent {
  final RealtimeEventType type;
  final String? id;
  final Map<String, dynamic> data;
  final DateTime timestamp;
  final String? source;

  const RealtimeEvent({
    required this.type,
    this.id,
    required this.data,
    required this.timestamp,
    this.source,
  });

  factory RealtimeEvent.fromServerSentEvent(ServerSentEventMessage message) {
    final data =
        message.data != null
            ? jsonDecode(message.data!) as Map<String, dynamic>
            : <String, dynamic>{};

    final typeString = message.event ?? data['type'] ?? 'custom';
    final type = _parseEventType(typeString);

    return RealtimeEvent(
      type: type,
      id: message.id ?? data['id'],
      data: data,
      timestamp: DateTime.now(),
      source: data['source'],
    );
  }

  static RealtimeEventType _parseEventType(String typeString) {
    switch (typeString.toLowerCase()) {
      case 'product.updated':
      case 'product_update':
        return RealtimeEventType.productUpdate;
      case 'order.updated':
      case 'order_update':
        return RealtimeEventType.orderUpdate;
      case 'customer.updated':
      case 'customer_update':
        return RealtimeEventType.customerUpdate;
      case 'inventory.updated':
      case 'inventory_update':
        return RealtimeEventType.inventoryUpdate;
      case 'payment.updated':
      case 'payment_update':
        return RealtimeEventType.paymentUpdate;
      case 'fulfillment.updated':
      case 'fulfillment_update':
        return RealtimeEventType.fulfillmentUpdate;
      default:
        return RealtimeEventType.custom;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'id': id,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'source': source,
    };
  }
}

/// Real-time subscription configuration
class SubscriptionConfig {
  final List<RealtimeEventType> eventTypes;
  final List<String>? resourceIds;
  final Map<String, dynamic>? filters;
  final Duration? reconnectDelay;
  final int maxReconnectAttempts;
  final bool autoReconnect;

  const SubscriptionConfig({
    this.eventTypes = const [RealtimeEventType.custom],
    this.resourceIds,
    this.filters,
    this.reconnectDelay = const Duration(seconds: 5),
    this.maxReconnectAttempts = 5,
    this.autoReconnect = true,
  });

  Map<String, dynamic> toQuery() {
    final query = <String, dynamic>{};

    if (eventTypes.isNotEmpty) {
      query['events'] = eventTypes
          .map((e) => e.toString().split('.').last)
          .join(',');
    }

    if (resourceIds != null && resourceIds!.isNotEmpty) {
      query['resource_ids'] = resourceIds!.join(',');
    }

    if (filters != null) {
      query.addAll(filters!);
    }

    return query;
  }
}

/// Real-time subscription
class RealtimeSubscription {
  final String _endpoint;
  final SubscriptionConfig _config;
  final MedusaClient _client;

  StreamController<RealtimeEvent>? _controller;
  StreamSubscription<ServerSentEventMessage>? _streamSubscription;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  bool _isActive = false;

  RealtimeSubscription(this._endpoint, this._config, this._client);

  /// Start the subscription
  Stream<RealtimeEvent> start() {
    if (_isActive) {
      throw StateError('Subscription is already active');
    }

    _controller = StreamController<RealtimeEvent>.broadcast();
    _connect();
    _isActive = true;

    return _controller!.stream;
  }

  /// Stop the subscription
  Future<void> stop() async {
    _isActive = false;
    _reconnectTimer?.cancel();
    await _streamSubscription?.cancel();
    await _controller?.close();

    _controller = null;
    _streamSubscription = null;
    _reconnectTimer = null;
    _reconnectAttempts = 0;
  }

  /// Connect to the SSE endpoint
  Future<void> _connect() async {
    try {
      final streamResponse = await _client.fetchStream(
        _endpoint,
        query: _config.toQuery(),
      );

      _streamSubscription = streamResponse.stream!.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDone,
      );

      _reconnectAttempts = 0;
    } catch (e) {
      _handleError(e);
    }
  }

  /// Handle incoming SSE messages
  void _handleMessage(ServerSentEventMessage message) {
    if (!_isActive || _controller == null) return;

    try {
      final event = RealtimeEvent.fromServerSentEvent(message);
      _controller!.add(event);
    } catch (e) {
      _controller!.addError(e);
    }
  }

  /// Handle connection errors
  void _handleError(Object error) {
    if (!_isActive || _controller == null) return;

    _controller!.addError(error);

    if (_config.autoReconnect &&
        _reconnectAttempts < _config.maxReconnectAttempts) {
      _scheduleReconnect();
    }
  }

  /// Handle connection close
  void _handleDone() {
    if (!_isActive) return;

    if (_config.autoReconnect &&
        _reconnectAttempts < _config.maxReconnectAttempts) {
      _scheduleReconnect();
    } else {
      _controller?.close();
    }
  }

  /// Schedule a reconnection attempt
  void _scheduleReconnect() {
    _reconnectAttempts++;

    final delay = Duration(
      milliseconds:
          (_config.reconnectDelay?.inMilliseconds ?? 5000) * _reconnectAttempts,
    );

    _reconnectTimer = Timer(delay, () {
      if (_isActive) {
        _connect();
      }
    });
  }

  /// Get subscription status
  bool get isActive => _isActive;
  int get reconnectAttempts => _reconnectAttempts;
}

/// Real-time manager for handling multiple subscriptions
class RealtimeManager {
  final MedusaClient _client;
  final Map<String, RealtimeSubscription> _subscriptions = {};

  RealtimeManager(this._client);

  /// Subscribe to real-time events for a specific endpoint
  Stream<RealtimeEvent> subscribe(
    String endpoint, {
    SubscriptionConfig? config,
  }) {
    final subscriptionConfig = config ?? const SubscriptionConfig();
    final key = _generateSubscriptionKey(endpoint, subscriptionConfig);

    // Close existing subscription if any
    if (_subscriptions.containsKey(key)) {
      _subscriptions[key]!.stop();
    }

    final subscription = RealtimeSubscription(
      endpoint,
      subscriptionConfig,
      _client,
    );

    _subscriptions[key] = subscription;
    return subscription.start();
  }

  /// Subscribe to product updates
  Stream<RealtimeEvent> subscribeToProducts({
    List<String>? productIds,
    Map<String, dynamic>? filters,
  }) {
    return subscribe(
      '/store/products/updates',
      config: SubscriptionConfig(
        eventTypes: [RealtimeEventType.productUpdate],
        resourceIds: productIds,
        filters: filters,
      ),
    );
  }

  /// Subscribe to order updates
  Stream<RealtimeEvent> subscribeToOrders({
    List<String>? orderIds,
    Map<String, dynamic>? filters,
  }) {
    return subscribe(
      '/admin/orders/updates',
      config: SubscriptionConfig(
        eventTypes: [RealtimeEventType.orderUpdate],
        resourceIds: orderIds,
        filters: filters,
      ),
    );
  }

  /// Subscribe to customer updates
  Stream<RealtimeEvent> subscribeToCustomers({
    List<String>? customerIds,
    Map<String, dynamic>? filters,
  }) {
    return subscribe(
      '/admin/customers/updates',
      config: SubscriptionConfig(
        eventTypes: [RealtimeEventType.customerUpdate],
        resourceIds: customerIds,
        filters: filters,
      ),
    );
  }

  /// Subscribe to inventory updates
  Stream<RealtimeEvent> subscribeToInventory({
    List<String>? locationIds,
    List<String>? variantIds,
    Map<String, dynamic>? filters,
  }) {
    final combinedFilters = <String, dynamic>{
      ...?filters,
      if (locationIds != null) 'location_ids': locationIds.join(','),
      if (variantIds != null) 'variant_ids': variantIds.join(','),
    };

    return subscribe(
      '/admin/inventory/updates',
      config: SubscriptionConfig(
        eventTypes: [RealtimeEventType.inventoryUpdate],
        filters: combinedFilters,
      ),
    );
  }

  /// Subscribe to all events (useful for debugging)
  Stream<RealtimeEvent> subscribeToAll({Map<String, dynamic>? filters}) {
    return subscribe(
      '/admin/events',
      config: SubscriptionConfig(
        eventTypes: RealtimeEventType.values,
        filters: filters,
      ),
    );
  }

  /// Unsubscribe from a specific endpoint
  Future<void> unsubscribe(
    String endpoint, {
    SubscriptionConfig? config,
  }) async {
    final subscriptionConfig = config ?? const SubscriptionConfig();
    final key = _generateSubscriptionKey(endpoint, subscriptionConfig);

    if (_subscriptions.containsKey(key)) {
      await _subscriptions[key]!.stop();
      _subscriptions.remove(key);
    }
  }

  /// Unsubscribe from all active subscriptions
  Future<void> unsubscribeAll() async {
    final futures = _subscriptions.values.map((sub) => sub.stop());
    await Future.wait(futures);
    _subscriptions.clear();
  }

  /// Get active subscription count
  int get activeSubscriptionsCount => _subscriptions.length;

  /// Get all active subscription endpoints
  List<String> get activeEndpoints => _subscriptions.keys.toList();

  /// Generate a unique key for subscription management
  String _generateSubscriptionKey(String endpoint, SubscriptionConfig config) {
    final configJson = jsonEncode(config.toQuery());
    return '$endpoint:$configJson';
  }

  /// Dispose all subscriptions
  Future<void> dispose() async {
    await unsubscribeAll();
  }
}

/// Event filter for real-time subscriptions
class EventFilter {
  final Map<String, dynamic> _filters = {};

  /// Filter by resource ID
  EventFilter byId(String id) {
    _filters['id'] = id;
    return this;
  }

  /// Filter by resource IDs
  EventFilter byIds(List<String> ids) {
    _filters['ids'] = ids.join(',');
    return this;
  }

  /// Filter by status
  EventFilter byStatus(String status) {
    _filters['status'] = status;
    return this;
  }

  /// Filter by date range
  EventFilter byDateRange({DateTime? from, DateTime? to}) {
    if (from != null) {
      _filters['created_at[gte]'] = from.toIso8601String();
    }
    if (to != null) {
      _filters['created_at[lte]'] = to.toIso8601String();
    }
    return this;
  }

  /// Add custom filter
  EventFilter where(String key, dynamic value) {
    _filters[key] = value;
    return this;
  }

  /// Build the filter map
  Map<String, dynamic> build() => Map.from(_filters);

  /// Clear all filters
  void clear() => _filters.clear();
}

/// Real-time data cache for maintaining local state
class RealtimeCache<T> {
  final Map<String, T> _cache = {};
  final StreamController<RealtimeCacheEvent<T>> _controller =
      StreamController.broadcast();

  /// Add or update an item in the cache
  void put(String key, T item) {
    final wasPresent = _cache.containsKey(key);
    _cache[key] = item;

    _controller.add(
      RealtimeCacheEvent<T>(
        type: wasPresent ? CacheEventType.updated : CacheEventType.added,
        key: key,
        item: item,
      ),
    );
  }

  /// Remove an item from the cache
  T? remove(String key) {
    final item = _cache.remove(key);
    if (item != null) {
      _controller.add(
        RealtimeCacheEvent<T>(
          type: CacheEventType.removed,
          key: key,
          item: item,
        ),
      );
    }
    return item;
  }

  /// Get an item from the cache
  T? get(String key) => _cache[key];

  /// Check if cache contains key
  bool contains(String key) => _cache.containsKey(key);

  /// Get all items
  Map<String, T> getAll() => Map.from(_cache);

  /// Get all keys
  List<String> keys() => _cache.keys.toList();

  /// Get cache size
  int get size => _cache.length;

  /// Listen to cache changes
  Stream<RealtimeCacheEvent<T>> get changes => _controller.stream;

  /// Clear the cache
  void clear() {
    final items = Map.from(_cache);
    _cache.clear();

    for (final entry in items.entries) {
      _controller.add(
        RealtimeCacheEvent<T>(
          type: CacheEventType.removed,
          key: entry.key,
          item: entry.value,
        ),
      );
    }
  }

  /// Dispose the cache
  void dispose() {
    _controller.close();
  }
}

/// Cache event types
enum CacheEventType { added, updated, removed }

/// Real-time cache event
class RealtimeCacheEvent<T> {
  final CacheEventType type;
  final String key;
  final T item;

  const RealtimeCacheEvent({
    required this.type,
    required this.key,
    required this.item,
  });
}
