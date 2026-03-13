import 'package:json_annotation/json_annotation.dart';

part 'sort_info_model.g.dart';

@JsonSerializable()
class SortInfoModel {
  final bool empty;
  final bool sorted;
  final bool unsorted;

  SortInfoModel({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

  factory SortInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SortInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$SortInfoModelToJson(this);
}
