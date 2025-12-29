import 'package:json_annotation/json_annotation.dart';

part 'get_all_addresses_model.g.dart';

@JsonSerializable()
class GetAllAddressesModel {
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "first")
  final bool? first;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "content")
  final List<AddressContent>? content;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "sort")
  final AddressSort? sort;
  @JsonKey(name: "numberOfElements")
  final int? numberOfElements;
  @JsonKey(name: "pageable")
  final AddressPageable? pageable;
  @JsonKey(name: "empty")
  final bool? empty;

  GetAllAddressesModel({
    this.totalElements,
    this.totalPages,
    this.first,
    this.last,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.numberOfElements,
    this.pageable,
    this.empty,
  });

  factory GetAllAddressesModel.fromJson(Map<String, dynamic> json) {
    return _$GetAllAddressesModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllAddressesModelToJson(this);
  }
}

@JsonSerializable()
class AddressContent {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "building")
  final String? building;
  @JsonKey(name: "notes")
  final String? notes;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "longitude")
  final double? longitude;
  @JsonKey(name: "default")
  final bool? isDefault;

  AddressContent({
    this.id,
    this.state,
    this.city,
    this.street,
    this.building,
    this.notes,
    this.userId,
    this.createdAt,
    this.latitude,
    this.longitude,
    this.isDefault,
  });

  factory AddressContent.fromJson(Map<String, dynamic> json) {
    return _$AddressContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressContentToJson(this);
  }
}

@JsonSerializable()
class AddressSort {
  @JsonKey(name: "empty")
  final bool? empty;
  @JsonKey(name: "sorted")
  final bool? sorted;
  @JsonKey(name: "unsorted")
  final bool? unsorted;

  AddressSort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  factory AddressSort.fromJson(Map<String, dynamic> json) {
    return _$AddressSortFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressSortToJson(this);
  }
}

@JsonSerializable()
class AddressPageable {
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "sort")
  final AddressSort? sort;
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  AddressPageable({
    this.offset,
    this.sort,
    this.paged,
    this.pageNumber,
    this.pageSize,
    this.unpaged,
  });

  factory AddressPageable.fromJson(Map<String, dynamic> json) {
    return _$AddressPageableFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressPageableToJson(this);
  }
}