import 'package:json_annotation/json_annotation.dart';
import 'repair_request_sort_info.dart';

part 'repair_request_pageable.g.dart';

@JsonSerializable()
class RepairRequestPageable {
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "sort")
  final RepairRequestSortInfo? sort;
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  RepairRequestPageable({
    this.paged,
    this.offset,
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.unpaged,
  });

  factory RepairRequestPageable.fromJson(Map<String, dynamic> json) {
    return _$RepairRequestPageableFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepairRequestPageableToJson(this);
  }
}
