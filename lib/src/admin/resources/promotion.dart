import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin promotion management resource
///
/// Provides comprehensive promotion management capabilities including
/// CRUD operations, rule management, and campaign integration for
/// discount management and promotional strategies.
class AdminPromotionResource extends AdminResource {
  const AdminPromotionResource(super.client);

  String get resourcePath => '$basePath/promotions';

  /// List promotions
  ///
  /// Retrieves a list of promotions with pagination support and filtering capabilities.
  ///
  /// Example:
  /// ```dart
  /// final promotions = await medusa.admin.promotion.list(
  ///   query: {'status': 'active', 'limit': 20}
  /// );
  /// ```
  Future<PaginatedResponse<AdminPromotion>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminPromotion>(
      endpoint: resourcePath,
      dataKey: 'promotions',
      fromJson: AdminPromotion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a promotion by ID
  ///
  /// Gets detailed information about a specific promotion including
  /// application methods, rules, and campaign associations.
  ///
  /// Example:
  /// ```dart
  /// final promotion = await medusa.admin.promotion.retrieve('promo_123');
  /// ```
  Future<AdminPromotion?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminPromotion>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'promotion',
      fromJson: AdminPromotion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new promotion
  ///
  /// Creates a new promotion with the specified configuration.
  /// Supports creating promotions with rules and application methods.
  ///
  /// Example:
  /// ```dart
  /// final newPromotion = await medusa.admin.promotion.create(
  ///   AdminCreatePromotion(
  ///     code: 'SUMMER2024',
  ///     type: AdminPromotionType.standard,
  ///     status: AdminPromotionStatus.active,
  ///     applicationMethod: AdminCreateApplicationMethod(
  ///       type: AdminApplicationMethodType.percentage,
  ///       targetType: AdminApplicationMethodTargetType.items,
  ///       allocation: AdminApplicationMethodAllocation.each,
  ///       value: 20.0,
  ///     ),
  ///   )
  /// );
  /// ```
  Future<AdminPromotion?> create(
    AdminCreatePromotion createRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminPromotion>(
      body: createRequest.toJson(),
      endpoint: resourcePath,
      dataKey: 'promotion',
      fromJson: AdminPromotion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a promotion
  ///
  /// Updates an existing promotion with new configuration.
  /// All fields in the update request are optional.
  ///
  /// Example:
  /// ```dart
  /// final updated = await medusa.admin.promotion.update(
  ///   'promo_123',
  ///   AdminUpdatePromotion(
  ///     status: AdminPromotionStatus.inactive,
  ///     code: 'AUTUMN2024',
  ///   )
  /// );
  /// ```
  Future<AdminPromotion?> update(
    String id,
    AdminUpdatePromotion updateRequest, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminPromotion>(
      id: id,
      body: updateRequest.toJson(),
      endpoint: '$resourcePath/$id',
      dataKey: 'promotion',
      fromJson: AdminPromotion.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a promotion
  ///
  /// Removes a promotion and its associated rules and application methods.
  /// This action cannot be undone.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.promotion.delete('promo_123');
  /// ```
  Future<AdminPromotionDeleteResponse> delete(
    String id, {
    ClientHeaders? headers,
  }) async {
    final response = await deleteGeneric(
      id: id,
      endpoint: '$resourcePath/$id',
      headers: headers,
    );

    return AdminPromotionDeleteResponse.fromJson(response);
  }

  /// Search promotions by code
  ///
  /// Searches for promotions that match the provided search term.
  /// Useful for finding promotions by partial code matches.
  ///
  /// Example:
  /// ```dart
  /// final found = await medusa.admin.promotion.search('SUMMER');
  /// ```
  Future<PaginatedResponse<AdminPromotion>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }

  /// Get promotions by code
  ///
  /// Retrieves promotions that match the exact code.
  ///
  /// Example:
  /// ```dart
  /// final promotions = await medusa.admin.promotion.byCode('SUMMER2024');
  /// ```
  Future<PaginatedResponse<AdminPromotion>> byCode(
    String code, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['code'] = code;

    return list(query: query, headers: headers);
  }

  /// Get active promotions
  ///
  /// Retrieves all promotions that are currently active and valid.
  ///
  /// Example:
  /// ```dart
  /// final activePromotions = await medusa.admin.promotion.getActive();
  /// ```
  Future<PaginatedResponse<AdminPromotion>> getActive({
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['status'] = 'active';

    return list(query: query, headers: headers);
  }

  /// Get promotions by type
  ///
  /// Retrieves promotions filtered by their type (standard or buyget).
  ///
  /// Example:
  /// ```dart
  /// final standardPromotions = await medusa.admin.promotion.byType('standard');
  /// ```
  Future<PaginatedResponse<AdminPromotion>> byType(
    AdminPromotionType type, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['type'] = type.name;

    return list(query: query, headers: headers);
  }

  /// Add rule to promotion
  ///
  /// Adds a new rule to an existing promotion. Rules define the conditions
  /// that must be met for the promotion to be applicable.
  ///
  /// Example:
  /// ```dart
  /// final updated = await medusa.admin.promotion.addRule(
  ///   'promo_123',
  ///   AdminCreatePromotionRule(
  ///     attribute: 'customer_group_id',
  ///     operator: AdminPromotionRuleOperator.in_,
  ///     values: ['cg_vip', 'cg_members'],
  ///   )
  /// );
  /// ```
  Future<AdminPromotion?> addRule(
    String id,
    AdminCreatePromotionRule ruleData, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/rules',
      method: 'POST',
      body: ruleData.toJson(),
      headers: headers,
    );

    final data = response['promotion'];
    return data != null
        ? AdminPromotion.fromJson(data as Map<String, dynamic>)
        : null;
  }

  /// Remove rule from promotion
  ///
  /// Removes a specific rule from a promotion by rule ID.
  ///
  /// Example:
  /// ```dart
  /// final updated = await medusa.admin.promotion.removeRule('promo_123', 'rule_456');
  /// ```
  Future<AdminPromotion?> removeRule(
    String id,
    String ruleId, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/$id/rules/$ruleId',
      method: 'DELETE',
      headers: headers,
    );

    final data = response['promotion'];
    return data != null
        ? AdminPromotion.fromJson(data as Map<String, dynamic>)
        : null;
  }
}
