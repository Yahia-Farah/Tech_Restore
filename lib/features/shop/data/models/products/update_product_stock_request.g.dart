// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_product_stock_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProductStockRequest _$UpdateProductStockRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProductStockRequest(
      newStock: (json['newStock'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateProductStockRequestToJson(
        UpdateProductStockRequest instance) =>
    <String, dynamic>{
      'newStock': instance.newStock,
    };
