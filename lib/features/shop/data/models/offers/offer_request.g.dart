// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferRequest _$OfferRequestFromJson(Map<String, dynamic> json) => OfferRequest(
  name: json['name'] as String?,
  description: json['description'] as String?,
  discountValue: (json['discountValue'] as num?)?.toDouble(),
  discountType: json['discountType'] as String?,
  status: json['status'] as String?,
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
);

Map<String, dynamic> _$OfferRequestToJson(OfferRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'discountValue': instance.discountValue,
      'discountType': instance.discountType,
      'status': instance.status,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
