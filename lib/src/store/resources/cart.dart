import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store cart resource for cart management operations
///
/// Uses Store models from store_commerce.dart
/// for 100% @medusajs/types v2.10.1 compatibility
class StoreCartResource extends StoreResource {
  const StoreCartResource(super.client);

  String get resourcePath => '$basePath/carts';

  /// Create a cart
  Future<StoreCart?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<StoreCart>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'cart',
      fromJson: StoreCart.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a cart
  Future<StoreCart?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<StoreCart>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'cart',
      fromJson: StoreCart.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a cart by ID
  Future<StoreCart?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<StoreCart>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'cart',
      fromJson: StoreCart.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Add line item to cart
  Future<StoreCart?> createLineItem(
    String cartId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/line-items',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? StoreCart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Update line item in cart
  Future<StoreCart?> updateLineItem(
    String cartId,
    String lineItemId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/line-items/$lineItemId',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? StoreCart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Delete line item from cart
  Future<Map<String, dynamic>> deleteLineItem(
    String cartId,
    String lineItemId, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/line-items/$lineItemId',
      method: 'DELETE',
      headers: headers,
    );
  }

  /// Add shipping method to cart
  Future<StoreCart?> addShippingMethod(
    String cartId,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/shipping-methods',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? StoreCart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Complete cart (place order)
  Future<Map<String, dynamic>> complete(
    String cartId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/complete',
      method: 'POST',
      query: query,
      headers: headers,
    );
  }

  /// Transfer cart to logged-in customer
  Future<StoreCart?> transferCart(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/customer',
      method: 'POST',
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? StoreCart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Apply discount code to cart
  Future<StoreCart?> applyDiscount(
    String cartId,
    String discountCode, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final body = {'code': discountCode};

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/discounts/$discountCode',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? StoreCart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }

  /// Remove discount from cart
  Future<StoreCart?> removeDiscount(
    String cartId,
    String discountCode, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$cartId/discounts/$discountCode',
      method: 'DELETE',
      headers: headers,
    );

    final cartData = response['cart'];
    return cartData != null
        ? StoreCart.fromJson(cartData as Map<String, dynamic>)
        : null;
  }
}
