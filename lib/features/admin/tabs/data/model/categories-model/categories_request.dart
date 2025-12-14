import 'package:json_annotation/json_annotation.dart';

part 'categories_request.g.dart';

@JsonSerializable()
class CategoriesRequest {
  @JsonKey(name: "name")
  final String? name;

  CategoriesRequest ({
    this.name,
  });

  factory CategoriesRequest.fromJson(Map<String, dynamic> json) {
    return _$CategoriesRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesRequestToJson(this);
  }
}


