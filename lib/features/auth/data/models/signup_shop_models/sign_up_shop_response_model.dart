import 'package:json_annotation/json_annotation.dart';

part 'sign_up_shop_response_model.g.dart';

@JsonSerializable()
class SignUpShopResponseModel {
  @JsonKey(name: "message")
  final String message;

  SignUpShopResponseModel ({
    required this.message,
  });

  factory SignUpShopResponseModel.fromJson(Map<String, dynamic> json) {
    return _$SignUpShopResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignUpShopResponseModelToJson(this);
  }
}


