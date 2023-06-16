import 'package:json_annotation/json_annotation.dart';

part 'employee_award_details_response.g.dart';

@JsonSerializable()
class EmployeeAwardsDetailsResponse {
  int? awardId;
  int? employeeId;
  int? awardTypeId;
  String? awardTypeName;
  String? description;
  String? dateGiven;
  String? remarks;

  EmployeeAwardsDetailsResponse(
      {this.awardId,
      this.employeeId,
      this.awardTypeId,
      this.awardTypeName,
      this.description,
      this.dateGiven,
      this.remarks});

  EmployeeAwardsDetailsResponse.fromJson(Map<String, dynamic> json) {
    awardId = json['awardId'];
    employeeId = json['employeeId'];
    awardTypeId = json['awardTypeId'];
    awardTypeName = json['awardTypeName'];
    description = json['description'];
    dateGiven = json['dateGiven'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['awardId'] = awardId;
    data['employeeId'] = employeeId;
    data['awardTypeId'] = awardTypeId;
    data['awardTypeName'] = awardTypeName;
    data['description'] = description;
    data['dateGiven'] = dateGiven;
    data['remarks'] = remarks;
    return data;
  }
}
