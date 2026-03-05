import 'package:json_annotation/json_annotation.dart';

part 'repair_request_sort_info.g.dart';

@JsonSerializable()
class RepairRequestSortInfo {
  @JsonKey(name: "sorted")
  final bool? sorted;
  @JsonKey(name: "empty")
  final bool? empty;
  @JsonKey(name: "unsorted")
  final bool? unsorted;

  RepairRequestSortInfo({
    this.sorted,
    this.empty,
    this.unsorted,
  });

  factory RepairRequestSortInfo.fromJson(Map<String, dynamic> json) {
    return _$RepairRequestSortInfoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepairRequestSortInfoToJson(this);
  }
}
