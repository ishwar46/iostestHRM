import 'package:json_annotation/json_annotation.dart';

part 'holiday_details_response.g.dart';

@JsonSerializable()
class HolidayDetailsResponse {
  int? holydayId;
  String? holydayName;
  String? description;
  String? dateFrom;
  String? dateTo;
  bool? repeatsAnnually;
  int? holydayType;
  bool? isForFemaleOnly;
  bool? isActive;
  String? dFrom;

  HolidayDetailsResponse(
      {this.holydayId,
      this.holydayName,
      this.description,
      this.dateFrom,
      this.dateTo,
      this.repeatsAnnually,
      this.holydayType,
      this.isForFemaleOnly,
      this.isActive,
      this.dFrom});

  HolidayDetailsResponse.fromJson(Map<String, dynamic> json) {
    holydayId = json['holydayId'];
    holydayName = json['holydayName'];
    description = json['description'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    repeatsAnnually = json['repeatsAnnually'];
    holydayType = json['holydayType'];
    isForFemaleOnly = json['isForFemaleOnly'];
    isActive = json['isActive'];
    dFrom = json['dFrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['holydayId'] = holydayId;
    data['holydayName'] = holydayName;
    data['description'] = description;
    data['dateFrom'] = dateFrom;
    data['dateTo'] = dateTo;
    data['repeatsAnnually'] = repeatsAnnually;
    data['holydayType'] = holydayType;
    data['isForFemaleOnly'] = isForFemaleOnly;
    data['isActive'] = isActive;
    data['dFrom'] = dFrom;
    return data;
  }
}
