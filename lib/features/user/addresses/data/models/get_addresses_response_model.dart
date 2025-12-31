import 'address_model.dart';

class GetAddressesResponseModel {
  final List<AddressModel> content;
  final Pageable pageable;
  final bool last;
  final int totalPages;
  final int totalElements;
  final bool first;
  final int size;
  final int number;
  final Sort sort;
  final int numberOfElements;
  final bool empty;

  GetAddressesResponseModel({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.first,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.empty,
  });

  factory GetAddressesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetAddressesResponseModel(
      content:
          (json['content'] as List<dynamic>?)
              ?.map(
                (item) => AddressModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      pageable: Pageable.fromJson(json['pageable'] ?? {}),
      last: json['last'] ?? true,
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      first: json['first'] ?? true,
      size: json['size'] ?? 0,
      number: json['number'] ?? 0,
      sort: Sort.fromJson(json['sort'] ?? {}),
      numberOfElements: json['numberOfElements'] ?? 0,
      empty: json['empty'] ?? true,
    );
  }
}

class Pageable {
  final int pageNumber;
  final int pageSize;
  final Sort sort;
  final int offset;
  final bool unpaged;
  final bool paged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.unpaged,
    required this.paged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      pageNumber: json['pageNumber'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      sort: Sort.fromJson(json['sort'] ?? {}),
      offset: json['offset'] ?? 0,
      unpaged: json['unpaged'] ?? false,
      paged: json['paged'] ?? false,
    );
  }
}

class Sort {
  final bool unsorted;
  final bool empty;
  final bool sorted;

  Sort({required this.unsorted, required this.empty, required this.sorted});

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      unsorted: json['unsorted'] ?? true,
      empty: json['empty'] ?? true,
      sorted: json['sorted'] ?? false,
    );
  }
}
