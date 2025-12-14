// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagable_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageableAdminTransaction _$PageableAdminTransactionFromJson(
        Map<String, dynamic> json) =>
    PageableAdminTransaction(
      offset: (json['offset'] as num?)?.toInt(),
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => SortTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      paged: json['paged'] as bool?,
      pageSize: (json['pageSize'] as num?)?.toInt(),
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$PageableAdminTransactionToJson(
        PageableAdminTransaction instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'sort': instance.sort,
      'paged': instance.paged,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
      'unpaged': instance.unpaged,
    };
