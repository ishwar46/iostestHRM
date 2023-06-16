import 'package:json_annotation/json_annotation.dart';

part 'leave_summary.g.dart';

@JsonSerializable()
class LeaveSummaryResponse {
  num? employeeId;
  num? leaveTypeId;
  String? leaveType;
  String? noOfDays;
  String? takenDays;
  String? remainingLeave;

  LeaveSummaryResponse(
      {this.employeeId,
      this.leaveTypeId,
      this.leaveType,
      this.noOfDays,
      this.takenDays,
      this.remainingLeave});

  LeaveSummaryResponse.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    leaveTypeId = json['leaveTypeId'];
    leaveType = json['leaveType'];
    noOfDays = json['noOfDays'];
    takenDays = json['takenDays'];
    remainingLeave = json['remainingLeave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeId'] = employeeId;
    data['leaveTypeId'] = leaveTypeId;
    data['leaveType'] = leaveType;
    data['noOfDays'] = noOfDays;
    data['takenDays'] = takenDays;
    data['remainingLeave'] = remainingLeave;
    return data;
  }
}
