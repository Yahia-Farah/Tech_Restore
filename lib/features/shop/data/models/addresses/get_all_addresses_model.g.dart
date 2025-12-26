// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_addresses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAddressesModel _$GetAllAddressesModelFromJson(
        Map<String, dynamic> json) =>
    GetAllAddressesModel(
      totalElements: (json['totalElements'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      size: (json['size'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => AddressContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num?)?.toInt(),
      sort: json['sort'] == null
          ? null
          : AddressSort.fromJson(json['sort'] as Map<String, dynamic>),
      numberOfElements: (json['numberOfElements'] as num?)?.toInt(),
      pageable: json['pageable'] == null
          ? null
          : AddressPageable.fromJson(json['pageable'] as Map<String, dynamic>),
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$GetAllAddressesModelToJson(
        GetAllAddressesModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'first': instance.first,
      'last': instance.last,
      'size': instance.size,
      'content': instance.content,
      'number': instance.number,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'pageable': instance.pageable,
      'empty': instance.empty,
    };

AddressContent _$AddressContentFromJson(Map<String, dynamic> json) =>
    AddressContent(
      id: json['id'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      building: json['building'] as String?,
      notes: json['notes'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isDefault: json['default'] as bool?,
    );

Map<String, dynamic> _$AddressContentToJson(AddressContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'building': instance.building,
      'notes': instance.notes,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'default': instance.isDefault,
    };

AddressSort _$AddressSortFromJson(Map<String, dynamic> json) => AddressSort(
      empty: json['empty'] as bool?,
      sorted: json['sorted'] as bool?,
      unsorted: json['unsorted'] as bool?,
    );

Map<String, dynamic> _$AddressSortToJson(AddressSort instance) =>
    <String, dynamic>{
      'empty': instance.empty,
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
    };

AddressPageable _$AddressPageableFromJson(Map<String, dynamic> json) =>
    AddressPageable(
      offset: (json['offset'] as num?)?.toInt(),
      sort: json['sort'] == null
          ? null
          : AddressSort.fromJson(json['sort'] as Map<String, dynamic>),
      paged: json['paged'] as bool?,
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$AddressPageableToJson(AddressPageable instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'sort': instance.sort,
      'paged': instance.paged,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'unpaged': instance.unpaged,
    };
