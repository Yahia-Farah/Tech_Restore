import 'package:json_annotation/json_annotation.dart';
import 'sort_delivery_admin.dart';

part 'pageable_delivery_admin.g.dart';

@JsonSerializable()
class PageableDeliveryAdmin {
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "sort")
  final List<SortDeliveryAdmin>? sort;
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  PageableDeliveryAdmin({
    this.offset,
    this.sort,
    this.paged,
    this.pageSize,
    this.pageNumber,
    this.unpaged,
  });

  factory PageableDeliveryAdmin.fromJson(Map<String, dynamic> json) {
    return _$PageableDeliveryAdminFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PageableDeliveryAdminToJson(this);
  }
}
