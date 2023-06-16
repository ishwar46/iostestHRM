import 'package:json_annotation/json_annotation.dart';

part 'employee_documents_details_response.g.dart';

@JsonSerializable()
class EmployeeDocumentsDetailsResponse {
  num? documentId;
  num? employeeId;
  String? documentTypename;
  String? documentNo;
  String? documentName;
  String? issueDate;
  String? expiryDate;
  String? placeOfIssue;
  String? fileName;
  bool? statusId;

  EmployeeDocumentsDetailsResponse(
      {this.documentId,
      this.employeeId,
      this.documentTypename,
      this.documentNo,
      this.documentName,
      this.issueDate,
      this.expiryDate,
      this.placeOfIssue,
      this.fileName,
      this.statusId});

  EmployeeDocumentsDetailsResponse.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    employeeId = json['employeeId'];
    documentTypename = json['documentTypename'];
    documentNo = json['documentNo'];
    documentName = json['documentName'];
    issueDate = json['issueDate'];
    expiryDate = json['expiryDate'];
    placeOfIssue = json['placeOfIssue'];
    fileName = json['fileName'];
    statusId = json['statusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documentId'] = documentId;
    data['employeeId'] = employeeId;
    data['documentTypename'] = documentTypename;
    data['documentNo'] = documentNo;
    data['documentName'] = documentName;
    data['issueDate'] = issueDate;
    data['expiryDate'] = expiryDate;
    data['placeOfIssue'] = placeOfIssue;
    data['fileName'] = fileName;
    data['statusId'] = statusId;
    return data;
  }
}
