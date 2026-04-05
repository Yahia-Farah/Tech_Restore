import 'package:json_annotation/json_annotation.dart';
import 'transaction_sort.dart';

part 'transaction_pageable.g.dart';

@JsonSerializable()
class TransactionPageable {
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "sort")
  final TransactionSort? sort;
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  TransactionPageable({
    this.offset,
    this.sort,
    this.paged,
    this.pageSize,
    this.pageNumber,
    this.unpaged,
  });

  factory TransactionPageable.fromJson(Map<String, dynamic> json) {
    return _$TransactionPageableFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionPageableToJson(this);
  }
}

