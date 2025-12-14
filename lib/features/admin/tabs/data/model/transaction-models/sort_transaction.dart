
import 'package:json_annotation/json_annotation.dart';

part 'sort_transaction.g.dart';

@JsonSerializable()
class SortTransaction {
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

  SortTransaction ({
    this.direction,
    this.nullHandling,
    this.ascending,
    this.property,
    this.ignoreCase,
  });

  factory SortTransaction.fromJson(Map<String, dynamic> json) {
    return _$SortTransactionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SortTransactionToJson(this);
  }
}