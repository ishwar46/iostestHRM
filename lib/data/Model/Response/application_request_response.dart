import 'package:json_annotation/json_annotation.dart';

part 'application_request_response.g.dart';

@JsonSerializable()
class ApplicationRequestResponse {
  String? value;
  int? statusCode;

  ApplicationRequestResponse({this.value, this.statusCode});

  ApplicationRequestResponse.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['statusCode'] = statusCode;
    return data;
  }
}
