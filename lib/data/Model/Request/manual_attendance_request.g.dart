// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_attendance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManualAttendanceRequest _$ManualAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    ManualAttendanceRequest(
      employeeId: json['employeeId'] as int?,
      attendanceDate: json['attendanceDate'] as String?,
      attendanceTime: json['attendanceTime'] as String?,
      reason: json['reason'] as String?,
      location: json['location'] as String?,
      file: json['file'] as String?,
    );

Map<String, dynamic> _$ManualAttendanceRequestToJson(
        ManualAttendanceRequest instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'attendanceDate': instance.attendanceDate,
      'attendanceTime': instance.attendanceTime,
      'reason': instance.reason,
      'location': instance.location,
      'file': instance.file,
    };
