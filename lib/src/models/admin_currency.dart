// ignore_for_file: invalid_annotation_target

import 'package:json_annotation/json_annotation.dart';

part 'admin_currency.g.dart';

/// Admin Currency Management Models
///
///  implementation based on @medusajs/types v2.10.1
/// OpenAPI definitions for comprehensive currency management.

// =============================================================================
// CORE CURRENCY MODELS
// =============================================================================

/// AdminCurrency
///
/// Represents a currency that can be used in the store with complete
/// administrative properties including creation/update/deletion tracking.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCurrency {
  /// The currency's code (e.g., "usd", "eur", "gbp")
  final String code;

  /// The currency's symbol (e.g., "$", "€", "£")
  final String symbol;

  /// The currency's native symbol, if different than the symbol
  final String symbolNative;

  /// The currency's display name
  final String name;

  /// The number of digits after the decimal for prices in this currency
  final num decimalDigits;

  /// The rounding precision applied on prices in this currency
  final num rounding;

  /// The currency's creation date
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The currency's update date
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The currency's deletion date
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminCurrency({
    required this.code,
    required this.symbol,
    required this.symbolNative,
    required this.name,
    required this.decimalDigits,
    required this.rounding,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminCurrency.fromJson(Map<String, dynamic> json) =>
      _$AdminCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCurrencyToJson(this);

  /// Check if currency is deleted
  bool get isDeleted => deletedAt != null;

  /// Get formatted amount with currency symbol
  String formatAmount(num amount, {bool showCode = false}) {
    final formattedAmount = (amount / (decimalDigits == 0 ? 1 : 100))
        .toStringAsFixed(decimalDigits.toInt());

    if (showCode) {
      return '$symbol$formattedAmount $code';
    }
    return '$symbol$formattedAmount';
  }

  /// Check if this is a major currency (commonly used)
  bool get isMajorCurrency =>
      ['usd', 'eur', 'gbp', 'jpy', 'cad', 'aud'].contains(code.toLowerCase());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminCurrency &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() =>
      'AdminCurrency(code: $code, name: $name, symbol: $symbol)';
}

/// AdminStoreCurrency
///
/// Represents the relationship between a store and a currency,
/// including whether it's the default currency for the store.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStoreCurrency {
  /// The store currency relationship ID
  final String id;

  /// The currency's code
  final String currencyCode;

  /// The ID of the store this currency belongs to
  final String storeId;

  /// Whether this currency is the default in the store
  final bool isDefault;

  /// The full currency details
  final AdminCurrency currency;

  /// The date the currency was added to the store
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// The date the currency was updated
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// The date the currency was removed from the store
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  const AdminStoreCurrency({
    required this.id,
    required this.currencyCode,
    required this.storeId,
    required this.isDefault,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory AdminStoreCurrency.fromJson(Map<String, dynamic> json) =>
      _$AdminStoreCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$AdminStoreCurrencyToJson(this);

  /// Check if currency is active in store
  bool get isActive => deletedAt == null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminStoreCurrency &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'AdminStoreCurrency(id: $id, currencyCode: $currencyCode, isDefault: $isDefault)';
}

// =============================================================================
// RESPONSE MODELS
// =============================================================================

/// AdminCurrencyResponse
///
/// Response wrapper for single currency retrieval operations.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCurrencyResponse {
  /// The currency details
  final AdminCurrency currency;

  const AdminCurrencyResponse({required this.currency});

  factory AdminCurrencyResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCurrencyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCurrencyResponseToJson(this);
}

/// AdminCurrencyListResponse
///
/// Response wrapper for paginated currency list operations.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCurrencyListResponse {
  /// The maximum number of items returned
  final num limit;

  /// The number of items skipped before retrieving the returned items
  final num offset;

  /// The total number of items
  final num count;

  /// The list of currencies
  final List<AdminCurrency> currencies;

  /// The estimated count from PostgreSQL query planner (may be inaccurate)
  @JsonKey(name: 'estimate_count', includeIfNull: false)
  final num? estimateCount;

  const AdminCurrencyListResponse({
    required this.limit,
    required this.offset,
    required this.count,
    required this.currencies,
    this.estimateCount,
  });

  factory AdminCurrencyListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminCurrencyListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCurrencyListResponseToJson(this);

  /// Check if there are more items available
  bool get hasMore => offset + limit < count;

  /// Get the next offset for pagination
  num get nextOffset => offset + limit;

  /// Check if this is the first page
  bool get isFirstPage => offset == 0;

  /// Check if this is the last page
  bool get isLastPage => !hasMore;
}

// =============================================================================
// REQUEST MODELS
// =============================================================================

/// AdminCreateCurrencyRequest
///
/// Request model for creating a new currency.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCreateCurrencyRequest {
  /// The currency's code (ISO 4217 format recommended)
  final String code;

  /// The currency's symbol
  final String symbol;

  /// The currency's native symbol
  final String? symbolNative;

  /// The currency's display name
  final String name;

  /// The number of digits after the decimal
  final num? decimalDigits;

  /// The rounding precision
  final num? rounding;

  const AdminCreateCurrencyRequest({
    required this.code,
    required this.symbol,
    this.symbolNative,
    required this.name,
    this.decimalDigits,
    this.rounding,
  });

  factory AdminCreateCurrencyRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminCreateCurrencyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCreateCurrencyRequestToJson(this);
}

/// AdminUpdateCurrencyRequest
///
/// Request model for updating an existing currency.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminUpdateCurrencyRequest {
  /// The currency's symbol
  final String? symbol;

  /// The currency's native symbol
  final String? symbolNative;

  /// The currency's display name
  final String? name;

  /// The number of digits after the decimal
  final num? decimalDigits;

  /// The rounding precision
  final num? rounding;

  const AdminUpdateCurrencyRequest({
    this.symbol,
    this.symbolNative,
    this.name,
    this.decimalDigits,
    this.rounding,
  });

  factory AdminUpdateCurrencyRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateCurrencyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateCurrencyRequestToJson(this);
}

/// AdminAddStoreCurrencyRequest
///
/// Request model for adding a currency to a store.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminAddStoreCurrencyRequest {
  /// The currency code to add
  final String currencyCode;

  /// Whether this should be the default currency
  final bool? isDefault;

  const AdminAddStoreCurrencyRequest({
    required this.currencyCode,
    this.isDefault,
  });

  factory AdminAddStoreCurrencyRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminAddStoreCurrencyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAddStoreCurrencyRequestToJson(this);
}

// =============================================================================
// FILTER AND QUERY MODELS
// =============================================================================

/// AdminCurrencyFilters
///
/// Filters for querying currencies with various criteria.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCurrencyFilters {
  /// Filter by currency codes
  final List<String>? code;

  /// Filter by symbol
  final String? symbol;

  /// Filter by name (partial match)
  final String? name;

  /// Include deleted currencies
  final bool? includeDeleted;

  /// Filter by creation date range
  @JsonKey(name: 'created_at')
  final Map<String, dynamic>? createdAt;

  /// Filter by update date range
  @JsonKey(name: 'updated_at')
  final Map<String, dynamic>? updatedAt;

  const AdminCurrencyFilters({
    this.code,
    this.symbol,
    this.name,
    this.includeDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminCurrencyFilters.fromJson(Map<String, dynamic> json) =>
      _$AdminCurrencyFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCurrencyFiltersToJson(this);
}

/// AdminStoreCurrencyFilters
///
/// Filters for querying store currencies.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminStoreCurrencyFilters {
  /// Filter by store ID
  final String? storeId;

  /// Filter by currency codes
  final List<String>? currencyCode;

  /// Filter by default status
  final bool? isDefault;

  /// Include deleted store currencies
  final bool? includeDeleted;

  const AdminStoreCurrencyFilters({
    this.storeId,
    this.currencyCode,
    this.isDefault,
    this.includeDeleted,
  });

  factory AdminStoreCurrencyFilters.fromJson(Map<String, dynamic> json) =>
      _$AdminStoreCurrencyFiltersFromJson(json);

  Map<String, dynamic> toJson() => _$AdminStoreCurrencyFiltersToJson(this);
}

// =============================================================================
// ANALYTICS AND STATISTICS MODELS
// =============================================================================

/// AdminCurrencyStats
///
/// Statistical data about currency usage and performance.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCurrencyStats {
  /// The currency code
  final String currencyCode;

  /// Total number of orders in this currency
  final int totalOrders;

  /// Total revenue in this currency (in minor units)
  final num totalRevenue;

  /// Average order value in this currency (in minor units)
  final num averageOrderValue;

  /// Number of active customers using this currency
  final int activeCustomers;

  /// Number of products priced in this currency
  final int productsCount;

  /// Usage percentage compared to other currencies
  final double usagePercentage;

  /// Trend data (growth/decline)
  final String trend; // 'up', 'down', 'stable'

  /// Period for these statistics
  final String period; // '7d', '30d', '90d', '1y'

  const AdminCurrencyStats({
    required this.currencyCode,
    required this.totalOrders,
    required this.totalRevenue,
    required this.averageOrderValue,
    required this.activeCustomers,
    required this.productsCount,
    required this.usagePercentage,
    required this.trend,
    required this.period,
  });

  factory AdminCurrencyStats.fromJson(Map<String, dynamic> json) =>
      _$AdminCurrencyStatsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCurrencyStatsToJson(this);

  /// Get formatted revenue with currency
  String getFormattedRevenue(AdminCurrency currency) {
    return currency.formatAmount(totalRevenue);
  }

  /// Get formatted average order value
  String getFormattedAOV(AdminCurrency currency) {
    return currency.formatAmount(averageOrderValue);
  }

  /// Check if this currency is trending up
  bool get isTrendingUp => trend == 'up';

  /// Check if this currency is trending down
  bool get isTrendingDown => trend == 'down';

  /// Check if this currency usage is stable
  bool get isStable => trend == 'stable';
}

/// AdminCurrencyAnalytics
///
/// Comprehensive analytics for currency performance and usage.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminCurrencyAnalytics {
  /// Currency statistics by period
  final List<AdminCurrencyStats> stats;

  /// Total number of supported currencies
  final int totalCurrencies;

  /// Number of active currencies (used in orders)
  final int activeCurrencies;

  /// Most used currency
  final String primaryCurrency;

  /// Currency distribution data
  final Map<String, double> distribution;

  /// Revenue breakdown by currency
  final Map<String, num> revenueBreakdown;

  /// Exchange rate trends (if applicable)
  final Map<String, List<Map<String, dynamic>>>? exchangeRates;

  const AdminCurrencyAnalytics({
    required this.stats,
    required this.totalCurrencies,
    required this.activeCurrencies,
    required this.primaryCurrency,
    required this.distribution,
    required this.revenueBreakdown,
    this.exchangeRates,
  });

  factory AdminCurrencyAnalytics.fromJson(Map<String, dynamic> json) =>
      _$AdminCurrencyAnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCurrencyAnalyticsToJson(this);

  /// Get total revenue across all currencies
  num get totalRevenue =>
      revenueBreakdown.values.fold(0, (sum, value) => sum + value);

  /// Get most profitable currency
  String get mostProfitableCurrency =>
      revenueBreakdown.entries.reduce((a, b) => a.value > b.value ? a : b).key;

  /// Get currency utilization rate
  double get utilizationRate =>
      totalCurrencies > 0 ? (activeCurrencies / totalCurrencies * 100) : 0.0;
}

// =============================================================================
// BULK OPERATIONS
// =============================================================================

/// AdminBulkCurrencyRequest
///
/// Request model for bulk currency operations.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminBulkCurrencyRequest {
  /// Currency codes to operate on
  final List<String> currencyCodes;

  /// Operation type
  final String
  operation; // 'create', 'update', 'delete', 'activate', 'deactivate'

  /// Data for the operation (varies by operation type)
  final Map<String, dynamic>? data;

  const AdminBulkCurrencyRequest({
    required this.currencyCodes,
    required this.operation,
    this.data,
  });

  factory AdminBulkCurrencyRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminBulkCurrencyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdminBulkCurrencyRequestToJson(this);
}

/// AdminBulkCurrencyResult
///
/// Result of bulk currency operations.
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminBulkCurrencyResult {
  /// Number of currencies processed successfully
  final int successful;

  /// Number of currencies that failed processing
  final int failed;

  /// List of successful currency codes
  final List<String> successfulCodes;

  /// List of failed currency codes with error messages
  final Map<String, String> failedCodes;

  /// Total number of currencies processed
  final int total;

  const AdminBulkCurrencyResult({
    required this.successful,
    required this.failed,
    required this.successfulCodes,
    required this.failedCodes,
    required this.total,
  });

  factory AdminBulkCurrencyResult.fromJson(Map<String, dynamic> json) =>
      _$AdminBulkCurrencyResultFromJson(json);

  Map<String, dynamic> toJson() => _$AdminBulkCurrencyResultToJson(this);

  /// Check if all operations were successful
  bool get allSuccessful => failed == 0;

  /// Get success rate as percentage
  double get successRate => total > 0 ? (successful / total * 100) : 0.0;
}
