import 'package:json_annotation/json_annotation.dart';
import 'transaction_content.dart';
import 'transaction_pageable.dart';
import 'transaction_sort.dart';

part 'transaction_admin_response.g.dart';

@JsonSerializable()
class TransactionAdminModelResponse {
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "pageable")
  final TransactionPageable? pageable;
  @JsonKey(name: "first")
  final bool? first;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "content")
  final List<TransactionContent>? content;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "sort")
  final TransactionSort? sort;
  @JsonKey(name: "numberOfElements")
  final int? numberOfElements;
  @JsonKey(name: "empty")
  final bool? empty;

  TransactionAdminModelResponse({
    this.totalElements,
    this.totalPages,
    this.pageable,
    this.first,
    this.last,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.numberOfElements,
    this.empty,
  });

  factory TransactionAdminModelResponse.fromJson(Map<String, dynamic> json) {
    return _$TransactionAdminModelResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionAdminModelResponseToJson(this);
  }
}

