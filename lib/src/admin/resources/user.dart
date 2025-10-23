import '../../resources/base_resource.dart';
import '../../models/models.dart';
import '../../types/types.dart';

/// Admin user management resource
///
/// Uses AdminUser model from @medusajs/types v2.10.1
/// for enhanced admin-specific user management capabilities.
class AdminUserResource extends AdminResource {
  const AdminUserResource(super.client);

  String get resourcePath => '$basePath/users';

  /// List users
  Future<PaginatedResponse<AdminUser>> list({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await listGeneric<AdminUser>(
      endpoint: resourcePath,
      dataKey: 'users',
      fromJson: AdminUser.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Retrieve a user by ID
  Future<AdminUser?> retrieve(
    String id, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await retrieveGeneric<AdminUser>(
      id: id,
      endpoint: '$resourcePath/$id',
      dataKey: 'user',
      fromJson: AdminUser.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Create a new user
  Future<AdminUser?> create(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await createGeneric<AdminUser>(
      body: body,
      endpoint: resourcePath,
      dataKey: 'user',
      fromJson: AdminUser.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Update a user
  Future<AdminUser?> update(
    String id,
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    return await updateGeneric<AdminUser>(
      id: id,
      body: body,
      endpoint: '$resourcePath/$id',
      dataKey: 'user',
      fromJson: AdminUser.fromJson,
      query: query,
      headers: headers,
    );
  }

  /// Delete a user
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

  /// Get current user
  Future<AdminUser?> me({
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/auth/me',
      query: query,
      headers: headers,
    );

    final userData = response['user'];
    return userData != null
        ? AdminUser.fromJson(userData as Map<String, dynamic>)
        : null;
  }

  /// Update current user
  Future<AdminUser?> updateMe(
    Map<String, dynamic> body, {
    Map<String, dynamic>? query,
    ClientHeaders? headers,
  }) async {
    final response = await client.fetch<Map<String, dynamic>>(
      '$basePath/auth/me',
      method: 'POST',
      body: body,
      query: query,
      headers: headers,
    );

    final userData = response['user'];
    return userData != null
        ? AdminUser.fromJson(userData as Map<String, dynamic>)
        : null;
  }

  /// Reset password
  Future<Map<String, dynamic>> resetPassword(
    Map<String, dynamic> body, {
    ClientHeaders? headers,
  }) async {
    return await client.fetch<Map<String, dynamic>>(
      '$basePath/auth/reset-password',
      method: 'POST',
      body: body,
      headers: headers,
    );
  }

  /// Request password reset
  Future<Map<String, dynamic>> requestPasswordReset(
    String email, {
    ClientHeaders? headers,
  }) async {
    final body = {'email': email};

    return await client.fetch<Map<String, dynamic>>(
      '$basePath/auth/password-token',
      method: 'POST',
      body: body,
      headers: headers,
    );
  }
}
