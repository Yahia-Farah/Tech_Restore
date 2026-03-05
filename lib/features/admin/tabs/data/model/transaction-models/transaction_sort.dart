import 'package:json_annotation/json_annotation.dart';

part 'transaction_sort.g.dart';

@JsonSerializable()
class TransactionSort {
  @JsonKey(name: "direction")
  final String? direction;
  @JsonKey(name: "nullHandling")
  final String? nullHandling;
  @JsonKey(name: "ascending")
  final bool? ascending;
  @JsonKey(name: "property")
  final String? property;
  @JsonKey(name: "ignoreCase")
  final bool? ignoreCase;

  TransactionSort({
    this.direction,
    this.nullHandling,
    this.ascending,
    this.property,
    this.ignoreCase,
  });

  factory TransactionSort.fromJson(Map<String, dynamic> json) {
    return _$TransactionSortFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionSortToJson(this);
  }
}
