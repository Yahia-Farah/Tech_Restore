import 'package:json_annotation/json_annotation.dart';

part 'get_all_offers_model.g.dart';

@JsonSerializable()
class GetAllOffersModel {
  @JsonKey(name: "content")
  final List<Content>? content;
  @JsonKey(name: "pageable")
  final Pageable? pageable;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "first")
  final bool? first;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "sort")
  final Sort? sort;
  @JsonKey(name: "numberOfElements")
  final int? numberOfElements;
  @JsonKey(name: "empty")
  final bool? empty;

  GetAllOffersModel ({
    this.content,
    this.pageable,
    this.last,
    this.totalElements,
    this.totalPages,
    this.first,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.empty,
  });

  factory GetAllOffersModel.fromJson(Map<String, dynamic> json) {
    return _$GetAllOffersModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllOffersModelToJson(this);
  }
}

@JsonSerializable()
class Content {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "discountValue")
  final double? discountValue;
  @JsonKey(name: "discountType")
  final dynamic discountType;
  @JsonKey(name: "startDate")
  final String? startDate;
  @JsonKey(name: "endDate")
  final String? endDate;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "shopId")
  final String? shopId;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "shopName")
  final String? shopName;

  Content ({
    this.id,
    this.name,
    this.description,
    this.discountValue,
    this.discountType,
    this.startDate,
    this.endDate,
    this.status,
    this.shopId,
    this.createdAt,
    this.updatedAt,
    this.shopName,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return _$ContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ContentToJson(this);
  }
}

@JsonSerializable()
class Pageable {
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "sort")
  final Sort? sort;
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  Pageable ({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.paged,
    this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return _$PageableFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PageableToJson(this);
  }
}

@JsonSerializable()
class Sort {
  @JsonKey(name: "empty")
  final bool? empty;
  @JsonKey(name: "sorted")
  final bool? sorted;
  @JsonKey(name: "unsorted")
  final bool? unsorted;

  Sort ({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) {
    return _$SortFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SortToJson(this);
  }
}