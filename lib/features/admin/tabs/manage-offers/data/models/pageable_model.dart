import 'package:json_annotation/json_annotation.dart';
import 'sort_model.dart';

part 'pageable_model.g.dart';

@JsonSerializable()
class PageableModel {
  final int? offset;
  final List<SortModel>? sort;
  final int? pageNumber;
  final int? pageSize;
  final bool? paged;
  final bool? unpaged;

  PageableModel({
    this.offset,
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.unpaged,
  });

  factory PageableModel.fromJson(Map<String, dynamic> json) =>
      _$PageableModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageableModelToJson(this);
}