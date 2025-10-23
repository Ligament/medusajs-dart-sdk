import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store fulfillment resource for shipping options and calculations
class StoreFulfillmentResource extends StoreResource {
  const StoreFulfillmentResource(super.client);

  String get resourcePath => '$basePath/shipping-options';

  /// List shipping options for a cart
  ///
  /// This method retrieves the list of shipping options for a cart. It sends a
  /// request to the List Shipping Options API route.
  ///
  /// Related guide: Implement shipping step during checkout.
  ///
  /// Example:
  /// ```dart
  /// final options = await medusa.store.fulfillment.listCartOptions(
  ///   cartId: 'cart_123',
  /// );
  /// ```
  Future<StoreShippingOptionListResponse> listCartOptions({
    String? cartId,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final queryParams = Map<String, dynamic>.from(query ?? {});
    if (cartId != null) {
      queryParams['cart_id'] = cartId;
    }

    final response = await client.fetch<Map<String, dynamic>>(
      resourcePath,
      query: queryParams,
      headers: headers,
    );

    return StoreShippingOptionListResponse.fromJson(response);
  }

  /// Calculate shipping option price for a cart
  ///
  /// This method calculates the price of a shipping option in a cart, which is useful
  /// during checkout. It sends a request to the Calculate Shipping Option Price API route.
  ///
  /// Example:
  /// ```dart
  /// final option = await medusa.store.fulfillment.calculate(
  ///   'so_123',
  ///   cartId: 'cart_123',
  /// );
  /// ```
  Future<StoreShippingOptionResponse?> calculate(
    String shippingOptionId, {
    String? cartId,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final requestBody = Map<String, dynamic>.from(body ?? {});
    if (cartId != null) {
      requestBody['cart_id'] = cartId;
    }

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$shippingOptionId/calculate',
      method: 'POST',
      body: requestBody,
      query: query,
      headers: headers,
    );

    return StoreShippingOptionResponse.fromJson(response);
  }

  /// List shipping options for a region
  Future<StoreShippingOptionListResponse> listForRegion(
    String regionId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['region_id'] = regionId;

    return listCartOptions(query: query, headers: headers);
  }

  /// Get shipping options by provider
  Future<StoreShippingOptionListResponse> byProvider(
    String providerId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['provider_id'] = providerId;

    return listCartOptions(query: query, headers: headers);
  }

  /// Get cheapest shipping option for cart
  Future<StoreCartShippingOption?> getCheapest({
    String? cartId,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final options = await listCartOptions(
      cartId: cartId,
      query: additionalFilters,
      headers: headers,
    );

    if (options.shippingOptions.isEmpty) return null;

    // Find option with lowest calculated price
    StoreCartShippingOption? cheapest;
    int? lowestPrice;

    for (final option in options.shippingOptions) {
      final calculated = await calculate(
        option.id,
        cartId: cartId,
        headers: headers,
      );

      if (calculated != null) {
        final price =
            calculated.shippingOption.calculatedPrice?.calculatedAmount;
        if (price != null && (lowestPrice == null || price < lowestPrice)) {
          lowestPrice = price;
          cheapest = calculated.shippingOption;
        }
      }
    }

    return cheapest;
  }

  /// Get fastest shipping option for cart
  Future<StoreCartShippingOption?> getFastest({
    String? cartId,
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['sort'] = 'delivery_time';
    query['order'] = 'asc';

    final options = await listCartOptions(
      cartId: cartId,
      query: query,
      headers: headers,
    );

    return options.shippingOptions.isNotEmpty
        ? options.shippingOptions.first
        : null;
  }
}
