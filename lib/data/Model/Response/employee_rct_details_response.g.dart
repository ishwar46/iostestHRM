// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_rct_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeRCTDetailsResponse _$EmployeeRCTDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeRCTDetailsResponse(
      rctId: json['rctId'] as int?,
      employeeId: json['employeeId'] as int?,
      rctTypeId: json['rctTypeId'] as int?,
      rctTypeName: json['rctTypeName'] as String?,
      topic: json['topic'] as String?,
      journalName: json['journalName'] as String?,
      issn: json['issn'] as String?,
      venue: json['venue'] as String?,
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
      academicYear: json['academicYear'] as String?,
      fundElegibility: json['fundElegibility'] as String?,
      presentedDate: json['presentedDate'] as String?,
      presented: json['presented'] as int?,
    );

Map<String, dynamic> _$EmployeeRCTDetailsResponseToJson(
        EmployeeRCTDetailsResponse instance) =>
    <String, dynamic>{
      'rctId': instance.rctId,
      'employeeId': instance.employeeId,
      'rctTypeId': instance.rctTypeId,
      'rctTypeName': instance.rctTypeName,
      'topic': instance.topic,
      'journalName': instance.journalName,
      'issn': instance.issn,
      'venue': instance.venue,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'academicYear': instance.academicYear,
      'fundElegibility': instance.fundElegibility,
      'presentedDate': instance.presentedDate,
      'presented': instance.presented,
    };
