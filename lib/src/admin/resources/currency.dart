import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin currency management resource
///
/// Uses AdminCurrency model from @medusajs/types v2.10.1
/// for comprehensive currency management with store integration.
class AdminCurrencyResource extends AdminResource {
  const AdminCurrencyResource(super.client);

  String get resourcePath => '$basePath/currencies';

  /// List currencies
  ///
  /// Retrieves a list of currencies with pagination support and filtering capabilities.
  ///
  /// Example:
  /// ```dart
  /// final currencies = await medusa.admin.currency.list(
  ///   query: {'symbol': '\$', 'limit': 20}
  /// );
  /// ```
  Future<PaginatedResponse<AdminCurrency>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminCurrency>(
      endpoint: resourcePath,
      dataKey: 'currencies',
      fromJson: AdminCurrency.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a currency by code
  ///
  /// Gets detailed information about a specific currency.
  ///
  /// Example:
  /// ```dart
  /// final currency = await medusa.admin.currency.retrieve('usd');
  /// ```
  Future<AdminCurrency?> retrieve(
    String code, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminCurrency>(
      id: code,
      endpoint: '$resourcePath/$code',
      dataKey: 'currency',
      fromJson: AdminCurrency.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new currency
  ///
  /// Creates a new currency with the provided details.
  ///
  /// Example:
  /// ```dart
  /// final currency = await medusa.admin.currency.create({
  ///   'code': 'CAD',
  ///   'symbol': 'C\$',
  ///   'name': 'Canadian Dollar',
  ///   'decimal_digits': 2,
  /// });
  /// ```
  Future<AdminCurrency?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminCurrency>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'currency',
      fromJson: AdminCurrency.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a currency
  ///
  /// Updates an existing currency's properties.
  ///
  /// Example:
  /// ```dart
  /// final currency = await medusa.admin.currency.update('cad', {
  ///   'name': 'Canadian Dollar (Updated)',
  ///   'decimal_digits': 2,
  /// });
  /// ```
  Future<AdminCurrency?> update(
    String code,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminCurrency>(
      id: code,
      body: body,
      endpoint: '$resourcePath/$code',
      dataKey: 'currency',
      fromJson: AdminCurrency.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a currency
  ///
  /// Soft deletes a currency, making it unavailable for new transactions.
  ///
  /// Example:
  /// ```dart
  /// await medusa.admin.currency.delete('obsolete_currency');
  /// ```
  Future<Map<String, dynamic>> delete(
    String code, {
    ClientHeaders? headers,
  }) async {
    return await deleteGeneric(
      id: code,
      endpoint: '$resourcePath/$code',
      headers: headers,
    );
  }

  /// Get currency by symbol
  ///
  /// Filters currencies by their symbol.
  ///
  /// Example:
  /// ```dart
  /// final dollarCurrencies = await medusa.admin.currency.bySymbol('\$');
  /// ```
  Future<PaginatedResponse<AdminCurrency>> bySymbol(
    String symbol, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['symbol'] = symbol;

    return list(query: query, headers: headers);
  }

  /// Get all supported currencies
  ///
  /// Retrieves all currencies that the system supports.
  ///
  /// Example:
  /// ```dart
  /// final supportedCurrencies = await medusa.admin.currency.getAllSupported();
  /// ```
  Future<List<AdminCurrency>> getAllSupported({ClientHeaders? headers}) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/supported',
      headers: headers,
    );

    final currencies =
        (response['currencies'] as List? ?? [])
            .map((json) => AdminCurrency.fromJson(json as Map<String, dynamic>))
            .toList();

    return currencies;
  }

  /// Add a currency to store
  ///
  /// Adds an existing currency to the store's supported currencies.
  ///
  /// Example:
  /// ```dart
  /// final storeCurrency = await medusa.admin.currency.addToStore('eur');
  /// ```
  Future<AdminCurrency?> addToStore(
    String code, {
    Map<String, dynamic>? body,
    ClientHeaders? headers,
  }) async {
    final requestBody = body ?? {};
    if (!requestBody.containsKey('code')) {
      requestBody['code'] = code;
    }

    return await createGeneric<AdminCurrency>(
      body: requestBody,
      endpoint: '$resourcePath/$code/add',
      dataKey: 'currency',
      fromJson: AdminCurrency.fromJson,
      headers: headers,
    );
  }

  /// Remove a currency from store
  ///
  /// Removes a currency from the store's supported currencies.
  ///
  /// Example:
  /// ```dart
  /// await medusa.admin.currency.removeFromStore('old_currency');
  /// ```
  Future<Map<String, dynamic>> removeFromStore(
    String code, {
    ClientHeaders? headers,
  }) async {
    return await deleteGeneric(
      id: code,
      endpoint: '$resourcePath/$code/remove',
      headers: headers,
    );
  }

  /// Get store currencies
  ///
  /// Retrieves all currencies configured for a specific store.
  ///
  /// Example:
  /// ```dart
  /// final storeCurrencies = await medusa.admin.currency.getStoreCurrencies('store_123');
  /// ```
  Future<PaginatedResponse<AdminStoreCurrency>> getStoreCurrencies(
    String storeId, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '/admin/stores/$storeId/currencies',
      query: query,
      headers: headers,
    );

    final currencies =
        (response['currencies'] as List? ?? [])
            .map(
              (json) =>
                  AdminStoreCurrency.fromJson(json as Map<String, dynamic>),
            )
            .toList();

    return PaginatedResponse(
      data: currencies,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Set default store currency
  ///
  /// Sets a currency as the default for a store.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.currency.setDefaultStoreCurrency('store_123', 'usd');
  /// ```
  Future<AdminStoreCurrency?> setDefaultStoreCurrency(
    String storeId,
    String currencyCode, {
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminStoreCurrency>(
      body: {'currency_code': currencyCode, 'is_default': true},
      endpoint: '/admin/stores/$storeId/currencies/default',
      dataKey: 'store_currency',
      fromJson: AdminStoreCurrency.fromJson,
      headers: headers,
    );
  }

  /// Get currency analytics
  ///
  /// Retrieves comprehensive analytics for currency usage and performance.
  ///
  /// Example:
  /// ```dart
  /// final analytics = await medusa.admin.currency.getAnalytics(
  ///   period: '30d',
  ///   currencyCodes: ['usd', 'eur'],
  /// );
  /// ```
  Future<AdminCurrencyAnalytics?> getAnalytics({
    String? period,
    List<String>? currencyCodes,
    ClientHeaders? headers,
  }) async {
    final query = <String, dynamic>{};
    if (period != null) query['period'] = period;
    if (currencyCodes != null)
      query['currency_codes'] = currencyCodes.join(',');

    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/analytics',
      query: query,
      headers: headers,
    );

    final analyticsData = response['analytics'];
    return analyticsData != null
        ? AdminCurrencyAnalytics.fromJson(analyticsData as Map<String, dynamic>)
        : null;
  }

  /// Bulk currency operations
  ///
  /// Performs bulk operations on multiple currencies.
  ///
  /// Example:
  /// ```dart
  /// final result = await medusa.admin.currency.bulkOperation({
  ///   'currency_codes': ['eur', 'gbp', 'jpy'],
  ///   'operation': 'activate',
  /// });
  /// ```
  Future<AdminBulkCurrencyResult?> bulkOperation(
    Map<String, dynamic> body, {
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$resourcePath/bulk',
      method: 'POST',
      body: body,
      headers: headers,
    );

    final resultData = response['result'];
    return resultData != null
        ? AdminBulkCurrencyResult.fromJson(resultData as Map<String, dynamic>)
        : null;
  }

  /// Search currencies
  ///
  /// Searches currencies by various criteria.
  ///
  /// Example:
  /// ```dart
  /// final currencies = await medusa.admin.currency.search('dollar');
  /// ```
  Future<PaginatedResponse<AdminCurrency>> search(
    String searchTerm, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['q'] = searchTerm;

    return list(query: query, headers: headers);
  }

  /// Get currencies by decimal digits
  ///
  /// Filters currencies by their decimal digit configuration.
  ///
  /// Example:
  /// ```dart
  /// final zeroDecimalCurrencies = await medusa.admin.currency.byDecimalDigits(0);
  /// ```
  Future<PaginatedResponse<AdminCurrency>> byDecimalDigits(
    int decimalDigits, {
    Map<String, dynamic>? additionalFilters,
    ClientHeaders? headers,
  }) async {
    final query = Map<String, dynamic>.from(additionalFilters ?? {});
    query['decimal_digits'] = decimalDigits;

    return list(query: query, headers: headers);
  }
}
