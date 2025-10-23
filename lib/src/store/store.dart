import '../client/client.dart';
import 'resources/resources.dart';

/// Refactored Store module for customer-facing operations
///
/// Provides access to all store functionality with improved organization:
/// - Cleaner resource structure
/// - Better separation of concerns
/// - Consistent API patterns
/// - Enhanced type safety
/// - Customer-focused design
class MedusaStore {
  final MedusaClient _client;

  MedusaStore(this._client);

  // Core Resources - Most commonly used in storefronts

  /// Product operations - browsing, searching, filtering
  late final product = StoreProductResource(_client);

  /// Cart operations - cart management, checkout flow
  late final cart = StoreCartResource(_client);

  /// Region operations - regions, currencies, shipping
  late final region = StoreRegionResource(_client);

  /// Currency operations - configured store currencies
  late final currency = StoreCurrencyResource(_client);

  /// Collection operations - product collections
  late final collection = StoreCollectionResource(_client);

  /// Category operations - product categories
  late final category = StoreCategoryResource(_client);

  /// Customer operations - customer management
  late final customer = StoreCustomerResource(_client);

  /// Order operations - order management
  late final order = StoreOrderResource(_client);

  /// Payment operations - payment processing
  late final payment = StorePaymentResource(_client);

  /// Fulfillment operations - shipping options and calculations
  late final fulfillment = StoreFulfillmentResource(_client);
}
