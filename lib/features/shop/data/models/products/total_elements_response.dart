import 'package:json_annotation/json_annotation.dart';

part 'total_elements_response.g.dart';

@JsonSerializable()
class TotalElementsResponse {
  @JsonKey(name: "totalElements")
  final int? totalElements;

  TotalElementsResponse({
    this.totalElements,
  });

  factory TotalElementsResponse.fromJson(Map<String, dynamic> json) {
    return _$TotalElementsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TotalElementsResponseToJson(this);
  }
}

