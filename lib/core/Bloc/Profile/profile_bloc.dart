import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/Model/Response/employee_award_details_response.dart';
import '../../../data/Model/Response/employee_benefits_details_response.dart';
import '../../../data/Model/Response/employee_documents_details_response.dart';
import '../../../data/Model/Response/employee_payment_details_response.dart';
import '../../../data/Model/Response/employee_personal_details.dart';
import '../../../data/Model/Response/employee_rct_details_response.dart';
import '../../../data/Model/Response/employee_skill_details_response.dart';
import '../../../data/Model/Response/employee_warning_details_response.dart';
import '../../../data/Model/Response/experience_details_response.dart';
import '../../../data/Model/Response/family_details_response.dart';
import '../../../data/Model/Response/login_response.dart';
import '../../../data/Model/Response/qualification_details_response.dart';
import '../../../data/Services/employee_service.dart';
import '../../../data/Services/login_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late LoginService loginService;
  late EmployeeService employeeService;
  ProfileBloc(this.loginService, this.employeeService)
      : super(ProfileDetailsLoading()) {
    on<LoadMasterDetails>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("TOKEN");
      //var refreshToken = preferences.getString("REFRESHTOKEN");
      try {
        // var refreshTokenResponse =
        //     await getRefreshToken(token!, refreshToken!, preferences);
        var response =
            await employeeService.getEmployeeDetails("Bearer ${token!}");
        var familyResponse =
            await employeeService.getEmployeeFamilyDetails("Bearer $token");
        var qualificationResponse = await employeeService
            .getEmployeeQualificatonDetails("Bearer $token");
        var experienceResponse = await employeeService
            .getEmployeeExperienceDetails("Bearer $token");
        var skillsResponse =
            await employeeService.getEmployeeSkillDetails("Bearer $token");
        var documentsResponse = await employeeService
            .getEmployeeDocumentsDetails("Bearer $token");
        var benefitsResponse =
            await employeeService.getEmployeeBenefitDetails("Bearer $token");
        var rctResponse =
            await employeeService.getEmployeeRCTDetails("Bearer $token");
        var awardResponse =
            await employeeService.getEmployeeAwardsDetails("Bearer $token");
        var warningResponse =
            await employeeService.getEmployeeWarningDetails("Bearer $token");
        var paymentResponse =
            await employeeService.getEmployeePaymentDetails("Bearer $token");
        if (response.name != "") {
          emit(
            MasterDetailsLoaded(
                response,
                familyResponse,
                qualificationResponse,
                experienceResponse,
                skillsResponse,
                documentsResponse,
                benefitsResponse,
                rctResponse,
                awardResponse,
                warningResponse,
                paymentResponse),
          );
        } else {
          emit(const MasterDetailsLoadFailed("Failed To Load Data"));
        }
      } on DioError catch (ex) {
        emit(MasterDetailsLoadFailed(ex.message.toString()));
      }
    });
  }

  Future<LoginResponse> getRefreshToken(
      String token, String refreshToken, SharedPreferences preferences) async {
    LoginResponse refreshTokenRequest =
        LoginResponse(token: token, refreshToken: refreshToken);
    final refreshTokenResponse =
        await loginService.getRefreshToken(refreshTokenRequest);

    if (refreshTokenResponse.token != "") {
      preferences.setString("TOKEN", refreshTokenResponse.token!);
      preferences.setString("REFRESHTOKEN", refreshTokenResponse.refreshToken!);
    }
    return refreshTokenResponse;
  }
}
