// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyDetailsResponse _$FamilyDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    FamilyDetailsResponse(
      familyId: json['familyId'] as num?,
      employeeId: json['employeeId'] as num?,
      relationId: json['relationId'] as num?,
      relationName: json['relationName'] as String?,
      name: json['name'] as String?,
      telephone: json['telephone'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      birthDate: json['birthDate'] as String?,
    );

Map<String, dynamic> _$FamilyDetailsResponseToJson(
        FamilyDetailsResponse instance) =>
    <String, dynamic>{
      'familyId': instance.familyId,
      'employeeId': instance.employeeId,
      'relationId': instance.relationId,
      'relationName': instance.relationName,
      'name': instance.name,
      'telephone': instance.telephone,
      'mobile': instance.mobile,
      'email': instance.email,
      'birthDate': instance.birthDate,
    };
