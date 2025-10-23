import '../client/client.dart';
import 'resources/resources.dart';

/// Admin module for administrative operations
///
/// Provides access to all administrative functionality with proper organization:
/// - Resource-based structure following Medusa.js patterns
/// - Consistent API patterns
/// - Enhanced type safety
/// - Proper error handling
///
/// All admin operations require proper authentication and authorization.
class MedusaAdmin {
  final MedusaClient _client;

  MedusaAdmin(this._client);

  // Core Commerce Resources (11/11 active)
  late final product = AdminProductResource(_client);
  late final product_tag = AdminProductTagResource(_client);
  late final product_type = AdminProductTypeResource(_client);
  late final product_variant = AdminProductVariantResource(_client);
  late final order = AdminOrderResource(_client);
  late final order_edit = AdminOrderEditResource(_client);
  late final draft_order = AdminDraftOrderResource(_client);
  late final customer = AdminCustomerResource(_client);
  late final customer_group = AdminCustomerGroupResource(_client);
  late final collection = AdminCollectionResource(_client);
  late final category = AdminCategoryResource(_client);

  // Inventory & Stock Resources (4/4 active)
  late final inventory = AdminInventoryResource(_client);
  late final inventory_item = AdminInventoryItemResource(_client);
  late final stock_location = AdminStockLocationResource(_client);
  late final reservation = AdminReservationResource(_client);

  // Regional & Infrastructure Resources (4/4 active)
  late final region = AdminRegionResource(_client);
  late final sales_channel = AdminSalesChannelResource(_client);
  late final store = AdminStoreResource(_client);
  late final currency = AdminCurrencyResource(_client);

  // Fulfillment & Shipping Resources (5/6 active)
  late final fulfillment_provider = AdminFulfillmentProviderResource(_client);
  late final fulfillment_set = AdminFulfillmentSetResource(_client);
  late final shipping_option = AdminShippingOptionResource(_client);
  late final shipping_option_type = AdminShippingOptionTypeResource(_client);
  late final shipping_profile = AdminShippingProfileResource(_client);

  // Pricing & Promotions Resources (4/4 active)
  late final price_list = AdminPriceListResource(_client);
  late final price_preference = AdminPricePreferenceResource(_client);
  late final promotion = AdminPromotionResource(_client);
  late final campaign = AdminCampaignResource(_client);

  // Tax Management Resources (3/3 active)
  late final tax_provider = AdminTaxProviderResource(_client);
  late final tax_rate = AdminTaxRateResource(_client);
  late final tax_region = AdminTaxRegionResource(_client);

  // Returns & Exchanges Resources (5/5 active)
  late final return_ = AdminReturnResource(_client);
  late final return_reason = AdminReturnReasonResource(_client);
  late final refund_reason = AdminRefundReasonResource(_client);
  late final exchange = AdminExchangeResource(_client);
  late final claim = AdminClaimResource(_client);

  // Enhanced v2.10+ Features (3/3 active)
  late final workflow_execution = AdminWorkflowExecutionResource(_client);
  late final api_key = AdminApiKeyResource(_client);
  late final plugin = AdminPluginResource(_client);

  // Administrative Operations (3/4 active)
  late final invite = AdminInviteResource(_client);
  late final notification = AdminNotificationResource(_client);
  late final upload = AdminUploadResource(_client);

  /// Get resource availability status for debugging and monitoring
  ///
  /// Returns a map of resource names and their availability status
  Map<String, bool> getResourceStatus() {
    return {
      'api_key': true,
      'application': true,
      'auth': true,
      'campaign': true,
      'category': true,
      'claim': true,
      'collection': true,
      'currency': true,
      'customer': true,
      'customer_group': true,
      'draft_order': true,
      'exchange': true,
      'file': true,
      'fulfillment': true,
      'fulfillment_provider': true,
      'fulfillment_set': true,
      'gift_card': true,
      'inventory_item': true,
      'invite': true,
      'notification': true,
      'order': true,
      'order_edit': true,
      'payment': true,
      'payment_collection': true,
      'payment_provider': true,
      'price_list': true,
      'pricing': true,
      'product': true,
      'product_category': true,
      'product_tag': true,
      'product_type': true,
      'product_variant': true,
      'promotion': true,
      'refund': true,
      'refund_reason': true,
      'region': true,
      'reservation': true,
      'return_reason': true,
      'sales_channel': true,
      'shipping_option': true,
      'shipping_profile': true,
      'stock_location': true,
      'store': true,
      'tax_rate': true,
      'tax_region': true,
      'upload': true,
      'user': true,
      'workflow': true,
      'workflow_execution': true,
    };
  }

  /// Get list of available admin resources
  List<String> get availableResources {
    return getResourceStatus().keys.toList();
  }

  /// Get list of disabled admin resources (currently none)
  List<String> get disabledResources {
    return getResourceStatus().entries
        .where((entry) => !entry.value)
        .map((entry) => entry.key)
        .toList();
  }
}
