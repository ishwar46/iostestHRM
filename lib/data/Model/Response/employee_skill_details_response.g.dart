// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_skill_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeSkillDetailsResponse _$EmployeeSkillDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeSkillDetailsResponse(
      skillId: json['skillId'] as int?,
      employeeId: json['employeeId'] as int?,
      skillCategoryId: json['skillCategoryId'] as int?,
      skillCategoryName: json['skillCategoryName'] as String?,
      description: json['description'] as String?,
      rating: json['rating'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$EmployeeSkillDetailsResponseToJson(
        EmployeeSkillDetailsResponse instance) =>
    <String, dynamic>{
      'skillId': instance.skillId,
      'employeeId': instance.employeeId,
      'skillCategoryId': instance.skillCategoryId,
      'skillCategoryName': instance.skillCategoryName,
      'description': instance.description,
      'rating': instance.rating,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'remarks': instance.remarks,
    };
