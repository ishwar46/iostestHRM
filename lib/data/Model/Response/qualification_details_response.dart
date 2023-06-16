import 'package:json_annotation/json_annotation.dart';
part 'qualification_details_response.g.dart';

@JsonSerializable()
class QualificationDetailsResponse {
  int? qualificationId;
  int? employeeId;
  int? qualificationTypeId;
  String? qualificationTypeName;
  String? university;
  String? specialization;
  String? description;
  int? countryId;
  String? countryName;
  int? cityId;
  String? cityName;
  String? completionDate;
  String? marks;
  int? documentAttested;
  String? attestedDetail;

  QualificationDetailsResponse(
      {this.qualificationId,
      this.employeeId,
      this.qualificationTypeId,
      this.qualificationTypeName,
      this.university,
      this.specialization,
      this.description,
      this.countryId,
      this.countryName,
      this.cityId,
      this.cityName,
      this.completionDate,
      this.marks,
      this.documentAttested,
      this.attestedDetail});

  QualificationDetailsResponse.fromJson(Map<String, dynamic> json) {
    qualificationId = json['qualificationId'];
    employeeId = json['employeeId'];
    qualificationTypeId = json['qualificationTypeId'];
    qualificationTypeName = json['qualificationTypeName'];
    university = json['university'];
    specialization = json['specialization'];
    description = json['description'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    completionDate = json['completionDate'];
    marks = json['marks'];
    documentAttested = json['documentAttested'];
    attestedDetail = json['attestedDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qualificationId'] = qualificationId;
    data['employeeId'] = employeeId;
    data['qualificationTypeId'] = qualificationTypeId;
    data['qualificationTypeName'] = qualificationTypeName;
    data['university'] = university;
    data['specialization'] = specialization;
    data['description'] = description;
    data['countryId'] = countryId;
    data['countryName'] = countryName;
    data['cityId'] = cityId;
    data['cityName'] = cityName;
    data['completionDate'] = completionDate;
    data['marks'] = marks;
    data['documentAttested'] = documentAttested;
    data['attestedDetail'] = attestedDetail;
    return data;
  }
}
