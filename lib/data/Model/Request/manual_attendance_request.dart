import 'package:json_annotation/json_annotation.dart';

part 'manual_attendance_request.g.dart';

@JsonSerializable()
class ManualAttendanceRequest {
  int? employeeId;
  String? attendanceDate;
  String? attendanceTime;
  String? reason;
 // int? reccomentTo;
  String? location;
  String? file;

  ManualAttendanceRequest(
      {this.employeeId,
      this.attendanceDate,
      this.attendanceTime,
      this.reason,
  //    this.reccomentTo,
      this.location,
      this.file});

  ManualAttendanceRequest.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    attendanceDate = json['attendanceDate'];
    attendanceTime = json['attendanceTime'];
    reason = json['reason'];
   // reccomentTo = json['reccomentTo'];
    location = json['location'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeId'] = employeeId;
    data['attendanceDate'] = attendanceDate;
    data['attendanceTime'] = attendanceTime;
    data['reason'] = reason;
   // data['reccomentTo'] = reccomentTo;
    data['location'] = location;
    data['file'] = file;
    return data;
  }
}
