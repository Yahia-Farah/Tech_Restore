import 'package:json_annotation/json_annotation.dart';

part 'sort_model.g.dart';

@JsonSerializable()
class SortModel {
  final String? direction;
  final String? nullHandling;
  final bool? ascending;
  final String? property;
  final bool? ignoreCase;

  SortModel({
    this.direction,
    this.nullHandling,
    this.ascending,
    this.property,
    this.ignoreCase,
  });

  factory SortModel.fromJson(Map<String, dynamic> json) =>
      _$SortModelFromJson(json);

  Map<String, dynamic> toJson() => _$SortModelToJson(this);
}