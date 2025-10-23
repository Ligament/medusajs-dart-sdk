/// Canonical Admin Notification models based on @medusajs/types v2.10.1
///
/// Provides read-only notification management functionality with complete
/// API compatibility and type safety.

import 'package:json_annotation/json_annotation.dart';

part 'admin_notification.g.dart';

// =============================================================================
// NOTIFICATION MODELS (Canonical v2.10.1)
// =============================================================================

/// Admin notification as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminNotification {
  /// The notification's ID
  final String id;

  /// The identifier the notification is sent to.
  /// For example, an email, phone number, or username.
  final String to;

  /// The channel to send the notification through.
  ///
  /// Example: email
  final String channel;

  /// A template ID to use for the notification's content.
  ///
  /// For example, the ID of a template in SendGrid.
  final String template;

  /// Data to pass to the template
  final Map<String, dynamic>? data;

  /// What triggered this notification.
  ///
  /// Example: order.created
  final String? triggerType;

  /// The ID of the associated resource. For example, if the notification was triggered
  /// because an order was created, this would be the ID of the order.
  final String? resourceId;

  /// The type of the resource that triggered the notification.
  ///
  /// Example: order
  final String? resourceType;

  /// The ID of the user or customer that received the notification
  final String? receiverId;

  /// The ID of the original notification if this is a resend of it
  final String? originalNotificationId;

  /// The ID of the notification in an external or third-party system
  final String? externalId;

  /// The ID of the notification provider used
  final String providerId;

  /// The date the notification was created
  final DateTime createdAt;

  const AdminNotification({
    required this.id,
    required this.to,
    required this.channel,
    required this.template,
    this.data,
    this.triggerType,
    this.resourceId,
    this.resourceType,
    this.receiverId,
    this.originalNotificationId,
    this.externalId,
    required this.providerId,
    required this.createdAt,
  });

  factory AdminNotification.fromJson(Map<String, dynamic> json) =>
      _$AdminNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$AdminNotificationToJson(this);
}

// =============================================================================
// NOTIFICATION QUERIES
// =============================================================================

/// Admin notification query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminNotificationListParams {
  /// Query or keywords to search the notification's searchable fields
  final String? q;

  /// Filter by notification ID(s)
  final List<String>? id;

  /// Filter by channel(s)
  final List<String>? channel;

  /// Number of notifications to skip for pagination
  final int? offset;

  /// Maximum number of notifications to return
  final int? limit;

  /// Sort order for the results
  final String? order;

  /// Fields to include in the response
  final List<String>? fields;

  /// Relations to expand in the response
  final List<String>? expand;

  const AdminNotificationListParams({
    this.q,
    this.id,
    this.channel,
    this.offset,
    this.limit,
    this.order,
    this.fields,
    this.expand,
  });

  factory AdminNotificationListParams.fromJson(Map<String, dynamic> json) =>
      _$AdminNotificationListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminNotificationListParamsToJson(this);
}

/// Admin notification single query parameters as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminNotificationParams {
  /// Fields to include in the response
  final List<String>? fields;

  /// Relations to expand in the response
  final List<String>? expand;

  const AdminNotificationParams({this.fields, this.expand});

  factory AdminNotificationParams.fromJson(Map<String, dynamic> json) =>
      _$AdminNotificationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminNotificationParamsToJson(this);
}

// =============================================================================
// NOTIFICATION RESPONSES
// =============================================================================

/// Admin notification response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminNotificationResponse {
  /// The notification's details
  final AdminNotification notification;

  const AdminNotificationResponse({required this.notification});

  factory AdminNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminNotificationResponseToJson(this);
}

/// Admin notification list response as defined in @medusajs/types v2.10.1
@JsonSerializable(fieldRename: FieldRename.snake)
class AdminNotificationListResponse {
  /// The list of notifications
  final List<AdminNotification> notifications;

  /// Total count of notifications
  final int? count;

  /// Number of notifications skipped
  final int? offset;

  /// Number of notifications returned
  final int? limit;

  const AdminNotificationListResponse({
    required this.notifications,
    this.count,
    this.offset,
    this.limit,
  });

  factory AdminNotificationListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminNotificationListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminNotificationListResponseToJson(this);
}
