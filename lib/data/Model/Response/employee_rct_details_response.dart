import 'package:json_annotation/json_annotation.dart';

part 'employee_rct_details_response.g.dart';

@JsonSerializable()
class EmployeeRCTDetailsResponse {
  int? rctId;
  int? employeeId;
  int? rctTypeId;
  String? rctTypeName;
  String? topic;
  String? journalName;
  String? issn;
  String? venue;
  String? fromDate;
  String? toDate;
  String? academicYear;
  String? fundElegibility;
  String? presentedDate;
  int? presented;

  EmployeeRCTDetailsResponse(
      {this.rctId,
      this.employeeId,
      this.rctTypeId,
      this.rctTypeName,
      this.topic,
      this.journalName,
      this.issn,
      this.venue,
      this.fromDate,
      this.toDate,
      this.academicYear,
      this.fundElegibility,
      this.presentedDate,
      this.presented});

  EmployeeRCTDetailsResponse.fromJson(Map<String, dynamic> json) {
    rctId = json['rctId'];
    employeeId = json['employeeId'];
    rctTypeId = json['rctTypeId'];
    rctTypeName = json['rctTypeName'];
    topic = json['topic'];
    journalName = json['journalName'];
    issn = json['issn'];
    venue = json['venue'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    academicYear = json['academicYear'];
    fundElegibility = json['fundElegibility'];
    presentedDate = json['presentedDate'];
    presented = json['presented'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rctId'] = rctId;
    data['employeeId'] = employeeId;
    data['rctTypeId'] = rctTypeId;
    data['rctTypeName'] = rctTypeName;
    data['topic'] = topic;
    data['journalName'] = journalName;
    data['issn'] = issn;
    data['venue'] = venue;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['academicYear'] = academicYear;
    data['fundElegibility'] = fundElegibility;
    data['presentedDate'] = presentedDate;
    data['presented'] = presented;
    return data;
  }
}
