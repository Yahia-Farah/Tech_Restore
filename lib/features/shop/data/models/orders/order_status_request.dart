import 'package:json_annotation/json_annotation.dart';

part 'order_status_request.g.dart';

@JsonSerializable()
class OrderStatusRequest {
  @JsonKey(name: "status")
  final String status;

  OrderStatusRequest({
    required this.status,
  });

  factory OrderStatusRequest.fromJson(Map<String, dynamic> json) {
    return _$OrderStatusRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderStatusRequestToJson(this);
  }
}