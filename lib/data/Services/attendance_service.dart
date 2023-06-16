import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../core/Base/base_url.dart';
import '../Model/Request/manual_attendance_request.dart';
import '../Model/Response/application_request_response.dart';
import '../Model/Response/personal_attendance_details_response.dart';

part 'attendance_service.g.dart';

@RestApi(baseUrl: BaseUrl.uri)
abstract class AttendanceService {
  factory AttendanceService(Dio dio, {String baseUrl}) = _AttendanceService;

  @GET('/api/PersonalAttendanceReport/GetPersonalAttendanceReport')
  Future<List<PersonalAttendanceDetailsResponse>> getAttendanceFull(
    @Header('Authorization') String token,
    @Query('FromDate') String fromDate,
    @Query('ToDate') String toDate,
  );

  @POST('api/ManualAttendance/RequestMannualAttendance')
  Future<ApplicationRequestResponse> postManualAttendanceRequest(
      @Header('Authorization') String token,
      @Body() ManualAttendanceRequest manualAttendanceRequest);
}
