import 'package:json_annotation/json_annotation.dart';
part 'employee_benefits_details_response.g.dart';

@JsonSerializable()
class EmployeeBenefitsDetailsResponse {
  num? benifitId;
  num? employeeId;
  num? beneficiaryId;
  String? beneficiaryName;
  num? benifitTypeId;
  String? benifitTypeName;
  num? benifitFrequencyId;
  String? benifitFrequencyName;
  String? startDate;
  String? endDate;
  num? statusId;

  EmployeeBenefitsDetailsResponse(
      {this.benifitId,
      this.employeeId,
      this.beneficiaryId,
      this.beneficiaryName,
      this.benifitTypeId,
      this.benifitTypeName,
      this.benifitFrequencyId,
      this.benifitFrequencyName,
      this.startDate,
      this.endDate,
      this.statusId});

  EmployeeBenefitsDetailsResponse.fromJson(Map<String, dynamic> json) {
    benifitId = json['benifitId'];
    employeeId = json['employeeId'];
    beneficiaryId = json['beneficiaryId'];
    beneficiaryName = json['beneficiaryName'];
    benifitTypeId = json['benifitTypeId'];
    benifitTypeName = json['benifitTypeName'];
    benifitFrequencyId = json['benifitFrequencyId'];
    benifitFrequencyName = json['benifitFrequencyName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    statusId = json['statusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['benifitId'] = benifitId;
    data['employeeId'] = employeeId;
    data['beneficiaryId'] = beneficiaryId;
    data['beneficiaryName'] = beneficiaryName;
    data['benifitTypeId'] = benifitTypeId;
    data['benifitTypeName'] = benifitTypeName;
    data['benifitFrequencyId'] = benifitFrequencyId;
    data['benifitFrequencyName'] = benifitFrequencyName;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['statusId'] = statusId;
    return data;
  }
}
