import 'package:json_annotation/json_annotation.dart';
import 'transaction_sort.dart';

part 'transaction_pageable.g.dart';

@JsonSerializable()
class TransactionPageable {
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "sort")
  final List<TransactionSort>? sort;
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  TransactionPageable({
    this.paged,
    this.offset,
    this.sort,
    this.pageNumber,
    this.pageSize,
    this.unpaged,
  });

  factory TransactionPageable.fromJson(Map<String, dynamic> json) {
    return _$TransactionPageableFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionPageableToJson(this);
  }
}
