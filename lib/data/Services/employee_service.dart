import 'package:dio/dio.dart';
import 'package:hrm/data/Model/Response/employee_skill_details_response.dart';
import 'package:retrofit/http.dart';

import '../../core/Base/base_url.dart';
import '../Model/Response/employee_award_details_response.dart';
import '../Model/Response/employee_benefits_details_response.dart';
import '../Model/Response/employee_documents_details_response.dart';
import '../Model/Response/employee_payment_details_response.dart';
import '../Model/Response/employee_personal_details.dart';
import '../Model/Response/employee_rct_details_response.dart';
import '../Model/Response/employee_warning_details_response.dart';
import '../Model/Response/experience_details_response.dart';
import '../Model/Response/family_details_response.dart';
import '../Model/Response/qualification_details_response.dart';

part 'employee_service.g.dart';

@RestApi(baseUrl: BaseUrl.uri)
abstract class EmployeeService {
  factory EmployeeService(Dio dio, {String baseUrl}) = _EmployeeService;

  @GET('api/EmployeeSelfDetails/EmployeeDetails')
  Future<EmployeePersonalDetailsResponse> getEmployeeDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeFamilyDetails')
  Future<List<FamilyDetailsResponse>> getEmployeeFamilyDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeQualificationDetails')
  Future<List<QualificationDetailsResponse>> getEmployeeQualificatonDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeExperienceDetails')
  Future<List<ExperienceDetailsResponse>> getEmployeeExperienceDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeSkillDetails')
  Future<List<EmployeeSkillDetailsResponse>> getEmployeeSkillDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeDocumentDetails')
  Future<List<EmployeeDocumentsDetailsResponse>> getEmployeeDocumentsDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeBenifitDetails')
  Future<List<EmployeeBenefitsDetailsResponse>> getEmployeeBenefitDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeRCTDetails')
  Future<List<EmployeeRCTDetailsResponse>> getEmployeeRCTDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeAwardDetails')
  Future<List<EmployeeAwardsDetailsResponse>> getEmployeeAwardsDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeeWarningDetails')
  Future<List<EmployeeWarningDetailsResponse>> getEmployeeWarningDetails(
      @Header('Authorization') String token);

  @GET('api/EmployeeSelfDetails/EmployeePaymentDetails')
  Future<List<EmployeePaymentDetailsResponse>> getEmployeePaymentDetails(
      @Header('Authorization') String token);
}
