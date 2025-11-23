import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/data/models/shop_model.dart';

part 'shop_response.g.dart';
@JsonSerializable()
class ShopListResponse {
  final List<ShopModel>? content;

  ShopListResponse({this.content});

  factory ShopListResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopListResponseToJson(this);
}