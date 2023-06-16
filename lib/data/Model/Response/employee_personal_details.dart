import 'package:json_annotation/json_annotation.dart';

part 'employee_personal_details.g.dart';

@JsonSerializable()
class EmployeePersonalDetailsResponse {
  int? employeeId;
  String? employeeCode;
  String? name;
  String? rfid;
  String? joinedDate;
  String? mobileNumber;
  String? emailId;
  String? officeName;
  String? departmentName;
  String? designationName;
  String? employeeGroupName;
  String? levelName;
  String? jobTypeName;
  String? workShiftName;
  String? workShiftSecondName;
  String? profileStatus;
  String? otApplicableName;
  String? userGroupName;
  String? userName;
  int? status;
  String? nationalityname;
  String? religionName;
  String? motherTongueName;
  String? maritalStatusName;
  String? birthDate;
  String? anniversaryDate;
  String? bloodGroupName;
  String? height;
  String? officeExtension;
  String? roomNo;
  String? offerDate;
  String? confirmationDate;
  String? probationPeriodName;
  int? gender;
  String? countryNameP;
  String? stateNameP;
  String? zoneNameP;
  String? districtNameP;
  String? cityNameP;
  String? toleP;
  String? vdcNameP;
  String? wardNameP;
  String? buildingP;
  String? addressP;
  String? telephoneP;
  String? poBoxP;
  String? countryNameT;
  String? stateNameT;
  String? zoneNameT;
  String? districtNameT;
  String? cityNameT;
  String? toleT;
  String? vdcNameT;
  String? wardNameT;
  String? buildingT;
  String? addressT;
  String? telephoneT;
  String? poBoxT;
  String? relationNameE;
  String? nameE;
  String? mobileE;
  String? emailE;

  EmployeePersonalDetailsResponse(
      {this.employeeId,
      this.employeeCode,
      this.name,
      this.rfid,
      this.joinedDate,
      this.mobileNumber,
      this.emailId,
      this.officeName,
      this.departmentName,
      this.designationName,
      this.employeeGroupName,
      this.levelName,
      this.jobTypeName,
      this.workShiftName,
      this.workShiftSecondName,
      this.profileStatus,
      this.otApplicableName,
      this.userGroupName,
      this.userName,
      this.status,
      this.nationalityname,
      this.religionName,
      this.motherTongueName,
      this.maritalStatusName,
      this.birthDate,
      this.anniversaryDate,
      this.bloodGroupName,
      this.height,
      this.officeExtension,
      this.roomNo,
      this.offerDate,
      this.confirmationDate,
      this.probationPeriodName,
      this.gender,
      this.countryNameP,
      this.stateNameP,
      this.zoneNameP,
      this.districtNameP,
      this.cityNameP,
      this.toleP,
      this.vdcNameP,
      this.wardNameP,
      this.buildingP,
      this.addressP,
      this.telephoneP,
      this.poBoxP,
      this.countryNameT,
      this.stateNameT,
      this.zoneNameT,
      this.districtNameT,
      this.cityNameT,
      this.toleT,
      this.vdcNameT,
      this.wardNameT,
      this.buildingT,
      this.addressT,
      this.telephoneT,
      this.poBoxT,
      this.relationNameE,
      this.nameE,
      this.mobileE,
      this.emailE});

  EmployeePersonalDetailsResponse.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    employeeCode = json['employeeCode'];
    name = json['name'];
    rfid = json['rfid'];
    joinedDate = json['joinedDate'];
    mobileNumber = json['mobileNumber'];
    emailId = json['emailId'];
    officeName = json['officeName'];
    departmentName = json['departmentName'];
    designationName = json['designationName'];
    employeeGroupName = json['employeeGroupName'];
    levelName = json['levelName'];
    jobTypeName = json['jobTypeName'];
    workShiftName = json['workShiftName'];
    workShiftSecondName = json['workShiftSecondName'];
    profileStatus = json['profileStatus'];
    otApplicableName = json['otApplicableName'];
    userGroupName = json['userGroupName'];
    userName = json['userName'];
    status = json['status'];
    nationalityname = json['nationalityname'];
    religionName = json['religionName'];
    motherTongueName = json['motherTongueName'];
    maritalStatusName = json['maritalStatusName'];
    birthDate = json['birthDate'];
    anniversaryDate = json['anniversaryDate'];
    bloodGroupName = json['bloodGroupName'];
    height = json['height'];
    officeExtension = json['officeExtension'];
    roomNo = json['roomNo'];
    offerDate = json['offerDate'];
    confirmationDate = json['confirmationDate'];
    probationPeriodName = json['probationPeriodName'];
    gender = json['gender'];
    countryNameP = json['countryNameP'];
    stateNameP = json['stateNameP'];
    zoneNameP = json['zoneNameP'];
    districtNameP = json['districtNameP'];
    cityNameP = json['cityNameP'];
    toleP = json['toleP'];
    vdcNameP = json['vdcNameP'];
    wardNameP = json['wardNameP'];
    buildingP = json['buildingP'];
    addressP = json['addressP'];
    telephoneP = json['telephoneP'];
    poBoxP = json['poBoxP'];
    countryNameT = json['countryNameT'];
    stateNameT = json['stateNameT'];
    zoneNameT = json['zoneNameT'];
    districtNameT = json['districtNameT'];
    cityNameT = json['cityNameT'];
    toleT = json['toleT'];
    vdcNameT = json['vdcNameT'];
    wardNameT = json['wardNameT'];
    buildingT = json['buildingT'];
    addressT = json['addressT'];
    telephoneT = json['telephoneT'];
    poBoxT = json['poBoxT'];
    relationNameE = json['relationNameE'];
    nameE = json['nameE'];
    mobileE = json['mobileE'];
    emailE = json['emailE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeId'] = employeeId;
    data['employeeCode'] = employeeCode;
    data['name'] = name;
    data['rfid'] = rfid;
    data['joinedDate'] = joinedDate;
    data['mobileNumber'] = mobileNumber;
    data['emailId'] = emailId;
    data['officeName'] = officeName;
    data['departmentName'] = departmentName;
    data['designationName'] = designationName;
    data['employeeGroupName'] = employeeGroupName;
    data['levelName'] = levelName;
    data['jobTypeName'] = jobTypeName;
    data['workShiftName'] = workShiftName;
    data['workShiftSecondName'] = workShiftSecondName;
    data['profileStatus'] = profileStatus;
    data['otApplicableName'] = otApplicableName;
    data['userGroupName'] = userGroupName;
    data['userName'] = userName;
    data['status'] = status;
    data['nationalityname'] = nationalityname;
    data['religionName'] = religionName;
    data['motherTongueName'] = motherTongueName;
    data['maritalStatusName'] = maritalStatusName;
    data['birthDate'] = birthDate;
    data['anniversaryDate'] = anniversaryDate;
    data['bloodGroupName'] = bloodGroupName;
    data['height'] = height;
    data['officeExtension'] = officeExtension;
    data['roomNo'] = roomNo;
    data['offerDate'] = offerDate;
    data['confirmationDate'] = confirmationDate;
    data['probationPeriodName'] = probationPeriodName;
    data['gender'] = gender;
    data['countryNameP'] = countryNameP;
    data['stateNameP'] = stateNameP;
    data['zoneNameP'] = zoneNameP;
    data['districtNameP'] = districtNameP;
    data['cityNameP'] = cityNameP;
    data['toleP'] = toleP;
    data['vdcNameP'] = vdcNameP;
    data['wardNameP'] = wardNameP;
    data['buildingP'] = buildingP;
    data['addressP'] = addressP;
    data['telephoneP'] = telephoneP;
    data['poBoxP'] = poBoxP;
    data['countryNameT'] = countryNameT;
    data['stateNameT'] = stateNameT;
    data['zoneNameT'] = zoneNameT;
    data['districtNameT'] = districtNameT;
    data['cityNameT'] = cityNameT;
    data['toleT'] = toleT;
    data['vdcNameT'] = vdcNameT;
    data['wardNameT'] = wardNameT;
    data['buildingT'] = buildingT;
    data['addressT'] = addressT;
    data['telephoneT'] = telephoneT;
    data['poBoxT'] = poBoxT;
    data['relationNameE'] = relationNameE;
    data['nameE'] = nameE;
    data['mobileE'] = mobileE;
    data['emailE'] = emailE;
    return data;
  }
}
