import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/Model/Request/leave_application_request.dart';
import '../../../data/Model/Response/application_request_response.dart';
import '../../../data/Model/Response/leave_application_details_response.dart';
import '../../../data/Model/Response/leave_apply_type_response.dart';
import '../../../data/Model/Response/leave_summary.dart';
import '../../../data/Services/leave_service.dart';
import '../../../data/Services/login_service.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final LoginService loginService;
  final LeaveService leaveService;
  LeaveBloc(this.loginService, this.leaveService)
      : super(LeaveDetailsLoading()) {
    on<LoadLeaveSummaryDetails>(
      (event, emit) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var token = preferences.getString("TOKEN");
       // var refreshToken = preferences.getString("REFRESHTOKEN");
        try {
          // var refreshTokenResponse =
          //     await getRefreshToken(token!, refreshToken!, preferences);
          var leaveSummaryResponse =
              await leaveService.getLeaveSummary("Bearer ${token!}");
          var leaveApplicationDetailsResponse =
              await leaveService.getLeaveApplicationDetails("Bearer $token");
          List<LeaveApplicationDetails> onlySelfLeaveApplication =
              <LeaveApplicationDetails>[];
          for (var items in leaveApplicationDetailsResponse) {
            if (items.employeeId == preferences.getInt("EMPID")) {
              onlySelfLeaveApplication.add(items);
            }
          }
          emit(LeaveDetailsLoaded(
              leaveSummaryResponse, onlySelfLeaveApplication));
        } on DioError catch (ex) {
          emit(LeaveDetailsLoadFailed(ex.response!.statusMessage.toString()));
        }
      },
    );
    on<LoadLeaveTypeandPerson>(
      (event, emit) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var token = preferences.getString("TOKEN");
        //var refreshToken = preferences.getString("REFRESHTOKEN");
        try {
          var leaveTypesResponse =
              await leaveService.getLeaveApplyTypes("Bearer ${token!}");
          var leavePersonResponse =
              await leaveService.getLeaveApplyPerson("Bearer $token");
          if (leavePersonResponse.isNotEmpty) {
            emit(LeaveTypesDetailsLoaded(
                leaveTypesResponse, leavePersonResponse));
          }
        } on DioError {
          emit(LeaveTypeLoadFailed());
        }
      },
    );
    on<LeaveRequestClick>(
      (event, emit) async {
        emit(LeaveRequestLoading());
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var token = preferences.getString("TOKEN");
       // var refreshToken = preferences.getString("REFRESHTOKEN");
        // var refreshTokenResponse =
        //     await getRefreshToken(token!, refreshToken!, preferences);
        try {
          var leaveRequestResponse =
              await leaveService.postLeaveApplicationRequest(
                  "Bearer " + token!, event._leaveApplicationRequest);
          if (leaveRequestResponse.statusCode == 200) {
            emit(LeaveRequestSuccessful(leaveRequestResponse));
          } else {
            emit(const LeaveRequestFailed("Failed to request leave"));
          }
        } on DioError catch (ex) {
          emit(LeaveRequestFailed(ex.response!.data['Message']));
        }
      },
    );
  }
  // Future<LoginResponse> getRefreshToken(
  //     String token, String refreshToken, SharedPreferences preferences) async {
  //   LoginResponse refreshTokenRequest =
  //       LoginResponse(token: token, refreshToken: refreshToken);
  //   final refreshTokenResponse =
  //       await loginService.getRefreshToken(refreshTokenRequest);

  //   if (refreshTokenResponse.token != "") {
  //     preferences.setString("TOKEN", refreshTokenResponse.token!);
  //     preferences.setString("REFRESHTOKEN", refreshTokenResponse.refreshToken!);
  //   }
  //   return refreshTokenResponse;
  // }
}
