import 'package:json_annotation/json_annotation.dart';
import 'content_delivery_admin.dart';
import 'sort_delivery_admin.dart';
import 'pageable_delivery_admin.dart';

part 'delivery_admin_response.g.dart';

@JsonSerializable()
class DeliveryAdminResponse {
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "content")
  final List<ContentDeliveryAdmin>? content;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "sort")
  final List<SortDeliveryAdmin>? sort;
  @JsonKey(name: "numberOfElements")
  final int? numberOfElements;
  @JsonKey(name: "pageable")
  final PageableDeliveryAdmin? pageable;
  @JsonKey(name: "first")
  final bool? first;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "empty")
  final bool? empty;

  DeliveryAdminResponse({
    this.totalPages,
    this.totalElements,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.numberOfElements,
    this.pageable,
    this.first,
    this.last,
    this.empty,
  });

  factory DeliveryAdminResponse.fromJson(Map<String, dynamic> json) {
    return _$DeliveryAdminResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DeliveryAdminResponseToJson(this);
  }
}


