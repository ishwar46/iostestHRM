import 'package:json_annotation/json_annotation.dart';

part 'leave_application_request.g.dart';

@JsonSerializable()
class LeaveApplicationRequest {
  int? employeeId;
  int? recomendTo;
  int? leaveTypeId;
  String? subject;
  String? leaveSubmitDate;
  String? requestDate;
  String? fromdate;
  String? toDate;
  String? discription;
  bool? halfDay;
  bool? isActive;
  String? file;

  LeaveApplicationRequest(
      {this.employeeId,
      this.recomendTo,
      this.leaveTypeId,
      this.subject,
      this.leaveSubmitDate,
      this.requestDate,
      this.fromdate,
      this.toDate,
      this.discription,
      this.halfDay,
      this.isActive,
      this.file});

  LeaveApplicationRequest.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    recomendTo = json['recomendTo'];
    leaveTypeId = json['leaveTypeId'];
    subject = json['subject'];
    leaveSubmitDate = json['leaveSubmitDate'];
    requestDate = json['requestDate'];
    fromdate = json['fromdate'];
    toDate = json['toDate'];
    discription = json['discription'];
    halfDay = json['halfDay'];
    isActive = json['isActive'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['employeeId'] = employeeId;
    data['recomendTo'] = recomendTo;
    data['leaveTypeId'] = leaveTypeId;
    data['subject'] = subject;
    data['leaveSubmitDate'] = leaveSubmitDate;
    data['requestDate'] = requestDate;
    data['fromdate'] = fromdate;
    data['toDate'] = toDate;
    data['discription'] = discription;
    data['halfDay'] = halfDay;
    data['isActive'] = isActive;
    data['file'] = file;
    return data;
  }
}
