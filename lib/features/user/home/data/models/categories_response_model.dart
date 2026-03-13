import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';
import 'sort_info_model.dart';
import 'pageable_model.dart';

part 'categories_response_model.g.dart';

@JsonSerializable()
class CategoriesResponseModel {
  final int totalElements;
  final int totalPages;
  final int size;
  final List<CategoryModel> content;
  final int number;
  final SortInfoModel sort;
  final bool first;
  final bool last;
  final int numberOfElements;
  final PageableModel pageable;
  final bool empty;

  CategoriesResponseModel({
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.content,
    required this.number,
    required this.sort,
    required this.first,
    required this.last,
    required this.numberOfElements,
    required this.pageable,
    required this.empty,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseModelToJson(this);
}
