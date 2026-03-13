// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_range_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateRangeRequest _$DateRangeRequestFromJson(Map<String, dynamic> json) =>
    DateRangeRequest(
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$DateRangeRequestToJson(DateRangeRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
