import 'package:json_annotation/json_annotation.dart';

part 'leave_application_details_response.g.dart';

@JsonSerializable()
class LeaveApplicationDetails {
  num? applicationId;
  num? employeeId;
  String? dateFrom;
  num? leaveType;
  String? subject;
  String? description;
  String? reauestDate;
  num? approvedBy;
  String? approvedDate;
  bool? isActive;
  bool? approvedStatus;
  num? recomendeTo;
  bool? halfDay;
  num? employeeeId;
  String? employeeCode;
  num? rfId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobileNumber;
  String? emailId;
  String? joinedDate;
  num? officeId;
  num? departmentId;
  num? designationId;
  num? employeeGroupId;
  num? levelId;
  num? jobTypeId;
  num? workShiftId;
  num? workShiftSecondId;
  String? profileStatus;
  bool? otApplicable;
  String? fingerPrint;
  bool? isRecomender;
  bool? isApprover;
  bool? status;
  num? punchType;
  String? profilePhoto;
  String? name;
  String? leaveSubmitDatee;
  String? leaveStatuss;
  String? dateFromBS;
  String? dateToBS;

  LeaveApplicationDetails(
      {this.applicationId,
      this.employeeId,
      this.dateFrom,
      this.leaveType,
      this.subject,
      this.description,
      this.reauestDate,
      this.approvedBy,
      this.approvedDate,
      this.isActive,
      this.approvedStatus,
      this.recomendeTo,
      this.halfDay,
      this.employeeeId,
      this.employeeCode,
      this.rfId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.mobileNumber,
      this.emailId,
      this.joinedDate,
      this.officeId,
      this.departmentId,
      this.designationId,
      this.employeeGroupId,
      this.levelId,
      this.jobTypeId,
      this.workShiftId,
      this.workShiftSecondId,
      this.profileStatus,
      this.otApplicable,
      this.fingerPrint,
      this.isRecomender,
      this.isApprover,
      this.status,
      this.punchType,
      this.profilePhoto,
      this.name,
      this.leaveSubmitDatee,
      this.leaveStatuss,
      this.dateFromBS,
      this.dateToBS});

  LeaveApplicationDetails.fromJson(Map<String, dynamic> json) {
    applicationId = json['applicationId'];
    employeeId = json['employeeId'];
    dateFrom = json['dateFrom'];
    leaveType = json['leaveType'];
    subject = json['subject'];
    description = json['description'];
    reauestDate = json['reauestDate'];
    approvedBy = json['approvedBy'];
    approvedDate = json['approvedDate'];
    isActive = json['isActive'];
    approvedStatus = json['approvedStatus'];
    recomendeTo = json['recomendeTo'];
    halfDay = json['halfDay'];
    employeeeId = json['employeeeId'];
    employeeCode = json['employeeCode'];
    rfId = json['rfId'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    emailId = json['emailId'];
    joinedDate = json['joinedDate'];
    officeId = json['officeId'];
    departmentId = json['departmentId'];
    designationId = json['designationId'];
    employeeGroupId = json['employeeGroupId'];
    levelId = json['levelId'];
    jobTypeId = json['jobTypeId'];
    workShiftId = json['workShiftId'];
    workShiftSecondId = json['workShiftSecondId'];
    profileStatus = json['profileStatus'];
    otApplicable = json['otApplicable'];
    fingerPrint = json['fingerPrint'];
    isRecomender = json['isRecomender'];
    isApprover = json['isApprover'];
    status = json['status'];
    punchType = json['punchType'];
    profilePhoto = json['profilePhoto'];
    name = json['name'];
    leaveSubmitDatee = json['leaveSubmitDatee'];
    leaveStatuss = json['leaveStatuss'];
    dateFromBS = json['dateFromBS'];
    dateToBS = json['dateToBS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['applicationId'] = applicationId;
    data['employeeId'] = employeeId;
    data['dateFrom'] = dateFrom;
    data['leaveType'] = leaveType;
    data['subject'] = subject;
    data['description'] = description;
    data['reauestDate'] = reauestDate;
    data['approvedBy'] = approvedBy;
    data['approvedDate'] = approvedDate;
    data['isActive'] = isActive;
    data['approvedStatus'] = approvedStatus;
    data['recomendeTo'] = recomendeTo;
    data['halfDay'] = halfDay;
    data['employeeeId'] = employeeeId;
    data['employeeCode'] = employeeCode;
    data['rfId'] = rfId;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['mobileNumber'] = mobileNumber;
    data['emailId'] = emailId;
    data['joinedDate'] = joinedDate;
    data['officeId'] = officeId;
    data['departmentId'] = departmentId;
    data['designationId'] = designationId;
    data['employeeGroupId'] = employeeGroupId;
    data['levelId'] = levelId;
    data['jobTypeId'] = jobTypeId;
    data['workShiftId'] = workShiftId;
    data['workShiftSecondId'] = workShiftSecondId;
    data['profileStatus'] = profileStatus;
    data['otApplicable'] = otApplicable;
    data['fingerPrint'] = fingerPrint;
    data['isRecomender'] = isRecomender;
    data['isApprover'] = isApprover;
    data['status'] = status;
    data['punchType'] = punchType;
    data['profilePhoto'] = profilePhoto;
    data['name'] = name;
    data['leaveSubmitDatee'] = leaveSubmitDatee;
    data['leaveStatuss'] = leaveStatuss;
    data['dateFromBS'] = dateFromBS;
    data['dateToBS'] = dateToBS;
    return data;
  }
}
