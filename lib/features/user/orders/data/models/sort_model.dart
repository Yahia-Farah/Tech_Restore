import 'package:json_annotation/json_annotation.dart';

part 'sort_model.g.dart';

@JsonSerializable()
class SortModel {
  final bool empty;
  final bool sorted;
  final bool unsorted;

  const SortModel({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

  factory SortModel.fromJson(Map<String, dynamic> json) =>
      _$SortModelFromJson(json);

  Map<String, dynamic> toJson() => _$SortModelToJson(this);
}
