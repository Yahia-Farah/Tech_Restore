import 'package:json_annotation/json_annotation.dart';
import 'repair_request_content.dart';
import 'repair_request_sort_info.dart';
import 'repair_request_pageable.dart';

part 'repair_request_model.g.dart';

@JsonSerializable()
class RepairRequestModel {
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "first")
  final bool? first;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "numberOfElements")
  final int? numberOfElements;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "content")
  final List<RepairRequestContent>? content;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "sort")
  final RepairRequestSortInfo? sort;
  @JsonKey(name: "pageable")
  final RepairRequestPageable? pageable;
  @JsonKey(name: "empty")
  final bool? empty;

  RepairRequestModel({
    this.totalPages,
    this.totalElements,
    this.first,
    this.last,
    this.numberOfElements,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.pageable,
    this.empty,
  });

  factory RepairRequestModel.fromJson(Map<String, dynamic> json) {
    return _$RepairRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepairRequestModelToJson(this);
  }
}
