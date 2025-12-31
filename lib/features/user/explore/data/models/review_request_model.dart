import 'package:json_annotation/json_annotation.dart';

part 'review_request_model.g.dart';

@JsonSerializable()
class ReviewRequestModel {
  final int rating;
  final String comment;

  const ReviewRequestModel({required this.rating, required this.comment});

  factory ReviewRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewRequestModelToJson(this);
}
