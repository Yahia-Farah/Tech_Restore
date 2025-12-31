import 'package:json_annotation/json_annotation.dart';
import 'shop_model.dart';
import '../../../orders/data/models/pageable_model.dart';
import '../../../orders/data/models/sort_model.dart';

part 'get_shops_response_model.g.dart';

@JsonSerializable()
class GetShopsResponseModel {
  final List<ShopModel> content;
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

  const GetShopsResponseModel({
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

  factory GetShopsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetShopsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetShopsResponseModelToJson(this);
}
