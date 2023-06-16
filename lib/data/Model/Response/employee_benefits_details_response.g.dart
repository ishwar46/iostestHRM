// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_benefits_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeBenefitsDetailsResponse _$EmployeeBenefitsDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeBenefitsDetailsResponse(
      benifitId: json['benifitId'] as num?,
      employeeId: json['employeeId'] as num?,
      beneficiaryId: json['beneficiaryId'] as num?,
      beneficiaryName: json['beneficiaryName'] as String?,
      benifitTypeId: json['benifitTypeId'] as num?,
      benifitTypeName: json['benifitTypeName'] as String?,
      benifitFrequencyId: json['benifitFrequencyId'] as num?,
      benifitFrequencyName: json['benifitFrequencyName'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      statusId: json['statusId'] as num?,
    );

Map<String, dynamic> _$EmployeeBenefitsDetailsResponseToJson(
        EmployeeBenefitsDetailsResponse instance) =>
    <String, dynamic>{
      'benifitId': instance.benifitId,
      'employeeId': instance.employeeId,
      'beneficiaryId': instance.beneficiaryId,
      'beneficiaryName': instance.beneficiaryName,
      'benifitTypeId': instance.benifitTypeId,
      'benifitTypeName': instance.benifitTypeName,
      'benifitFrequencyId': instance.benifitFrequencyId,
      'benifitFrequencyName': instance.benifitFrequencyName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'statusId': instance.statusId,
    };
