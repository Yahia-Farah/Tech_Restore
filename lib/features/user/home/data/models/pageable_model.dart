import 'package:json_annotation/json_annotation.dart';
import 'sort_info_model.dart';

part 'pageable_model.g.dart';

@JsonSerializable()
class PageableModel {
  final int offset;
  final SortInfoModel sort;
  final bool paged;
  final int pageSize;
  final int pageNumber;
  final bool unpaged;

  PageableModel({
    required this.offset,
    required this.sort,
    required this.paged,
    required this.pageSize,
    required this.pageNumber,
    required this.unpaged,
  });

  factory PageableModel.fromJson(Map<String, dynamic> json) =>
      _$PageableModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageableModelToJson(this);
}
