import 'package:json_annotation/json_annotation.dart';
import 'fulfillment.dart';

part 'fulfillment_label.g.dart';

/// FulfillmentLabelDTO - The fulfillment label details (Medusa v2.10+)
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FulfillmentLabelDTO {
  /// The ID of the fulfillment label
  final String id;

  /// The tracking number of the fulfillment label
  final String trackingNumber;

  /// The tracking URL of the fulfillment label
  final String trackingUrl;

  /// The label's URL
  final String labelUrl;

  /// The associated fulfillment's ID
  final String fulfillmentId;

  /// The associated fulfillment
  final Fulfillment? fulfillment;

  /// The creation date of the fulfillment label
  final DateTime createdAt;

  /// The update date of the fulfillment label
  final DateTime updatedAt;

  /// The deletion date of the fulfillment label (nullable)
  final DateTime? deletedAt;

  const FulfillmentLabelDTO({
    required this.id,
    required this.trackingNumber,
    required this.trackingUrl,
    required this.labelUrl,
    required this.fulfillmentId,
    this.fulfillment,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory FulfillmentLabelDTO.fromJson(Map<String, dynamic> json) =>
      _$FulfillmentLabelDTOFromJson(json);
  Map<String, dynamic> toJson() => _$FulfillmentLabelDTOToJson(this);
}
