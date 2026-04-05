import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/manage-reviews/data/models/review_model.dart';

part 'review_response.g.dart';

@JsonSerializable()
class ReviewListResponse {
  final List<ReviewModel>? content;

  ReviewListResponse({this.content});

  factory ReviewListResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewListResponseToJson(this);
}