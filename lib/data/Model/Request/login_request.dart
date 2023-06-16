import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  String? userName;
  String? password;
  String? companyCode;

  LoginRequest({this.userName, this.password, this.companyCode});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    companyCode = json['companyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data['companyCode'] = companyCode;
    return data;
  }
}
