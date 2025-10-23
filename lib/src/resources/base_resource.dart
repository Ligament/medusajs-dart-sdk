import '../client/client.dart';
import '../types/types.dart';
import '../models/common.dart';

/// Base class for all API resources
abstract class BaseResource {
  final MedusaClient client;

  const BaseResource(this.client);

  /// Get the base path for this resource
  String get basePath;

  /// Build complete URL path
  String buildPath([String? endpoint]) {
    if (endpoint == null || endpoint.isEmpty) {
      return basePath;
    }
    return '$basePath/$endpoint';
  }

  /// Generic list method for resources
  Future<PaginatedResponse<T>> listGeneric<T>({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    required String endpoint,
    required String dataKey,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      endpoint,
      query: query,
      headers: headers,
    );

    final items =
        (response[dataKey] as List? ?? [])
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList();

    return PaginatedResponse(
      data: items,
      count: response['count'] ?? 0,
      offset: response['offset'] ?? 0,
      limit: response['limit'] ?? 20,
    );
  }

  /// Generic retrieve method for resources
  Future<T?> retrieveGeneric<T>({
    required String id,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    required String endpoint,
    required String dataKey,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      endpoint,
      query: query,
      headers: headers,
    );
    final data = response[dataKey];
    return data != null ? fromJson(data as Map<String, dynamic>) : null;
  }

  /// Generic create method for resources
  Future<T?> createGeneric<T>({
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    required String endpoint,
    required String dataKey,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      endpoint,
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final data = response[dataKey];
    return data != null ? fromJson(data as Map<String, dynamic>) : null;
  }

  /// Generic update method for resources
  Future<T?> updateGeneric<T>({
    required String id,
    required Map<String, dynamic> body,
    Map<String, dynamic>? query,
    ClientHeaders? headers,
    required String endpoint,
    required String dataKey,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      endpoint,
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final data = response[dataKey];
    return data != null ? fromJson(data as Map<String, dynamic>) : null;
  }

  /// Generic delete method for resources
  Future<Map<String, dynamic>> deleteGeneric({
    required String id,
    ClientHeaders? headers,
    required String endpoint,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      endpoint,
      method: 'DELETE',
      headers: headers,
    );
  }
}

/// Base class for store resources
abstract class StoreResource extends BaseResource {
  const StoreResource(super.client);

  @override
  String get basePath => '/store';
}

/// Base class for admin resources
abstract class AdminResource extends BaseResource {
  const AdminResource(super.client);

  @override
  String get basePath => '/admin';
}
