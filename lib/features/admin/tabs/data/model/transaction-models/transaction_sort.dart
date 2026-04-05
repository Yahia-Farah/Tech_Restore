import 'package:json_annotation/json_annotation.dart';

part 'transaction_sort.g.dart';

@JsonSerializable()
class TransactionSort {
  @JsonKey(name: "sorted")
  final bool? sorted;
  @JsonKey(name: "unsorted")
  final bool? unsorted;
  @JsonKey(name: "empty")
  final bool? empty;

  TransactionSort({
    this.sorted,
    this.unsorted,
    this.empty,
  });

  factory TransactionSort.fromJson(Map<String, dynamic> json) {
    return _$TransactionSortFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionSortToJson(this);
  }
}


