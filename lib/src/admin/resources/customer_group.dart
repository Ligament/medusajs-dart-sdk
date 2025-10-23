import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin customer group management resource
///
/// Uses AdminCustomerGroup model from @medusajs/types v2.10.1
/// for comprehensive customer group management capabilities.
///
/// Provides type-safe access to the Medusa Admin Customer Group API
/// with enhanced admin-specific functionality.
///
/// Example:
/// ```dart
/// // List customer groups
/// final groups = await medusa.admin.customerGroup.list();
///
/// // Create a new customer group
/// final newGroup = await medusa.admin.customerGroup.create(
///   AdminCreateCustomerGroupRequest(
///     name: 'VIP Customers',
///     description: 'High-value customers with special pricing',
///   ),
/// );
///
/// // Add customers to group
/// await medusa.admin.customerGroup.addCustomers(
///   groupId,
///   ['customer-1', 'customer-2'],
/// );
/// ```
class AdminCustomerGroupResource extends AdminResource {
  const AdminCustomerGroupResource(super.client);

  String get resourcePath => '$basePath/customer-groups';

  /// List customer groups with enhanced filtering
  Future<PaginatedResponse<AdminCustomerGroup>> list({
    AdminCustomerGroupFilters? filters,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final combinedQuery = <String, dynamic>{...?filters?.toQuery(), ...?query};

    return await listGeneric<AdminCustomerGroup>(
      endpoint: resourcePath,
      dataKey: 'customer_groups',
      fromJson: AdminCustomerGroup.fromJson,
      query: combinedQuery,
      headers: headers,
    );
  }

  /// Retrieve a customer group by ID
  Future<AdminCustomerGroup?> retrieve(
    String id, {
    List<String>? expand,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final combinedQuery = <String, dynamic>{...?query};

    if (expand != null && expand.isNotEmpty) {
      combinedQuery['expand'] = expand.join(',');
    }

    return await retrieveGeneric<AdminCustomerGroup>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'customer_group',
      fromJson: AdminCustomerGroup.fromJson,
      query: combinedQuery,
      headers: headers,
    );
  }

  /// Create a new customer group
  Future<AdminCustomerGroup?> create(
    AdminCreateCustomerGroupRequest request, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminCustomerGroup>(
      body: request.toJson(),
      endpoint: resourcePath,
      dataKey: 'customer_group',
      fromJson: AdminCustomerGroup.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a customer group
  Future<AdminCustomerGroup?> update(
    String id,
    AdminUpdateCustomerGroupRequest request, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminCustomerGroup>(
      id: id,
      body: request.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'customer_group',
      fromJson: AdminCustomerGroup.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a customer group
  Future<AdminCustomerGroupDeleteResponse> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id',
      method: 'DELETE',
      headers: headers,
    );

    return AdminCustomerGroupDeleteResponse.fromJson(response);
  }

  /// Add a single customer to a group
  Future<AdminCustomerGroup?> addCustomer(
    String groupId,
    String customerId, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminCustomerGroup>(
      body: {'customer_id': customerId},
      endpoint: '$resourcePath/$groupId/customers',
      dataKey: 'customer_group',
      fromJson: AdminCustomerGroup.fromJson,
      headers: headers,
    );
  }

  /// Remove a single customer from a group
  Future<AdminCustomerGroup?> removeCustomer(
    String groupId,
    String customerId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$groupId/customers/$customerId',
      method: 'DELETE',
      headers: headers,
    );

    final groupData = response['customer_group'];
    return groupData != null
        ? AdminCustomerGroup.fromJson(groupData as Map<String, dynamic>)
        : null;
  }

  /// List customers in a group
  Future<PaginatedResponse<AdminCustomer>> getCustomers(
    String groupId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminCustomer>(
      endpoint: '$resourcePath/$groupId/customers',
      dataKey: 'customers',
      fromJson: AdminCustomer.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Add multiple customers to a group
  Future<AdminCustomerGroup?> addCustomers(
    String groupId,
    List<String> customerIds, {
    ClientHeaders? headers,
  }) async {
    final request = AdminAddCustomersToGroupRequest(customerIds: customerIds);

    return await createGeneric<AdminCustomerGroup>(
      body: request.toJson(),
      endpoint: '$resourcePath/$groupId/customers/batch',
      dataKey: 'customer_group',
      fromJson: AdminCustomerGroup.fromJson,
      headers: headers,
    );
  }

  /// Remove multiple customers from a group
  Future<AdminCustomerGroup?> removeCustomers(
    String groupId,
    List<String> customerIds, {
    ClientHeaders? headers,
  }) async {
    final request = AdminRemoveCustomersFromGroupRequest(
      customerIds: customerIds,
    );

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$groupId/customers/batch',
      method: 'DELETE',
      body: request.toJson(),
      headers: headers,
    );

    final groupData = response['customer_group'];
    return groupData != null
        ? AdminCustomerGroup.fromJson(groupData as Map<String, dynamic>)
        : null;
  }

  /// Search customer groups by name
  Future<PaginatedResponse<AdminCustomerGroup>> search(
    String searchTerm, {
    AdminCustomerGroupFilters? additionalFilters,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final filters = AdminCustomerGroupFilters(
      name: searchTerm,
      expand: additionalFilters?.expand,
      limit: additionalFilters?.limit,
      offset: additionalFilters?.offset,
      withDeleted: additionalFilters?.withDeleted,
    );

    return list(filters: filters, query: query, headers: headers);
  }

  /// Count total customer groups
  Future<int> count({
    AdminCustomerGroupFilters? filters,
    ClientHeaders? headers,
  }) async {
    final query = <String, dynamic>{...?filters?.toQuery(), 'count': true};

    final response = await client.fetch<Map<String, dynamic>>(
      resourcePath,
      query: query,
      headers: headers,
    );

    return response['count'] as int? ?? 0;
  }

  /// Bulk operations - create multiple customer groups
  Future<List<AdminCustomerGroup>> createBulk(
    List<AdminCreateCustomerGroupRequest> requests, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/batch',
      method: 'POST',
      body: {'customer_groups': requests.map((r) => r.toJson()).toList()},
      headers: headers,
    );

    final groupsData = response['customer_groups'] as List?;
    return groupsData
            ?.map(
              (data) =>
                  AdminCustomerGroup.fromJson(data as Map<String, dynamic>),
            )
            .toList() ??
        [];
  }

  /// Check if a customer is in a specific group
  Future<bool> isCustomerInGroup(
    String groupId,
    String customerId, {
    ClientHeaders? headers,
  }) async {
    try {
      final customers = await getCustomers(
        groupId,
        query: {'customer_id': customerId, 'limit': 1},
        headers: headers,
      );
      return customers.data.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
