import 'package:json_annotation/json_annotation.dart';

part 'employee_warning_details_response.g.dart';

@JsonSerializable()
class EmployeeWarningDetailsResponse {
  int? warningId;
  int? employeeId;
  int? warningTypeId;
  String? warningTypeName;
  String? description;
  String? dateGiven;
  String? remarks;

  EmployeeWarningDetailsResponse(
      {this.warningId,
      this.employeeId,
      this.warningTypeId,
      this.warningTypeName,
      this.description,
      this.dateGiven,
      this.remarks});

  EmployeeWarningDetailsResponse.fromJson(Map<String, dynamic> json) {
    warningId = json['warningId'];
    employeeId = json['employeeId'];
    warningTypeId = json['warningTypeId'];
    warningTypeName = json['warningTypeName'];
    description = json['description'];
    dateGiven = json['dateGiven'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['warningId'] = warningId;
    data['employeeId'] = employeeId;
    data['warningTypeId'] = warningTypeId;
    data['warningTypeName'] = warningTypeName;
    data['description'] = description;
    data['dateGiven'] = dateGiven;
    data['remarks'] = remarks;
    return data;
  }
}
