import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin customer management resource
///
/// Uses AdminCustomer model from @medusajs/types v2.10.1
/// for enhanced admin-specific customer management capabilities.
class AdminCustomerResource extends AdminResource {
  const AdminCustomerResource(super.client);

  String get resourcePath => '$basePath/customers';

  /// List customers
  Future<PaginatedResponse<AdminCustomer>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminCustomer>(
      endpoint: resourcePath,
      dataKey: 'customers',
      fromJson: AdminCustomer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a customer by ID
  Future<AdminCustomer?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminCustomer>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'customer',
      fromJson: AdminCustomer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new customer
  Future<AdminCustomer?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminCustomer>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'customer',
      fromJson: AdminCustomer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a customer
  Future<AdminCustomer?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminCustomer>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'customer',
      fromJson: AdminCustomer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a customer
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

  /// Search customers
  Future<PaginatedResponse<AdminCustomer>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }

  /// Get customers by email
  Future<PaginatedResponse<AdminCustomer>> byEmail(
    String email, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['email'] = email;

    return list(query: query, headers: headers);
  }

  /// Get customers by group
  Future<PaginatedResponse<AdminCustomer>> byGroup(
    String groupId, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['group_id'] = groupId;

    return list(query: query, headers: headers);
  }

  /// Add customer to group
  Future<AdminCustomer?> addToGroup(
    String customerId,
    String groupId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$customerId/groups/$groupId',
      method: 'POST',
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? AdminCustomer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }

  /// Remove customer from group
  Future<AdminCustomer?> removeFromGroup(
    String customerId,
    String groupId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$customerId/groups/$groupId',
      method: 'DELETE',
      headers: headers,
    );

    final customerData = response['customer'];
    return customerData != null
        ? AdminCustomer.fromJson(customerData as Map<String, dynamic>)
        : null;
  }
}
