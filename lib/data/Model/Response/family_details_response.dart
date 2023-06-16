import 'package:json_annotation/json_annotation.dart';

part 'family_details_response.g.dart';

@JsonSerializable()
class FamilyDetailsResponse {
  num? familyId;
  num? employeeId;
  num? relationId;
  String? relationName;
  String? name;
  String? telephone;
  String? mobile;
  String? email;
  String? birthDate;

  FamilyDetailsResponse(
      {this.familyId,
      this.employeeId,
      this.relationId,
      this.relationName,
      this.name,
      this.telephone,
      this.mobile,
      this.email,
      this.birthDate});

  FamilyDetailsResponse.fromJson(Map<String, dynamic> json) {
    familyId = json['familyId'];
    employeeId = json['employeeId'];
    relationId = json['relationId'];
    relationName = json['relationName'];
    name = json['name'];
    telephone = json['telephone'];
    mobile = json['mobile'];
    email = json['email'];
    birthDate = json['birthDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['familyId'] = familyId;
    data['employeeId'] = employeeId;
    data['relationId'] = relationId;
    data['relationName'] = relationName;
    data['name'] = name;
    data['telephone'] = telephone;
    data['mobile'] = mobile;
    data['email'] = email;
    data['birthDate'] = birthDate;
    return data;
  }
}
