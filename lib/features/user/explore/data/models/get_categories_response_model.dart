import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';
import '../../../orders/data/models/pageable_model.dart';
import '../../../orders/data/models/sort_model.dart';

part 'get_categories_response_model.g.dart';

@JsonSerializable()
class GetCategoriesResponseModel {
  final List<CategoryModel> content;
  final PageableModel pageable;
  final int totalElements;
  final int totalPages;
  final bool last;
  final int size;
  final int number;
  final SortModel sort;
  final int numberOfElements;
  final bool first;
  final bool empty;

  const GetCategoriesResponseModel({
    required this.content,
    required this.pageable,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory GetCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCategoriesResponseModelToJson(this);
}
