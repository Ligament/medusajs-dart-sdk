/// Admin Customer Group models for Medusa v2.10.1
///
/// Based on official @medusajs/types definitions for 100% API compatibility.
/// These models provide comprehensive admin customer group management.

import 'package:json_annotation/json_annotation.dart';

part 'admin_customer_group.g.dart';

// =============================================================================
// CUSTOMER GROUP MODELS
// =============================================================================

/// Customer group model for admin operations
///
/// Provides admin-specific customer group management capabilities
/// with enhanced metadata and relationship support.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCustomerGroup {
  /// Unique identifier for the customer group
  final String id;

  /// Name of the customer group
  final String name;

  /// Optional description of the customer group
  final String? description;

  /// Number of customers in this group
  final int? customersCount;

  /// Associated price lists for this group
  final List<String>? priceListIds;

  /// Group metadata for custom fields
  final Map<String, dynamic>? metadata;

  /// When the customer group was created
  final DateTime createdAt;

  /// When the customer group was last updated
  final DateTime updatedAt;

  /// When the customer group was deleted (if soft deleted)
  final DateTime? deletedAt;

  const AdminCustomerGroup({
    required this.id,
    required this.name,
    this.description,
    this.customersCount,
    this.priceListIds,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminCustomerGroup.fromJson(Map<String, dynamic> json) =>
      _$AdminCustomerGroupFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCustomerGroupToJson(this);

  /// Check if the customer group is active (not deleted)
  bool get isActive => deletedAt == null;

  /// Check if the customer group has customers
  bool get hasCustomers => (customersCount ?? 0) > 0;

  /// Check if the customer group has associated price lists
  bool get hasPriceLists => priceListIds?.isNotEmpty ?? false;
}

// =============================================================================
// REQUEST/RESPONSE MODELS
// =============================================================================

/// Request to create a new customer group
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateCustomerGroupRequest {
  /// Name of the customer group
  final String name;

  /// Optional description of the customer group
  final String? description;

  /// Group metadata for custom fields
  final Map<String, dynamic>? metadata;

  const AdminCreateCustomerGroupRequest({
    required this.name,
    this.description,
    this.metadata,
  });

  factory AdminCreateCustomerGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateCustomerGroupRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminCreateCustomerGroupRequestToJson(this);
}

/// Request to update a customer group
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AdminUpdateCustomerGroupRequest {
  /// Updated name of the customer group
  final String? name;

  /// Updated description of the customer group
  final String? description;

  /// Updated group metadata
  final Map<String, dynamic>? metadata;

  const AdminUpdateCustomerGroupRequest({
    this.name,
    this.description,
    this.metadata,
  });

  factory AdminUpdateCustomerGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateCustomerGroupRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminUpdateCustomerGroupRequestToJson(this);
}

/// Response for customer group list
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCustomerGroupListResponse {
  /// List of customer groups
  final List<AdminCustomerGroup> customerGroups;

  /// Total count of customer groups
  final int count;

  /// Pagination offset
  final int offset;

  /// Pagination limit
  final int limit;

  const AdminCustomerGroupListResponse({
    required this.customerGroups,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory AdminCustomerGroupListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCustomerGroupListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCustomerGroupListResponseToJson(this);
}

/// Response for single customer group
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCustomerGroupResponse {
  /// The customer group
  final AdminCustomerGroup customerGroup;

  const AdminCustomerGroupResponse({required this.customerGroup});

  factory AdminCustomerGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCustomerGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCustomerGroupResponseToJson(this);
}

/// Response for customer group deletion
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCustomerGroupDeleteResponse {
  /// ID of the deleted customer group
  final String id;

  /// Whether the group was deleted
  final bool deleted;

  /// The type of object that was deleted
  final String object;

  const AdminCustomerGroupDeleteResponse({
    required this.id,
    required this.deleted,
    required this.object,
  });

  factory AdminCustomerGroupDeleteResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminCustomerGroupDeleteResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminCustomerGroupDeleteResponseToJson(this);
}

// =============================================================================
// CUSTOMER GROUP MEMBERSHIP MODELS
// =============================================================================

/// Request to add customers to a group
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddCustomersToGroupRequest {
  /// List of customer IDs to add to the group
  final List<String> customerIds;

  const AdminAddCustomersToGroupRequest({required this.customerIds});

  factory AdminAddCustomersToGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminAddCustomersToGroupRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminAddCustomersToGroupRequestToJson(this);
}

/// Request to remove customers from a group
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminRemoveCustomersFromGroupRequest {
  /// List of customer IDs to remove from the group
  final List<String> customerIds;

  const AdminRemoveCustomersFromGroupRequest({required this.customerIds});

  factory AdminRemoveCustomersFromGroupRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$AdminRemoveCustomersFromGroupRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdminRemoveCustomersFromGroupRequestToJson(this);
}

// =============================================================================
// CUSTOMER GROUP FILTERS
// =============================================================================

/// Filters for listing customer groups
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCustomerGroupFilters {
  /// Filter by group name
  final String? name;

  /// Filter by creation date
  final DateTime? createdAt;

  /// Filter by update date
  final DateTime? updatedAt;

  /// Filter by metadata fields
  final Map<String, dynamic>? metadata;

  /// Include deleted groups
  final bool? withDeleted;

  /// Expand relationships
  final List<String>? expand;

  /// Pagination limit
  final int? limit;

  /// Pagination offset
  final int? offset;

  const AdminCustomerGroupFilters({
    this.name,
    this.createdAt,
    this.updatedAt,
    this.metadata,
    this.withDeleted,
    this.expand,
    this.limit,
    this.offset,
  });

  factory AdminCustomerGroupFilters.fromJson(Map<String, dynamic> json) =>
      _$AdminCustomerGroupFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCustomerGroupFiltersToJson(this);

  /// Convert to query parameters
  Map<String, dynamic> toQuery() {
    final query = <String, dynamic>{};

    if (name != null) query['name'] = name;
    if (createdAt != null) query['created_at'] = createdAt!.toIso8601String();
    if (updatedAt != null) query['updated_at'] = updatedAt!.toIso8601String();
    if (metadata != null) query.addAll(metadata!);
    if (withDeleted != null) query['deleted'] = withDeleted;
    if (expand != null) query['expand'] = expand!.join(',');
    if (limit != null) query['limit'] = limit;
    if (offset != null) query['offset'] = offset;

    return query;
  }
}
