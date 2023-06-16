// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveSummaryResponse _$LeaveSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    LeaveSummaryResponse(
      employeeId: json['employeeId'] as num?,
      leaveTypeId: json['leaveTypeId'] as num?,
      leaveType: json['leaveType'] as String?,
      noOfDays: json['noOfDays'] as String?,
      takenDays: json['takenDays'] as String?,
      remainingLeave: json['remainingLeave'] as String?,
    );

Map<String, dynamic> _$LeaveSummaryResponseToJson(
        LeaveSummaryResponse instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'leaveTypeId': instance.leaveTypeId,
      'leaveType': instance.leaveType,
      'noOfDays': instance.noOfDays,
      'takenDays': instance.takenDays,
      'remainingLeave': instance.remainingLeave,
    };
