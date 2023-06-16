// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AttendanceService implements AttendanceService {
  _AttendanceService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.uranustechnepal.com:505/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<PersonalAttendanceDetailsResponse>> getAttendanceFull(
    token,
    fromDate,
    toDate,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'FromDate': fromDate,
      r'ToDate': toDate,
    };
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<PersonalAttendanceDetailsResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/PersonalAttendanceReport/GetPersonalAttendanceReport',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => PersonalAttendanceDetailsResponse.fromJson(
            i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<ApplicationRequestResponse> postManualAttendanceRequest(
    token,
    manualAttendanceRequest,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(manualAttendanceRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApplicationRequestResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/ManualAttendance/RequestMannualAttendance',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApplicationRequestResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
