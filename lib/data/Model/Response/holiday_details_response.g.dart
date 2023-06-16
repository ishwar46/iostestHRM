// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayDetailsResponse _$HolidayDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    HolidayDetailsResponse(
      holydayId: json['holydayId'] as int?,
      holydayName: json['holydayName'] as String?,
      description: json['description'] as String?,
      dateFrom: json['dateFrom'] as String?,
      dateTo: json['dateTo'] as String?,
      repeatsAnnually: json['repeatsAnnually'] as bool?,
      holydayType: json['holydayType'] as int?,
      isForFemaleOnly: json['isForFemaleOnly'] as bool?,
      isActive: json['isActive'] as bool?,
      dFrom: json['dFrom'] as String?,
    );

Map<String, dynamic> _$HolidayDetailsResponseToJson(
        HolidayDetailsResponse instance) =>
    <String, dynamic>{
      'holydayId': instance.holydayId,
      'holydayName': instance.holydayName,
      'description': instance.description,
      'dateFrom': instance.dateFrom,
      'dateTo': instance.dateTo,
      'repeatsAnnually': instance.repeatsAnnually,
      'holydayType': instance.holydayType,
      'isForFemaleOnly': instance.isForFemaleOnly,
      'isActive': instance.isActive,
      'dFrom': instance.dFrom,
    };
