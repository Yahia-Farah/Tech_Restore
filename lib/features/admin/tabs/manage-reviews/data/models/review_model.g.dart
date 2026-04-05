// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      isApproved: json['isApproved'] as bool?,
      isFlagged: json['isFlagged'] as bool?,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isApproved': instance.isApproved,
      'isFlagged': instance.isFlagged,
    };
