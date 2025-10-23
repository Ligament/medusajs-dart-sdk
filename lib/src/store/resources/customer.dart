import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Store customer resource for customer account operations
///
/// Uses Store models from store_customer.dart
/// for 100% @medusajs/types v2.10.1 compatibility.
///
/// Provides type-safe access to the Medusa Store Customer API.
/// All operations return strongly-typed models.
///
/// Example:
/// ```dart
/// // Create a new customer account
/// final customer = await medusa.store.customer.create(
///   StoreCreateCustomer(
///     email: 'customer@example.com',
///     firstName: 'John',
///     lastName: 'Doe',
///   ),
/// );
///
/// // Get current customer
/// final me = await medusa.store.customer.retrieve();
///
/// // Add new address
/// final address = await medusa.store.customer.createAddress(
///   StoreCreateCustomerAddress(
///     address1: '123 Main St',
///     city: 'New York',
///     countryCode: 'US',
///     postalCode: '10001',
///   ),
/// );
/// ```
class StoreCustomerResource extends StoreResource {
  const StoreCustomerResource(super.client);

  String get resourcePath => '$basePath/customers';

  /// Create a customer (register)
  Future<StoreCustomer?> create(
    StoreCreateCustomer request, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final customer = await createGeneric<StoreCustomer>(
      body: request.toJson(),
      endpoint: resourcePath,
      dataKey: 'customer',
      fromJson: StoreCustomer.fromJson,
      query: query,
      headers: headers,
    );
    return customer;
  }

  /// Create customer with Map (backward compatibility)
  Future<Customer?> createFromMap(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<Customer>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'customer',
      fromJson: Customer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve current customer
  Future<StoreCustomer?> retrieve({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me',
      method: 'GET',
      query: query,
      headers: headers,
    );

    final customerData = response['customer'] as Map<String, dynamic>?;
    return customerData != null ? StoreCustomer.fromJson(customerData) : null;
  }

  /// Update current customer
  Future<StoreCustomer?> update(
    StoreUpdateCustomer request, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me',
      method: 'POST',
      body: request.toJson(),
      query: query,
      headers: headers,
    );

    final customerData = response['customer'] as Map<String, dynamic>;
    final customer = StoreCustomer.fromJson(customerData);
    return customer;
  }

  /// Create customer address
  Future<StoreCustomer?> createAddress(
    StoreCreateCustomerAddress request, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses',
      method: 'POST',
      body: request.toJson(),
      query: query,
      headers: headers,
    );

    final customerData = response['customer'] as Map<String, dynamic>;
    return StoreCustomer.fromJson(customerData);
  }

  /// Update customer address
  Future<StoreCustomer?> updateAddress(
    String addressId,
    StoreUpdateCustomerAddress request, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses/$addressId',
      method: 'POST',
      body: request.toJson(),
      query: query,
      headers: headers,
    );

    final customerData = response['customer'] as Map<String, dynamic>;
    return StoreCustomer.fromJson(customerData);
  }

  /// List customer addresses
  Future<List<StoreCustomerAddress>> listAddress({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses',
      query: query,
      headers: headers,
    );

    final addresses =
        (response['addresses'] as List? ?? [])
            .map(
              (json) =>
                  StoreCustomerAddress.fromJson(json as Map<String, dynamic>),
            )
            .toList();

    return addresses;
  }

  /// List addresses with pagination (backward compatibility)
  Future<PaginatedResponse<StoreCustomerAddress>> listAddresses({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses',
      query: query,
      headers: headers,
    );

    final addresses =
        (response['addresses'] as List? ?? [])
            .map(
              (json) =>
                  StoreCustomerAddress.fromJson(json as Map<String, dynamic>),
            )
            .toList();

    return PaginatedResponse(
      data: addresses,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Retrieve customer address
  Future<StoreCustomerAddress?> retrieveAddress(
    String addressId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    try {
      final response = await client.fetch<Map<String, dynamic>>(
        '$resourcePath/me/addresses/$addressId',
        query: query,
        headers: headers,
      );

      final addressData = response['address'];
      if (addressData == null) return null;

      return StoreCustomerAddress.fromJson(addressData as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  /// Delete customer address
  Future<bool> deleteAddress(String addressId, {ClientHeaders? headers}) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/me/addresses/$addressId',
      method: 'DELETE',
      headers: headers,
    );

    return response['deleted'] as bool? ?? true;
  }

  /// Request password reset
  Future<Map<String, dynamic>> requestPasswordReset(
    String email, {
    ClientHeaders? headers,
  }) async {
    final body = {'email': email};

    return await client.fetch<Map<String, dynamic>>(
      '$resourcePath/password-token',
      method: 'POST',
      body: body,
      headers: headers,
    );
  }

  /// Reset password with structured request
  Future<StoreCustomer?> resetPassword(
    Map<String, dynamic> request, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/password-reset',
      method: 'POST',
      body: request,
      headers: headers,
    );

    final customerData = response['customer'];
    if (customerData == null) return null;

    return StoreCustomer.fromJson(customerData as Map<String, dynamic>);
  }

  /// Reset password (backward compatibility)
  Future<Customer?> resetPasswordLegacy(
    Map<String, dynamic> body, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/password-reset',
      method: 'POST',
      body: body,
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? Customer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }
}
