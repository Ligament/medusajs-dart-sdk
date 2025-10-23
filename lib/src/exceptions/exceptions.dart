/// Base exception for Medusa SDK errors
class MedusaException implements Exception {
  final String message;
  final int? statusCode;
  final String? statusText;
  final Map<String, dynamic>? data;

  const MedusaException(
    this.message, {
    this.statusCode,
    this.statusText,
    this.data,
  });

  @override
  String toString() {
    return 'MedusaException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}

/// Exception thrown when HTTP request fails
class FetchError extends MedusaException {
  FetchError(super.message, {super.statusCode, super.statusText, super.data});
}

/// Exception thrown when authentication fails
class AuthenticationError extends MedusaException {
  AuthenticationError(super.message);
}

/// Exception thrown when authorization fails
class AuthorizationError extends MedusaException {
  AuthorizationError(super.message) : super(statusCode: 403);
}

/// Exception thrown when resource is not found
class NotFoundError extends MedusaException {
  NotFoundError(super.message) : super(statusCode: 404);
}

/// Exception thrown when validation fails
class ValidationError extends MedusaException {
  final List<ValidationErrorDetail>? errors;

  ValidationError(super.message, {this.errors, super.data})
    : super(statusCode: 400);
}

/// Exception thrown when rate limit is exceeded
class RateLimitError extends MedusaException {
  final int? retryAfter;

  RateLimitError(super.message, {this.retryAfter}) : super(statusCode: 429);
}

/// Exception thrown when server error occurs
class ServerError extends MedusaException {
  ServerError(super.message, {int? statusCode, super.data})
    : super(statusCode: statusCode ?? 500);
}

/// Exception thrown when network error occurs
class NetworkError extends MedusaException {
  NetworkError(super.message);
}

/// Exception thrown when timeout occurs
class TimeoutError extends MedusaException {
  TimeoutError(super.message);
}

/// Exception thrown when client configuration is invalid
class ConfigurationError extends MedusaException {
  ConfigurationError(super.message);
}

/// Details for validation errors
class ValidationErrorDetail {
  final String field;
  final String message;
  final String? code;

  const ValidationErrorDetail({
    required this.field,
    required this.message,
    this.code,
  });

  factory ValidationErrorDetail.fromJson(Map<String, dynamic> json) {
    return ValidationErrorDetail(
      field: json['field'] ?? '',
      message: json['message'] ?? '',
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'field': field, 'message': message, if (code != null) 'code': code};
  }
}
