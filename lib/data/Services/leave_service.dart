import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../core/Base/base_url.dart';
import '../Model/Request/leave_application_request.dart';
import '../Model/Response/application_request_response.dart';
import '../Model/Response/leave_application_details_response.dart';
import '../Model/Response/leave_apply_type_response.dart';
import '../Model/Response/leave_summary.dart';

part 'leave_service.g.dart';

@RestApi(baseUrl: BaseUrl.uri)
abstract class LeaveService {
  factory LeaveService(Dio dio, {String baseUrl}) = _LeaveService;

  @GET('api/LeaveDetails/GetLeaveDetails')
  Future<List<LeaveSummaryResponse>> getLeaveSummary(
      @Header('Authorization') String token);

  @GET('api/LeaveApplication/GetLeaveApplication')
  Future<List<LeaveApplicationDetails>> getLeaveApplicationDetails(
      @Header('Authorization') String token);

  @GET('api/LeaveDetails/GetLeaveTypeIdName')
  Future<List<LeaveApplyTypeResponse>> getLeaveApplyTypes(
      @Header('Authorization') String token);

  @GET('api/LeaveDetails/GetRecomendedMembers')
  Future<List<LeaveApplyTypeResponse>> getLeaveApplyPerson(
      @Header('Authorization') String token);

  @POST('api/LeaveDetails/RequestLeaveApplication')
  Future<ApplicationRequestResponse> postLeaveApplicationRequest(
      @Header('Authorization') String token,
      @Body() LeaveApplicationRequest leaveApplicationRequest);
}
