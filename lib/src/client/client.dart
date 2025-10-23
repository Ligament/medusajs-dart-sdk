import 'dart:convert';
import 'package:http/http.dart' as http;

import '../types/types.dart';
import '../exceptions/exceptions.dart';
import '../cache/cache.dart';

const String publishableKeyHeader = 'x-publishable-api-key';
const String defaultJwtStorageKey = 'medusa_auth_token';

/// HTTP client for making requests to Medusa API
class MedusaClient {
  final MedusaConfig config;
  final Logger? _logger;
  final MedusaCache? _cache;
  late final http.Client _httpClient;
  String? _token;

  MedusaClient(this.config, {MedusaCache? cache})
    : _logger = config.logger,
      _cache = cache {
    _httpClient = http.Client();
  }

  /// Make an HTTP request to the Medusa API with retry logic
  Future<T> fetch<T>(
    String input, {
    String method = 'GET',
    QueryParams? query,
    ClientHeaders? headers,
    dynamic body,
    Map<String, String> Function(Map<String, dynamic>)? responseParser,
    int? maxRetries,
    Duration? retryDelay,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    final actualMaxRetries = maxRetries ?? config.maxRetries;
    final actualRetryDelay = retryDelay ?? config.retryDelay;

    // Check cache for GET requests
    if (method.toUpperCase() == 'GET' && useCache && _cache != null) {
      final cacheKey = _buildCacheKey(input, query);
      final cachedData = await _cache.getJson(cacheKey);
      if (cachedData != null) {
        _logger?.debug('Cache hit for $cacheKey');
        return cachedData as T;
      }
    }

    Exception? lastException;

    for (int attempt = 0; attempt <= actualMaxRetries; attempt++) {
      try {
        final uri = _buildUri(input, query);
        final requestHeaders = await _buildHeaders(headers);

        _logger?.debug(
          '$method $uri (attempt ${attempt + 1}/${actualMaxRetries + 1})',
        );

        late http.Response response;

        // Apply timeout if configured
        Future<http.Response> requestWithTimeout() async {
          switch (method.toUpperCase()) {
            case 'GET':
              return await _httpClient.get(uri, headers: requestHeaders);
            case 'POST':
              return await _httpClient.post(
                uri,
                headers: requestHeaders,
                body: _encodeBody(body, requestHeaders),
              );
            case 'PUT':
              return await _httpClient.put(
                uri,
                headers: requestHeaders,
                body: _encodeBody(body, requestHeaders),
              );
            case 'PATCH':
              return await _httpClient.patch(
                uri,
                headers: requestHeaders,
                body: _encodeBody(body, requestHeaders),
              );
            case 'DELETE':
              return await _httpClient.delete(uri, headers: requestHeaders);
            default:
              throw MedusaException('Unsupported HTTP method: $method');
          }
        }

        if (config.timeout != null) {
          response = await requestWithTimeout().timeout(config.timeout!);
        } else {
          response = await requestWithTimeout();
        }

        final result = _handleResponse<T>(response);

        // Cache successful GET responses
        if (method.toUpperCase() == 'GET' &&
            useCache &&
            _cache != null &&
            response.statusCode < 400) {
          final cacheKey = _buildCacheKey(input, query);
          await _cacheResponse(cacheKey, result, cacheTtl);
        }

        return result;
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());

        // Don't retry for certain types of errors
        if (e is AuthenticationError ||
            e is FetchError && e.statusCode != null && e.statusCode! < 500) {
          rethrow;
        }

        // Don't retry on last attempt
        if (attempt < actualMaxRetries) {
          _logger?.warn(
            'Request failed (attempt ${attempt + 1}), retrying in ${actualRetryDelay.inMilliseconds}ms: $e',
          );
          await Future.delayed(actualRetryDelay);
        } else {
          _logger?.error(
            'Request failed after ${actualMaxRetries + 1} attempts: $e',
          );
        }
      }
    }

    // If we get here, all retries failed
    throw lastException ?? MedusaException('Request failed after retries');
  }

  /// Make a streaming request (for Server-Sent Events)
  Future<StreamResponse> fetchStream(
    String input, {
    QueryParams? query,
    ClientHeaders? headers,
  }) async {
    try {
      final uri = _buildUri(input, query);
      final requestHeaders = await _buildHeaders(headers);
      requestHeaders['Accept'] = 'text/event-stream';
      requestHeaders['Cache-Control'] = 'no-cache';

      final request = http.Request('GET', uri);
      request.headers.addAll(requestHeaders);

      final streamedResponse = await _httpClient.send(request);

      if (streamedResponse.statusCode >= 400) {
        throw FetchError(
          'HTTP ${streamedResponse.statusCode}',
          statusCode: streamedResponse.statusCode,
          statusText: streamedResponse.reasonPhrase,
        );
      }

      late Stream<ServerSentEventMessage> eventStream;
      bool aborted = false;

      eventStream =
          streamedResponse.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .where((line) => !aborted)
              .map(_parseServerSentEvent)
              .where((event) => event != null)
              .cast<ServerSentEventMessage>();

      return StreamResponse(stream: eventStream, abort: () => aborted = true);
    } catch (e) {
      if (e is MedusaException) rethrow;
      throw MedusaException('Stream request failed: $e');
    }
  }

  /// Set authentication token
  Future<void> setToken(String token) async {
    _token = token;
    await _storeToken(token);
  }

  /// Clear authentication token
  Future<void> clearToken() async {
    _token = null;
    await _removeToken();
  }

  /// Get the current authentication token
  Future<String?> getToken() async {
    if (_token != null) return _token;
    return await _retrieveToken();
  }

  // Convenience HTTP methods

  /// Make a GET request
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    ClientHeaders? headers,
    bool useCache = true,
    Duration? cacheTtl,
  }) async {
    return await fetch<Map<String, dynamic>>(
      path,
      method: 'GET',
      query: queryParameters,
      headers: headers,
      useCache: useCache,
      cacheTtl: cacheTtl,
    );
  }

  /// Make a POST request
  Future<Map<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    ClientHeaders? headers,
  }) async {
    return await fetch<Map<String, dynamic>>(
      path,
      method: 'POST',
      query: queryParameters,
      body: data,
      headers: headers,
      useCache: false,
    );
  }

  /// Make a PUT request
  Future<Map<String, dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    ClientHeaders? headers,
  }) async {
    return await fetch<Map<String, dynamic>>(
      path,
      method: 'PUT',
      query: queryParameters,
      body: data,
      headers: headers,
      useCache: false,
    );
  }

  /// Make a PATCH request
  Future<Map<String, dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    ClientHeaders? headers,
  }) async {
    return await fetch<Map<String, dynamic>>(
      path,
      method: 'PATCH',
      query: queryParameters,
      body: data,
      headers: headers,
      useCache: false,
    );
  }

  /// Make a DELETE request
  Future<Map<String, dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    ClientHeaders? headers,
  }) async {
    return await fetch<Map<String, dynamic>>(
      path,
      method: 'DELETE',
      query: queryParameters,
      body: data,
      headers: headers,
      useCache: false,
    );
  }

  /// Dispose resources
  void dispose() {
    _httpClient.close();
  }

  // Private methods

  Uri _buildUri(String path, QueryParams? query) {
    final baseUri = Uri.parse(config.baseUrl);
    final fullPath = path.startsWith('/') ? path : '/$path';

    return baseUri.replace(
      path: baseUri.path + fullPath,
      queryParameters: query?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  Future<Map<String, String>> _buildHeaders(ClientHeaders? headers) async {
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Add global headers
    if (config.globalHeaders != null) {
      requestHeaders.addAll(config.globalHeaders!);
    }

    // Add publishable key header
    if (config.publishableKey != null) {
      requestHeaders[publishableKeyHeader] = config.publishableKey!;
    }

    // Add API key header
    if (config.apiKey != null) {
      requestHeaders['Authorization'] = 'Bearer ${config.apiKey}';
    }

    // Add JWT token header
    final token = await getToken();
    if (token != null) {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    // Add custom headers
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    return requestHeaders;
  }

  String? _encodeBody(dynamic body, Map<String, String> headers) {
    if (body == null) return null;

    if (body is String) return body;

    if (headers['Content-Type']?.contains('application/json') == true) {
      return jsonEncode(body);
    }

    return body.toString();
  }

  T _handleResponse<T>(http.Response response) {
    _logger?.debug('Response: ${response.statusCode} ${response.reasonPhrase}');

    if (response.statusCode >= 400) {
      final fallbackErrorMessage =
          'HTTP ${response.statusCode}: ${response.reasonPhrase}';

      Map<String, dynamic>? errorData;
      List<ValidationErrorDetail>? validationErrors;
      String? bodyMessage;

      final contentType = response.headers['content-type'] ?? '';
      if (contentType.contains('application/json') &&
          response.body.isNotEmpty) {
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is Map<String, dynamic>) {
            errorData = Map<String, dynamic>.from(decoded);
            final messageValue = decoded['message'];
            if (messageValue is String && messageValue.isNotEmpty) {
              bodyMessage = messageValue;
            }

            final details = decoded['details'];
            if (details is List) {
              validationErrors =
                  details.whereType<Map>().map((detail) {
                    final detailMap = detail.map(
                      (key, value) => MapEntry(key.toString(), value),
                    );
                    final field =
                        detailMap['field']?.toString() ??
                        detailMap['path']?.toString() ??
                        '';
                    final message =
                        detailMap['message']?.toString() ??
                        detailMap['type']?.toString() ??
                        fallbackErrorMessage;
                    final code = detailMap['code']?.toString();
                    return ValidationErrorDetail(
                      field: field,
                      message: message,
                      code: code,
                    );
                  }).toList();
            }
          }
        } catch (error) {
          _logger?.warn('Failed to parse error response body: $error');
        }
      }

      final errorMessage =
          bodyMessage?.isNotEmpty == true ? bodyMessage! : fallbackErrorMessage;

      switch (response.statusCode) {
        case 401:
          throw AuthenticationError(errorMessage);
        case 403:
          throw AuthorizationError(errorMessage);
        case 404:
          throw NotFoundError(errorMessage);
        case 400:
          throw ValidationError(
            errorMessage,
            errors: validationErrors,
            data: errorData,
          );
        case >= 500:
          throw ServerError(
            errorMessage,
            statusCode: response.statusCode,
            data: errorData,
          );
        default:
          throw FetchError(
            errorMessage,
            statusCode: response.statusCode,
            statusText: response.reasonPhrase,
            data: errorData,
          );
      }
    }

    if (response.headers['content-type']?.contains('application/json') ==
        true) {
      try {
        final jsonData = jsonDecode(response.body);
        return jsonData as T;
      } catch (e) {
        throw MedusaException('Failed to parse JSON response: $e');
      }
    }

    return response.body as T;
  }

  ServerSentEventMessage? _parseServerSentEvent(String line) {
    if (line.isEmpty) return null;

    if (line.startsWith('data: ')) {
      return ServerSentEventMessage(data: line.substring(6));
    } else if (line.startsWith('event: ')) {
      return ServerSentEventMessage(event: line.substring(7));
    } else if (line.startsWith('id: ')) {
      return ServerSentEventMessage(id: line.substring(4));
    } else if (line.startsWith('retry: ')) {
      final retryStr = line.substring(7);
      final retry = int.tryParse(retryStr);
      return ServerSentEventMessage(retry: retry);
    } else if (line.startsWith(': ')) {
      return ServerSentEventMessage(comment: line.substring(2));
    }

    return null;
  }

  Future<void> _storeToken(String token) async {
    final authConfig = config.auth ?? const AuthConfig();

    switch (authConfig.jwtTokenStorageMethod) {
      case StorageMethod.local:
        _logger?.warn(
          'Local storage not available in pure Dart, using memory storage',
        );
        break;
      case StorageMethod.custom:
        if (authConfig.storage != null) {
          await authConfig.storage!.setItem(
            authConfig.jwtTokenStorageKey,
            token,
          );
        }
        break;
      case StorageMethod.memory:
      case StorageMethod.nostore:
        // Token is stored in memory (_token field) or not stored at all
        break;
      case StorageMethod.session:
        // Session storage is not available in Dart
        _logger?.warn(
          'Session storage not available in Dart, using memory storage',
        );
        break;
    }
  }

  Future<String?> _retrieveToken() async {
    final authConfig = config.auth ?? const AuthConfig();

    switch (authConfig.jwtTokenStorageMethod) {
      case StorageMethod.local:
        return null; // Local storage not available in pure Dart
      case StorageMethod.custom:
        if (authConfig.storage != null) {
          return await authConfig.storage!.getItem(
            authConfig.jwtTokenStorageKey,
          );
        }
        return null;
      case StorageMethod.memory:
      case StorageMethod.session:
      case StorageMethod.nostore:
        return null;
    }
  }

  Future<void> _removeToken() async {
    final authConfig = config.auth ?? const AuthConfig();

    switch (authConfig.jwtTokenStorageMethod) {
      case StorageMethod.local:
        // Local storage not available in pure Dart - nothing to remove
        break;
      case StorageMethod.custom:
        if (authConfig.storage != null) {
          await authConfig.storage!.removeItem(authConfig.jwtTokenStorageKey);
        }
        break;
      case StorageMethod.memory:
      case StorageMethod.session:
      case StorageMethod.nostore:
        // Nothing to remove for these storage methods
        break;
    }
  }

  /// Build cache key from request parameters
  String _buildCacheKey(String input, QueryParams? query) {
    final uri = _buildUri(input, query);
    return 'medusa_cache:${uri.toString()}';
  }

  /// Cache response data
  Future<void> _cacheResponse<T>(
    String cacheKey,
    T data,
    Duration? cacheTtl,
  ) async {
    if (_cache != null && data is Map<String, dynamic>) {
      await _cache.setJson(cacheKey, data, ttl: cacheTtl);
      _logger?.debug('Cached response for $cacheKey');
    }
  }
}
