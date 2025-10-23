import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

/// Campaign status
enum CampaignStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('draft')
  draft,
}

/// Campaign budget type
enum CampaignBudgetType {
  @JsonValue('spend')
  spend,
  @JsonValue('usage')
  usage,
}

/// Represents a campaign in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class Campaign {
  /// Unique identifier for the campaign
  final String id;

  /// Campaign name
  final String name;

  /// Campaign description
  final String? description;

  /// Currency code for the campaign
  final String? currencyCode;

  /// Campaign status
  final CampaignStatus status;

  /// Campaign budget
  final CampaignBudget? budget;

  /// Campaign starts at
  final DateTime? startsAt;

  /// Campaign ends at
  final DateTime? endsAt;

  /// Campaign metadata
  final Map<String, dynamic>? metadata;

  /// When the campaign was created
  final DateTime createdAt;

  /// When the campaign was last updated
  final DateTime updatedAt;

  /// When the campaign was deleted (if soft deleted)
  final DateTime? deletedAt;

  const Campaign({
    required this.id,
    required this.name,
    this.description,
    this.currencyCode,
    required this.status,
    this.budget,
    this.startsAt,
    this.endsAt,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);
  Map<String, dynamic> toJson() => _$CampaignToJson(this);

  /// Check if campaign is active
  bool get isActive => status == CampaignStatus.active;

  /// Check if campaign is currently running
  bool get isCurrentlyRunning {
    final now = DateTime.now();
    return isActive &&
        (startsAt == null || now.isAfter(startsAt!)) &&
        (endsAt == null || now.isBefore(endsAt!));
  }
}

/// Campaign budget
@JsonSerializable(fieldRename: FieldRename.snake)
class CampaignBudget {
  /// Budget type
  final CampaignBudgetType type;

  /// Budget limit
  final int? limit;

  /// Budget used amount
  final int? used;

  const CampaignBudget({required this.type, this.limit, this.used});

  factory CampaignBudget.fromJson(Map<String, dynamic> json) =>
      _$CampaignBudgetFromJson(json);
  Map<String, dynamic> toJson() => _$CampaignBudgetToJson(this);

  /// Get remaining budget
  int? get remaining {
    if (limit == null || used == null) return null;
    return limit! - used!;
  }

  /// Check if budget is exceeded
  bool get isExceeded {
    if (limit == null || used == null) return false;
    return used! > limit!;
  }
}

/// Request to create a campaign
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateCampaignRequest {
  /// Campaign name
  final String name;

  /// Campaign description
  final String? description;

  /// Currency code for the campaign
  final String? currencyCode;

  /// Campaign status
  final CampaignStatus? status;

  /// Campaign budget
  final CampaignBudget? budget;

  /// Campaign starts at
  final DateTime? startsAt;

  /// Campaign ends at
  final DateTime? endsAt;

  /// Campaign metadata
  final Map<String, dynamic>? metadata;

  const CreateCampaignRequest({
    required this.name,
    this.description,
    this.currencyCode,
    this.status,
    this.budget,
    this.startsAt,
    this.endsAt,
    this.metadata,
  });

  factory CreateCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCampaignRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCampaignRequestToJson(this);
}

/// Request to update a campaign
@JsonSerializable(fieldRename: FieldRename.snake)
class UpdateCampaignRequest {
  /// Campaign name
  final String? name;

  /// Campaign description
  final String? description;

  /// Currency code for the campaign
  final String? currencyCode;

  /// Campaign status
  final CampaignStatus? status;

  /// Campaign budget
  final CampaignBudget? budget;

  /// Campaign starts at
  final DateTime? startsAt;

  /// Campaign ends at
  final DateTime? endsAt;

  /// Campaign metadata
  final Map<String, dynamic>? metadata;

  const UpdateCampaignRequest({
    this.name,
    this.description,
    this.currencyCode,
    this.status,
    this.budget,
    this.startsAt,
    this.endsAt,
    this.metadata,
  });

  factory UpdateCampaignRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCampaignRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateCampaignRequestToJson(this);
}
