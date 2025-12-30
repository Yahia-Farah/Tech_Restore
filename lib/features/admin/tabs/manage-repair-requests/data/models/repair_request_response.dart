import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/manage-repair-requests/data/models/repair_request_model.dart';

part 'repair_request_response.g.dart';

@JsonSerializable()
class RepairRequestListResponse {
  final List<RepairRequestModel>? content;

  RepairRequestListResponse({this.content});

  factory RepairRequestListResponse.fromJson(Map<String, dynamic> json) =>
      _$RepairRequestListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RepairRequestListResponseToJson(this);
}