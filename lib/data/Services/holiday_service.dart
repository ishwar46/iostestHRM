import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../core/Base/base_url.dart';
import '../Model/Response/holiday_details_response.dart';

part 'holiday_service.g.dart';

@RestApi(baseUrl: BaseUrl.uri)
abstract class HolidayService {
  factory HolidayService(Dio dio, {String baseUrl}) = _HolidayService;

  @GET('api/HolidayCalender/GetHolidayCalender')
  Future<List<HolidayDetailsResponse>> getHolidayDetails(
      @Header('Authorization') String token);
}
