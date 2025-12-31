import 'package:json_annotation/json_annotation.dart';
import 'order_model.dart';
import 'pageable_model.dart';
import 'sort_model.dart';

part 'get_orders_response_model.g.dart';

@JsonSerializable()
class GetOrdersResponseModel {
  final int totalPages;
  final int totalElements;
  final bool first;
  final bool last;
  final int size;
  final List<OrderModel> content;
  final int number;
  final SortModel sort;
  final int numberOfElements;
  final PageableModel pageable;
  final bool empty;

  const GetOrdersResponseModel({
    required this.totalPages,
    required this.totalElements,
    required this.first,
    required this.last,
    required this.size,
    required this.content,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.pageable,
    required this.empty,
  });

  factory GetOrdersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetOrdersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrdersResponseModelToJson(this);
}
