// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_documents_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDocumentsDetailsResponse _$EmployeeDocumentsDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeDocumentsDetailsResponse(
      documentId: json['documentId'] as num?,
      employeeId: json['employeeId'] as num?,
      documentTypename: json['documentTypename'] as String?,
      documentNo: json['documentNo'] as String?,
      documentName: json['documentName'] as String?,
      issueDate: json['issueDate'] as String?,
      expiryDate: json['expiryDate'] as String?,
      placeOfIssue: json['placeOfIssue'] as String?,
      fileName: json['fileName'] as String?,
      statusId: json['statusId'] as bool?,
    );

Map<String, dynamic> _$EmployeeDocumentsDetailsResponseToJson(
        EmployeeDocumentsDetailsResponse instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'employeeId': instance.employeeId,
      'documentTypename': instance.documentTypename,
      'documentNo': instance.documentNo,
      'documentName': instance.documentName,
      'issueDate': instance.issueDate,
      'expiryDate': instance.expiryDate,
      'placeOfIssue': instance.placeOfIssue,
      'fileName': instance.fileName,
      'statusId': instance.statusId,
    };
