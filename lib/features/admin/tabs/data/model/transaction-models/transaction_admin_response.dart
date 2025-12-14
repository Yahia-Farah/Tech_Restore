import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/data/model/transaction-models/pagable_admin.dart';
import 'package:tech_restore/features/admin/tabs/data/model/transaction-models/sort_transaction.dart';

import 'content_transaction_admin.dart';

part 'transaction_admin_response.g.dart';

@JsonSerializable()
class TransactionAdminModelResponse {
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "content")
  final List<ContentTransactionAdmin>? content;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "sort")
  final List<SortTransaction>? sort;
  @JsonKey(name: "numberOfElements")
  final int? numberOfElements;
  @JsonKey(name: "pageable")
  final PageableAdminTransaction? pageable;
  @JsonKey(name: "first")
  final bool? first;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "empty")
  final bool? empty;

  TransactionAdminModelResponse ({
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

  factory TransactionAdminModelResponse.fromJson(Map<String, dynamic> json) {
    return _$TransactionAdminModelResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionAdminModelResponseToJson(this);
  }
}









