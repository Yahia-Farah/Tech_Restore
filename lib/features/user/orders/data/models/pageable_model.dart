import 'package:json_annotation/json_annotation.dart';

part 'pageable_model.g.dart';

@JsonSerializable()
class PageableModel {
  final int offset;
  final Map<String, dynamic> sort;
  final bool unpaged;
  final bool paged;
  final int pageSize;
  final int pageNumber;

  const PageableModel({
    required this.offset,
    required this.sort,
    required this.unpaged,
    required this.paged,
    required this.pageSize,
    required this.pageNumber,
  });

  factory PageableModel.fromJson(Map<String, dynamic> json) =>
      _$PageableModelFromJson(json);

  Map<String, dynamic> toJson() => _$PageableModelToJson(this);
}
