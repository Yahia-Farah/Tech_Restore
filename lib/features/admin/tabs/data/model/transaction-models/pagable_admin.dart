import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/data/model/transaction-models/sort_transaction.dart';
import 'package:tech_restore/features/admin/tabs/data/model/transaction-models/transaction_admin_response.dart';
part 'pagable_admin.g.dart';

@JsonSerializable()
class PageableAdminTransaction {
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "sort")
  final List<SortTransaction>? sort;
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  PageableAdminTransaction ({
    this.offset,
    this.sort,
    this.paged,
    this.pageSize,
    this.pageNumber,
    this.unpaged,
  });

  factory PageableAdminTransaction.fromJson(Map<String, dynamic> json) {
    return _$PageableAdminTransactionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PageableAdminTransactionToJson(this);
  }
}