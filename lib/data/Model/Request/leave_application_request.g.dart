// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_application_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveApplicationRequest _$LeaveApplicationRequestFromJson(
        Map<String, dynamic> json) =>
    LeaveApplicationRequest(
      employeeId: json['employeeId'] as int?,
      recomendTo: json['recomendTo'] as int?,
      leaveTypeId: json['leaveTypeId'] as int?,
      subject: json['subject'] as String?,
      leaveSubmitDate: json['leaveSubmitDate'] as String?,
      requestDate: json['requestDate'] as String?,
      fromdate: json['fromdate'] as String?,
      toDate: json['toDate'] as String?,
      discription: json['discription'] as String?,
      halfDay: json['halfDay'] as bool?,
      isActive: json['isActive'] as bool?,
      file: json['file'] as String?,
    );

Map<String, dynamic> _$LeaveApplicationRequestToJson(
        LeaveApplicationRequest instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'recomendTo': instance.recomendTo,
      'leaveTypeId': instance.leaveTypeId,
      'subject': instance.subject,
      'leaveSubmitDate': instance.leaveSubmitDate,
      'requestDate': instance.requestDate,
      'fromdate': instance.fromdate,
      'toDate': instance.toDate,
      'discription': instance.discription,
      'halfDay': instance.halfDay,
      'isActive': instance.isActive,
      'file': instance.file,
    };
