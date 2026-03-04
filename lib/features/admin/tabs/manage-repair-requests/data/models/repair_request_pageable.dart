import 'package:json_annotation/json_annotation.dart';
import 'repair_request_sort.dart';

part 'repair_request_pageable.g.dart';

@JsonSerializable()
class RepairRequestPageable {
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "sort")
  final List<RepairRequestSort>? sort;
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  RepairRequestPageable({
    this.offset,
    this.sort,
    this.paged,
    this.pageSize,
    this.pageNumber,
    this.unpaged,
  });

  factory RepairRequestPageable.fromJson(Map<String, dynamic> json) {
    return _$RepairRequestPageableFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepairRequestPageableToJson(this);
  }
}
