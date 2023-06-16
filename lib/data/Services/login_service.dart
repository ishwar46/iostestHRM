import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../core/Base/base_url.dart';
import '../Model/Request/login_request.dart';
import '../Model/Response/login_response.dart';

part 'login_service.g.dart';

@RestApi(baseUrl: BaseUrl.uri)
abstract class LoginService {
  factory LoginService(Dio dio, {String baseUrl}) = _LoginService;

  @POST('api/Auth/GetLoginToken')
  Future<LoginResponse> getToken(@Body() LoginRequest loginRequest);

  @POST('api/Auth/GetRefreshToken')
  Future<LoginResponse> getRefreshToken(@Body() LoginResponse loginResponse);
}
