import 'package:json_annotation/json_annotation.dart';

part 'personal_attendance_details_response.g.dart';

@JsonSerializable()
class PersonalAttendanceDetailsResponse {
  String? inDate;
  String? inTime;
  String? outTime;
  String? totalWork;
  String? daysType;
  String? inDetails;
  String? outDetails;

  PersonalAttendanceDetailsResponse(
      {this.inDate,
      this.inTime,
      this.outTime,
      this.totalWork,
      this.daysType,
      this.inDetails,
      this.outDetails});

  PersonalAttendanceDetailsResponse.fromJson(Map<String, dynamic> json) {
    inDate = json['inDate'];
    inTime = json['inTime'];
    outTime = json['outTime'];
    totalWork = json['totalWork'];
    daysType = json['daysType'];
    inDetails = json['inDetails'];
    outDetails = json['outDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inDate'] = inDate;
    data['inTime'] = inTime;
    data['outTime'] = outTime;
    data['totalWork'] = totalWork;
    data['daysType'] = daysType;
    data['inDetails'] = inDetails;
    data['outDetails'] = outDetails;
    return data;
  }
}
