import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/manage-subscription/data/models/subscription_model.dart';

part 'subscription_response.g.dart';

@JsonSerializable()
class SubscriptionListResponse {
  final List<SubscriptionModel>? content;

  SubscriptionListResponse({this.content});

  factory SubscriptionListResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionListResponseToJson(this);
}