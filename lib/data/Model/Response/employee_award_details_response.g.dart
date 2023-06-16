// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_award_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeAwardsDetailsResponse _$EmployeeAwardsDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeAwardsDetailsResponse(
      awardId: json['awardId'] as int?,
      employeeId: json['employeeId'] as int?,
      awardTypeId: json['awardTypeId'] as int?,
      awardTypeName: json['awardTypeName'] as String?,
      description: json['description'] as String?,
      dateGiven: json['dateGiven'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$EmployeeAwardsDetailsResponseToJson(
        EmployeeAwardsDetailsResponse instance) =>
    <String, dynamic>{
      'awardId': instance.awardId,
      'employeeId': instance.employeeId,
      'awardTypeId': instance.awardTypeId,
      'awardTypeName': instance.awardTypeName,
      'description': instance.description,
      'dateGiven': instance.dateGiven,
      'remarks': instance.remarks,
    };
