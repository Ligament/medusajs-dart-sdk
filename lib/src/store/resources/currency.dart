import '../../models/currency.dart';
import '../../resources/base_resource.dart';
import '../../types/types.dart';
import '../../models/common.dart';

/// Store currency resource exposing Medusa's currency endpoints.
class StoreCurrencyResource extends StoreResource {
  const StoreCurrencyResource(super.client);

  String get resourcePath => '$basePath/currencies';

  /// List currencies configured for the store.
  Future<PaginatedResponse<Currency>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return listGeneric<Currency>(
      endpoint: resourcePath,
      dataKey: 'currencies',
      fromJson: Currency.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a currency by its ISO code (e.g. `usd`).
  Future<Currency?> retrieve(
    String code, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return retrieveGeneric<Currency>(
      id: code,
      endpoint: '$resourcePath/$code',
      dataKey: 'currency',
      fromJson: Currency.fromJson,
      query: query,
      headers: headers,
    );
  }
}
