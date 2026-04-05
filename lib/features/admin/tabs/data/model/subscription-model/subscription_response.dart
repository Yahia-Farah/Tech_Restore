import 'package:json_annotation/json_annotation.dart';
import 'subscription_model.dart';

part 'subscription_response.g.dart';

@JsonSerializable()
class SubscriptionResponse {
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "content")
  final List<SubscriptionModel>? content;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "numberOfElements")
  final int? numberOfElements;
  @JsonKey(name: "first")
  final bool? first;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "empty")
  final bool? empty;

  SubscriptionResponse({
    this.totalPages,
    this.totalElements,
    this.size,
    this.content,
    this.number,
    this.numberOfElements,
    this.first,
    this.last,
    this.empty,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionResponseToJson(this);
}
