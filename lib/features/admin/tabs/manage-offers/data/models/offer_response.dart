import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/manage-offers/data/models/offer_model.dart';

part 'offer_response.g.dart';

@JsonSerializable()
class OfferListResponse {
  final List<OfferModel>? content;

  OfferListResponse({this.content});

  factory OfferListResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferListResponseToJson(this);
}