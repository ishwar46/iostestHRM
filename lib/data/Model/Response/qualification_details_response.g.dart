// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qualification_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualificationDetailsResponse _$QualificationDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    QualificationDetailsResponse(
      qualificationId: json['qualificationId'] as int?,
      employeeId: json['employeeId'] as int?,
      qualificationTypeId: json['qualificationTypeId'] as int?,
      qualificationTypeName: json['qualificationTypeName'] as String?,
      university: json['university'] as String?,
      specialization: json['specialization'] as String?,
      description: json['description'] as String?,
      countryId: json['countryId'] as int?,
      countryName: json['countryName'] as String?,
      cityId: json['cityId'] as int?,
      cityName: json['cityName'] as String?,
      completionDate: json['completionDate'] as String?,
      marks: json['marks'] as String?,
      documentAttested: json['documentAttested'] as int?,
      attestedDetail: json['attestedDetail'] as String?,
    );

Map<String, dynamic> _$QualificationDetailsResponseToJson(
        QualificationDetailsResponse instance) =>
    <String, dynamic>{
      'qualificationId': instance.qualificationId,
      'employeeId': instance.employeeId,
      'qualificationTypeId': instance.qualificationTypeId,
      'qualificationTypeName': instance.qualificationTypeName,
      'university': instance.university,
      'specialization': instance.specialization,
      'description': instance.description,
      'countryId': instance.countryId,
      'countryName': instance.countryName,
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'completionDate': instance.completionDate,
      'marks': instance.marks,
      'documentAttested': instance.documentAttested,
      'attestedDetail': instance.attestedDetail,
    };
