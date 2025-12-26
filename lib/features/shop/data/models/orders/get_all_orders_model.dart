import 'package:json_annotation/json_annotation.dart';

part 'get_all_orders_model.g.dart';

@JsonSerializable()
class GetAllOrdersModel {
  @JsonKey(name: "content")
  final List<OrderContent>? content;
  @JsonKey(name: "pageable")
  final OrderPageable? pageable;
  @JsonKey(name: "last")
  final bool? last;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalElements")
  final int? totalElements;
  @JsonKey(name: "size")
  final int? size;
  @JsonKey(name: "number")
  final int? number;
  @JsonKey(name: "sort")
  final OrderSort? sort;
  @JsonKey(name: "first")
  final bool? first;
  @JsonKey(name: "numberOfElements")
  final int? numberOfElements;
  @JsonKey(name: "empty")
  final bool? empty;

  GetAllOrdersModel({
    this.content,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.size,
    this.number,
    this.sort,
    this.first,
    this.numberOfElements,
    this.empty,
  });

  factory GetAllOrdersModel.fromJson(Map<String, dynamic> json) {
    return _$GetAllOrdersModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetAllOrdersModelToJson(this);
  }
}

@JsonSerializable()
class OrderContent {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "deliveryAddressId")
  final String? deliveryAddressId;
  @JsonKey(name: "totalPrice")
  final double? totalPrice;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "paymentMethod")
  final String? paymentMethod;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "paymentId")
  final String? paymentId;
  @JsonKey(name: "orderItems")
  final List<OrderItem>? orderItems;

  OrderContent({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.deliveryAddressId,
    this.totalPrice,
    this.status,
    this.paymentMethod,
    this.createdAt,
    this.paymentId,
    this.orderItems,
  });

  factory OrderContent.fromJson(Map<String, dynamic> json) {
    return _$OrderContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderContentToJson(this);
  }
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "productId")
  final String? productId;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "priceAtCheckout")
  final double? priceAtCheckout;
  @JsonKey(name: "shopId")
  final String? shopId;
  @JsonKey(name: "subtotal")
  final double? subtotal;
  @JsonKey(name: "productName")
  final String? productName;
  @JsonKey(name: "price")
  final double? price;
  @JsonKey(name: "shopName")
  final String? shopName;

  OrderItem({
    this.id,
    this.productId,
    this.quantity,
    this.priceAtCheckout,
    this.shopId,
    this.subtotal,
    this.productName,
    this.price,
    this.shopName,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return _$OrderItemFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderItemToJson(this);
  }
}

@JsonSerializable()
class OrderPageable {
  @JsonKey(name: "pageNumber")
  final int? pageNumber;
  @JsonKey(name: "pageSize")
  final int? pageSize;
  @JsonKey(name: "sort")
  final OrderSort? sort;
  @JsonKey(name: "offset")
  final int? offset;
  @JsonKey(name: "paged")
  final bool? paged;
  @JsonKey(name: "unpaged")
  final bool? unpaged;

  OrderPageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.paged,
    this.unpaged,
  });

  factory OrderPageable.fromJson(Map<String, dynamic> json) {
    return _$OrderPageableFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderPageableToJson(this);
  }
}

@JsonSerializable()
class OrderSort {
  @JsonKey(name: "empty")
  final bool? empty;
  @JsonKey(name: "sorted")
  final bool? sorted;
  @JsonKey(name: "unsorted")
  final bool? unsorted;

  OrderSort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  factory OrderSort.fromJson(Map<String, dynamic> json) {
    return _$OrderSortFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderSortToJson(this);
  }
}