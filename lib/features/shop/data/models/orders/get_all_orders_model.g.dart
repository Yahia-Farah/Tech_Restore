// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllOrdersModel _$GetAllOrdersModelFromJson(Map<String, dynamic> json) =>
    GetAllOrdersModel(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => OrderContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable: json['pageable'] == null
          ? null
          : OrderPageable.fromJson(json['pageable'] as Map<String, dynamic>),
      last: json['last'] as bool?,
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      number: (json['number'] as num?)?.toInt(),
      sort: json['sort'] == null
          ? null
          : OrderSort.fromJson(json['sort'] as Map<String, dynamic>),
      first: json['first'] as bool?,
      numberOfElements: (json['numberOfElements'] as num?)?.toInt(),
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$GetAllOrdersModelToJson(GetAllOrdersModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
      'number': instance.number,
      'sort': instance.sort,
      'first': instance.first,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
    };

OrderContent _$OrderContentFromJson(Map<String, dynamic> json) => OrderContent(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      deliveryAddressId: json['deliveryAddressId'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      status: json['status'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      createdAt: json['createdAt'] as String?,
      paymentId: json['paymentId'] as String?,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderContentToJson(OrderContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'deliveryAddressId': instance.deliveryAddressId,
      'totalPrice': instance.totalPrice,
      'status': instance.status,
      'paymentMethod': instance.paymentMethod,
      'createdAt': instance.createdAt,
      'paymentId': instance.paymentId,
      'orderItems': instance.orderItems,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      priceAtCheckout: (json['priceAtCheckout'] as num?)?.toDouble(),
      shopId: json['shopId'] as String?,
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      productName: json['productName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      shopName: json['shopName'] as String?,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'priceAtCheckout': instance.priceAtCheckout,
      'shopId': instance.shopId,
      'subtotal': instance.subtotal,
      'productName': instance.productName,
      'price': instance.price,
      'shopName': instance.shopName,
    };

OrderPageable _$OrderPageableFromJson(Map<String, dynamic> json) =>
    OrderPageable(
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      sort: json['sort'] == null
          ? null
          : OrderSort.fromJson(json['sort'] as Map<String, dynamic>),
      offset: (json['offset'] as num?)?.toInt(),
      paged: json['paged'] as bool?,
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$OrderPageableToJson(OrderPageable instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'sort': instance.sort,
      'offset': instance.offset,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };

OrderSort _$OrderSortFromJson(Map<String, dynamic> json) => OrderSort(
      empty: json['empty'] as bool?,
      sorted: json['sorted'] as bool?,
      unsorted: json['unsorted'] as bool?,
    );

Map<String, dynamic> _$OrderSortToJson(OrderSort instance) => <String, dynamic>{
      'empty': instance.empty,
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
    };
