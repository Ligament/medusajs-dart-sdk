// =============================================================================
// STORE AND ADMIN MODELS - Official @medusajs/types v2.10.1 (PRIMARY)
// =============================================================================

// Store Models
export 'store_customer.dart';
export 'store_customer_requests.dart';
export 'store_product.dart'
    hide StoreProductCategory; // Use full versions from infrastructure
export 'store_commerce.dart';
export 'store_infrastructure.dart' hide StoreCollection;
export 'store_shipping_option.dart';

// Admin Models
export 'admin_product.dart';
export 'admin_order.dart';
export 'admin_customer.dart'
    hide CustomerGroup, CustomerAddress; // Avoid conflicts with legacy models
export 'admin_customer_group.dart';
export 'admin_exchange.dart';
export 'admin_fulfillment.dart';
export 'admin_region.dart'
    hide
        AdminPaymentProvider,
        AdminFulfillmentProvider; // Use infrastructure model
export 'admin_user.dart';
export 'admin_inventory_item.dart';
export 'admin_stock_location.dart'
    hide AdminSalesChannel, AdminFulfillmentProvider; // Avoid conflicts
export 'admin_price_list.dart';
export 'admin_promotion.dart';
export 'admin_sales_channel.dart';
export 'admin_collection.dart';
export 'admin_product_category.dart'
    hide AdminProductStatus; // Conflict with common.dart
export 'admin_currency.dart';
export 'admin_payment.dart'
    hide
        AdminPaymentProvider,
        PaymentSessionStatus,
        PaymentCollectionStatus; // Avoid conflicts with other models
export 'admin_workflow_execution.dart';

// Essential common types still needed by resources
export 'common.dart';
export 'order_edit.dart';
export 'draft_order.dart';
export 'category.dart';
export 'tax.dart' hide TaxRate; // Use TaxRate from store_infrastructure.dart
export 'api_key.dart';
export 'campaign.dart';
export 'customer.dart';

// Core model types needed by admin resources
export 'order.dart';
export 'user.dart';
// export 'product.dart';
export 'product_tag.dart';
export 'product_type.dart';
export 'product_variant.dart';
export 'notification.dart';
export 'payment_collection.dart'
    hide PaymentSessionStatus; // Avoid conflict with common.dart
export 'inventory.dart'
    hide Reservation; // Avoid conflict with reservation.dart
export 'fulfillment.dart'
    hide
        FulfillmentStatus,
        ShippingOption; // Avoid conflicts with common.dart and store_infrastructure.dart
export 'reservation.dart';
export 'return.dart';
export 'upload.dart';
export 'claim.dart';
export 'region.dart';
