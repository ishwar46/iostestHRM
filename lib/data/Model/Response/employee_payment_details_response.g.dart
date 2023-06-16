// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_payment_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeePaymentDetailsResponse _$EmployeePaymentDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeePaymentDetailsResponse(
      paymentInfoId: json['paymentInfoId'] as num?,
      employeeId: json['employeeId'] as num?,
      paNnumber: json['paNnumber'] as String?,
      pFnumber: json['pFnumber'] as String?,
      ciTnumber: json['ciTnumber'] as String?,
      employeeName: json['employeeName'] as String?,
      paymentTerm: json['paymentTerm'] as String?,
      paymentMode: json['paymentMode'] as String?,
      currencyId: json['currencyId'] as num?,
      identificationCode: json['identificationCode'] as String?,
      bankId: json['bankId'] as num?,
      bankName: json['bankName'] as String?,
      accountNo: json['accountNo'] as String?,
      branchName: json['branchName'] as String?,
      ibanNumber: json['ibanNumber'] as String?,
      agentCode: json['agentCode'] as String?,
      routingCode: json['routingCode'] as String?,
      status: json['status'] as bool?,
      createdBy: json['createdBy'] as num?,
    );

Map<String, dynamic> _$EmployeePaymentDetailsResponseToJson(
        EmployeePaymentDetailsResponse instance) =>
    <String, dynamic>{
      'paymentInfoId': instance.paymentInfoId,
      'employeeId': instance.employeeId,
      'paNnumber': instance.paNnumber,
      'pFnumber': instance.pFnumber,
      'ciTnumber': instance.ciTnumber,
      'employeeName': instance.employeeName,
      'paymentTerm': instance.paymentTerm,
      'paymentMode': instance.paymentMode,
      'currencyId': instance.currencyId,
      'identificationCode': instance.identificationCode,
      'bankId': instance.bankId,
      'bankName': instance.bankName,
      'accountNo': instance.accountNo,
      'branchName': instance.branchName,
      'ibanNumber': instance.ibanNumber,
      'agentCode': instance.agentCode,
      'routingCode': instance.routingCode,
      'status': instance.status,
      'createdBy': instance.createdBy,
    };
