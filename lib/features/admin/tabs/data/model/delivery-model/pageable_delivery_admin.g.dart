// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageable_delivery_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageableDeliveryAdmin _$PageableDeliveryAdminFromJson(
  Map<String, dynamic> json,
) => PageableDeliveryAdmin(
  offset: (json['offset'] as num?)?.toInt(),
  sort:
      (json['sort'] as List<dynamic>?)
          ?.map((e) => SortDeliveryAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
  paged: json['paged'] as bool?,
  pageSize: (json['pageSize'] as num?)?.toInt(),
  pageNumber: (json['pageNumber'] as num?)?.toInt(),
  unpaged: json['unpaged'] as bool?,
);

Map<String, dynamic> _$PageableDeliveryAdminToJson(
  PageableDeliveryAdmin instance,
) => <String, dynamic>{
  'offset': instance.offset,
  'sort': instance.sort,
  'paged': instance.paged,
  'pageSize': instance.pageSize,
  'pageNumber': instance.pageNumber,
  'unpaged': instance.unpaged,
};
