import 'package:json_annotation/json_annotation.dart';

part 'repair_request_sort.g.dart';

@JsonSerializable()
class RepairRequestSort {
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

  RepairRequestSort({
    this.direction,
    this.nullHandling,
    this.ascending,
    this.property,
    this.ignoreCase,
  });

  factory RepairRequestSort.fromJson(Map<String, dynamic> json) {
    return _$RepairRequestSortFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepairRequestSortToJson(this);
  }
}
