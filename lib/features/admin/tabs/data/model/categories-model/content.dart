import 'package:json_annotation/json_annotation.dart';

part 'content.g.dart';

@JsonSerializable()
class Content {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  Content({
    this.id,
    this.name,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return _$ContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ContentToJson(this);
  }
}


