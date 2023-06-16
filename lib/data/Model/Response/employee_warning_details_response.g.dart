// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_warning_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeWarningDetailsResponse _$EmployeeWarningDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeWarningDetailsResponse(
      warningId: json['warningId'] as int?,
      employeeId: json['employeeId'] as int?,
      warningTypeId: json['warningTypeId'] as int?,
      warningTypeName: json['warningTypeName'] as String?,
      description: json['description'] as String?,
      dateGiven: json['dateGiven'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$EmployeeWarningDetailsResponseToJson(
        EmployeeWarningDetailsResponse instance) =>
    <String, dynamic>{
      'warningId': instance.warningId,
      'employeeId': instance.employeeId,
      'warningTypeId': instance.warningTypeId,
      'warningTypeName': instance.warningTypeName,
      'description': instance.description,
      'dateGiven': instance.dateGiven,
      'remarks': instance.remarks,
    };
