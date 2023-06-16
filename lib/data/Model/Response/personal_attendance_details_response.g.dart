// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_attendance_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalAttendanceDetailsResponse _$PersonalAttendanceDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    PersonalAttendanceDetailsResponse(
      inDate: json['inDate'] as String?,
      inTime: json['inTime'] as String?,
      outTime: json['outTime'] as String?,
      totalWork: json['totalWork'] as String?,
      daysType: json['daysType'] as String?,
      inDetails: json['inDetails'] as String?,
      outDetails: json['outDetails'] as String?,
    );

Map<String, dynamic> _$PersonalAttendanceDetailsResponseToJson(
        PersonalAttendanceDetailsResponse instance) =>
    <String, dynamic>{
      'inDate': instance.inDate,
      'inTime': instance.inTime,
      'outTime': instance.outTime,
      'totalWork': instance.totalWork,
      'daysType': instance.daysType,
      'inDetails': instance.inDetails,
      'outDetails': instance.outDetails,
    };
