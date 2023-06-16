import 'package:json_annotation/json_annotation.dart';

part 'experience_details_response.g.dart';

@JsonSerializable()
class ExperienceDetailsResponse {
  num? experienceId;
  num? employeeId;
  String? employerName;
  num? designationId;
  String? designationName;
  num? countryId;
  String? countryName;
  num? cityId;
  String? cityName;
  String? startDate;
  String? endDate;
  String? totalExperience;
  String? contactPerson;
  String? contactDetail;
  String? jobProfile;
  String? responsiblity;

  ExperienceDetailsResponse(
      {this.experienceId,
      this.employeeId,
      this.employerName,
      this.designationId,
      this.designationName,
      this.countryId,
      this.countryName,
      this.cityId,
      this.cityName,
      this.startDate,
      this.endDate,
      this.totalExperience,
      this.contactPerson,
      this.contactDetail,
      this.jobProfile,
      this.responsiblity});

  ExperienceDetailsResponse.fromJson(Map<String, dynamic> json) {
    experienceId = json['experienceId'];
    employeeId = json['employeeId'];
    employerName = json['employerName'];
    designationId = json['designationId'];
    designationName = json['designationName'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalExperience = json['totalExperience'];
    contactPerson = json['contactPerson'];
    contactDetail = json['contactDetail'];
    jobProfile = json['jobProfile'];
    responsiblity = json['responsiblity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['experienceId'] = experienceId;
    data['employeeId'] = employeeId;
    data['employerName'] = employerName;
    data['designationId'] = designationId;
    data['designationName'] = designationName;
    data['countryId'] = countryId;
    data['countryName'] = countryName;
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['totalExperience'] = totalExperience;
    data['contactPerson'] = contactPerson;
    data['contactDetail'] = contactDetail;
    data['jobProfile'] = jobProfile;
    data['responsiblity'] = responsiblity;
    return data;
  }
}
