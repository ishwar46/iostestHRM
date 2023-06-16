// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceDetailsResponse _$ExperienceDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ExperienceDetailsResponse(
      experienceId: json['experienceId'] as num?,
      employeeId: json['employeeId'] as num?,
      employerName: json['employerName'] as String?,
      designationId: json['designationId'] as num?,
      designationName: json['designationName'] as String?,
      countryId: json['countryId'] as num?,
      countryName: json['countryName'] as String?,
      cityId: json['cityId'] as num?,
      cityName: json['cityName'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      totalExperience: json['totalExperience'] as String?,
      contactPerson: json['contactPerson'] as String?,
      contactDetail: json['contactDetail'] as String?,
      jobProfile: json['jobProfile'] as String?,
      responsiblity: json['responsiblity'] as String?,
    );

Map<String, dynamic> _$ExperienceDetailsResponseToJson(
        ExperienceDetailsResponse instance) =>
    <String, dynamic>{
      'experienceId': instance.experienceId,
      'employeeId': instance.employeeId,
      'employerName': instance.employerName,
      'designationId': instance.designationId,
      'designationName': instance.designationName,
      'countryId': instance.countryId,
      'countryName': instance.countryName,
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'totalExperience': instance.totalExperience,
      'contactPerson': instance.contactPerson,
      'contactDetail': instance.contactDetail,
      'jobProfile': instance.jobProfile,
      'responsiblity': instance.responsiblity,
    };
