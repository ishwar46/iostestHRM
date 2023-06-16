import 'package:json_annotation/json_annotation.dart';

part 'employee_payment_details_response.g.dart';

@JsonSerializable()
class EmployeePaymentDetailsResponse {
  num? paymentInfoId;
  num? employeeId;
  String? paNnumber;
  String? pFnumber;
  String? ciTnumber;
  String? employeeName;
  String? paymentTerm;
  String? paymentMode;
  num? currencyId;
  String? identificationCode;
  num? bankId;
  String? bankName;
  String? accountNo;
  String? branchName;
  String? ibanNumber;
  String? agentCode;
  String? routingCode;
  bool? status;
  num? createdBy;

  EmployeePaymentDetailsResponse(
      {this.paymentInfoId,
      this.employeeId,
      this.paNnumber,
      this.pFnumber,
      this.ciTnumber,
      this.employeeName,
      this.paymentTerm,
      this.paymentMode,
      this.currencyId,
      this.identificationCode,
      this.bankId,
      this.bankName,
      this.accountNo,
      this.branchName,
      this.ibanNumber,
      this.agentCode,
      this.routingCode,
      this.status,
      this.createdBy});

  EmployeePaymentDetailsResponse.fromJson(Map<String, dynamic> json) {
    paymentInfoId = json['paymentInfoId'];
    employeeId = json['employeeId'];
    paNnumber = json['paNnumber'];
    pFnumber = json['pFnumber'];
    ciTnumber = json['ciTnumber'];
    employeeName = json['employeeName'];
    paymentTerm = json['paymentTerm'];
    paymentMode = json['paymentMode'];
    currencyId = json['currencyId'];
    identificationCode = json['identificationCode'];
    bankId = json['bankId'];
    bankName = json['bankName'];
    accountNo = json['accountNo'];
    branchName = json['branchName'];
    ibanNumber = json['ibanNumber'];
    agentCode = json['agentCode'];
    routingCode = json['routingCode'];
    status = json['status'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentInfoId'] = paymentInfoId;
    data['employeeId'] = employeeId;
    data['paNnumber'] = paNnumber;
    data['pFnumber'] = pFnumber;
    data['ciTnumber'] = ciTnumber;
    data['employeeName'] = employeeName;
    data['paymentTerm'] = paymentTerm;
    data['paymentMode'] = paymentMode;
    data['currencyId'] = currencyId;
    data['identificationCode'] = identificationCode;
    data['bankId'] = bankId;
    data['bankName'] = bankName;
    data['accountNo'] = accountNo;
    data['branchName'] = branchName;
    data['ibanNumber'] = ibanNumber;
    data['agentCode'] = agentCode;
    data['routingCode'] = routingCode;
    data['status'] = status;
    data['createdBy'] = createdBy;
    return data;
  }
}
