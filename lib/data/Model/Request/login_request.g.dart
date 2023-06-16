// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      companyCode: json['companyCode'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'companyCode': instance.companyCode,
    };
