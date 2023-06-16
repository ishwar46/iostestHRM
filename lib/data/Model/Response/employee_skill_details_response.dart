import 'package:json_annotation/json_annotation.dart';

part 'employee_skill_details_response.g.dart';

@JsonSerializable()
class EmployeeSkillDetailsResponse {
  int? skillId;
  int? employeeId;
  int? skillCategoryId;
  String? skillCategoryName;
  String? description;
  String? rating;
  String? startDate;
  String? endDate;
  String? remarks;

  EmployeeSkillDetailsResponse(
      {this.skillId,
      this.employeeId,
      this.skillCategoryId,
      this.skillCategoryName,
      this.description,
      this.rating,
      this.startDate,
      this.endDate,
      this.remarks});

  EmployeeSkillDetailsResponse.fromJson(Map<String, dynamic> json) {
    skillId = json['skillId'];
    employeeId = json['employeeId'];
    skillCategoryId = json['skillCategoryId'];
    skillCategoryName = json['skillCategoryName'];
    description = json['description'];
    rating = json['rating'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['skillId'] = skillId;
    data['employeeId'] = employeeId;
    data['skillCategoryId'] = skillCategoryId;
    data['skillCategoryName'] = skillCategoryName;
    data['description'] = description;
    data['rating'] = rating;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['remarks'] = remarks;
    return data;
  }
}
