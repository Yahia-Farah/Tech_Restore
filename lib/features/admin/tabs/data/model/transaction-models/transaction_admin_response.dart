import 'package:json_annotation/json_annotation.dart';
import 'transaction_content.dart';
import 'transaction_sort.dart';
import 'transaction_pageable.dart';

part 'transaction_admin_response.g.dart';

@JsonSerializable()
class TransactionAdminModelResponse {
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
  final List<TransactionContent>? content;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "sort")
  final List<TransactionSort>? sort;
  @JsonKey(name: "pageable")
  final TransactionPageable? pageable;
  @JsonKey(name: "empty")
  final bool? empty;

  TransactionAdminModelResponse({
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

  factory TransactionAdminModelResponse.fromJson(Map<String, dynamic> json) {
    return _$TransactionAdminModelResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionAdminModelResponseToJson(this);
  }
}
