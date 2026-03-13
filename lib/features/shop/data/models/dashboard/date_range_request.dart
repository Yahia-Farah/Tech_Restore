import 'package:json_annotation/json_annotation.dart';

part 'date_range_request.g.dart';

@JsonSerializable()
class DateRangeRequest {
  final String? startDate;
  final String? endDate;

  DateRangeRequest({this.startDate, this.endDate});

  factory DateRangeRequest.fromJson(Map<String, dynamic> json) =>
      _$DateRangeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DateRangeRequestToJson(this);
}
