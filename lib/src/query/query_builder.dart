/// Modern query builder for Medusa API requests
///
/// Provides a fluent interface for building complex queries with
/// filtering, sorting, pagination, and field selection.
class QueryBuilder {
  final Map<String, dynamic> _params = {};

  /// Add a filter to the query
  QueryBuilder where(String field, dynamic value) {
    _params[field] = value;
    return this;
  }

  /// Add multiple filters at once
  QueryBuilder whereAll(Map<String, dynamic> filters) {
    _params.addAll(filters);
    return this;
  }

  /// Add a search query
  QueryBuilder search(String query) {
    _params['q'] = query;
    return this;
  }

  /// Set the fields to select
  QueryBuilder select(List<String> fields) {
    _params['fields'] = fields.join(',');
    return this;
  }

  /// Add relations to expand
  QueryBuilder expand(List<String> relations) {
    _params['expand'] = relations.join(',');
    return this;
  }

  /// Set sorting options
  QueryBuilder orderBy(String field, {bool ascending = true}) {
    final prefix = ascending ? '' : '-';
    _params['order'] = '$prefix$field';
    return this;
  }

  /// Set pagination options
  QueryBuilder paginate({int? limit, int? offset}) {
    if (limit != null) _params['limit'] = limit;
    if (offset != null) _params['offset'] = offset;
    return this;
  }

  /// Set page-based pagination
  QueryBuilder page(int page, {int pageSize = 20}) {
    _params['limit'] = pageSize;
    _params['offset'] = (page - 1) * pageSize;
    return this;
  }

  /// Add date range filter
  QueryBuilder dateRange(String field, {DateTime? from, DateTime? to}) {
    if (from != null) {
      _params['$field[gte]'] = from.toIso8601String();
    }
    if (to != null) {
      _params['$field[lte]'] = to.toIso8601String();
    }
    return this;
  }

  /// Add numeric range filter
  QueryBuilder numberRange(String field, {num? min, num? max}) {
    if (min != null) {
      _params['$field[gte]'] = min;
    }
    if (max != null) {
      _params['$field[lte]'] = max;
    }
    return this;
  }

  /// Add array filter (IN operator)
  QueryBuilder whereIn(String field, List<dynamic> values) {
    _params[field] = values;
    return this;
  }

  /// Add boolean filter
  QueryBuilder whereBool(String field, bool value) {
    _params[field] = value;
    return this;
  }

  /// Add custom parameter
  QueryBuilder param(String key, dynamic value) {
    _params[key] = value;
    return this;
  }

  /// Include deleted records in the query (added in v2.10)
  QueryBuilder withDeleted() {
    _params['with_deleted'] = true;
    return this;
  }

  /// Clear all parameters
  QueryBuilder clear() {
    _params.clear();
    return this;
  }

  /// Get the built query parameters
  Map<String, dynamic> build() {
    return Map.from(_params);
  }

  /// Convert to URL query string
  String toQueryString() {
    if (_params.isEmpty) return '';

    final parts = <String>[];
    for (final entry in _params.entries) {
      final key = Uri.encodeComponent(entry.key);
      if (entry.value is List) {
        for (final value in entry.value as List) {
          parts.add('$key=${Uri.encodeComponent(value.toString())}');
        }
      } else {
        final value = Uri.encodeComponent(entry.value.toString());
        parts.add('$key=$value');
      }
    }

    return parts.join('&');
  }

  @override
  String toString() => toQueryString();
}

/// Specialized query builder for product searches
class ProductQueryBuilder extends QueryBuilder {
  /// Filter by product status
  ProductQueryBuilder status(String status) {
    return where('status', status) as ProductQueryBuilder;
  }

  /// Filter by category ID
  ProductQueryBuilder category(String categoryId) {
    return where('category_id', categoryId) as ProductQueryBuilder;
  }

  /// Filter by collection ID
  ProductQueryBuilder collection(String collectionId) {
    return where('collection_id', collectionId) as ProductQueryBuilder;
  }

  /// Filter by tags
  ProductQueryBuilder tags(List<String> tags) {
    return whereIn('tags', tags) as ProductQueryBuilder;
  }

  /// Filter by price range
  ProductQueryBuilder priceRange({num? min, num? max}) {
    return numberRange('price', min: min, max: max) as ProductQueryBuilder;
  }

  /// Filter by availability
  ProductQueryBuilder available({bool inStock = true}) {
    return whereBool('is_giftcard', false) as ProductQueryBuilder;
  }
}

/// Specialized query builder for order searches
class OrderQueryBuilder extends QueryBuilder {
  /// Filter by order status
  OrderQueryBuilder status(String status) {
    return where('status', status) as OrderQueryBuilder;
  }

  /// Filter by fulfillment status
  OrderQueryBuilder fulfillmentStatus(String status) {
    return where('fulfillment_status', status) as OrderQueryBuilder;
  }

  /// Filter by payment status
  OrderQueryBuilder paymentStatus(String status) {
    return where('payment_status', status) as OrderQueryBuilder;
  }

  /// Filter by customer ID
  OrderQueryBuilder customer(String customerId) {
    return where('customer_id', customerId) as OrderQueryBuilder;
  }

  /// Filter by email
  OrderQueryBuilder email(String email) {
    return where('email', email) as OrderQueryBuilder;
  }

  /// Filter by total amount range
  OrderQueryBuilder totalRange({num? min, num? max}) {
    return numberRange('total', min: min, max: max) as OrderQueryBuilder;
  }

  /// Filter by created date range
  OrderQueryBuilder createdBetween({DateTime? from, DateTime? to}) {
    return dateRange('created_at', from: from, to: to) as OrderQueryBuilder;
  }
}

/// Specialized query builder for customer searches
class CustomerQueryBuilder extends QueryBuilder {
  /// Filter by email
  CustomerQueryBuilder email(String email) {
    return where('email', email) as CustomerQueryBuilder;
  }

  /// Filter by phone
  CustomerQueryBuilder phone(String phone) {
    return where('phone', phone) as CustomerQueryBuilder;
  }

  /// Filter by has account
  CustomerQueryBuilder hasAccount({bool hasAccount = true}) {
    return whereBool('has_account', hasAccount) as CustomerQueryBuilder;
  }

  /// Filter by registration date range
  CustomerQueryBuilder registeredBetween({DateTime? from, DateTime? to}) {
    return dateRange('created_at', from: from, to: to) as CustomerQueryBuilder;
  }
}
