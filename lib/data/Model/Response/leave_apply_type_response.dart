import 'package:json_annotation/json_annotation.dart';

part 'leave_apply_type_response.g.dart';

@JsonSerializable()
class LeaveApplyTypeResponse {
  int? id;
  String? name;

  LeaveApplyTypeResponse({this.id, this.name});

  LeaveApplyTypeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
