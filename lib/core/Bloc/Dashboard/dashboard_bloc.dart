import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/Model/Response/leave_summary.dart';
import '../../../data/Model/Response/personal_attendance_details_response.dart';
import '../../../data/Services/attendance_service.dart';
import '../../../data/Services/employee_service.dart';
import '../../../data/Services/leave_service.dart';
import '../../../data/Services/login_service.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final EmployeeService employeeService;
  final LoginService loginService;
  final LeaveService leaveService;
  final AttendanceService attendanceService;

  DashboardBloc(this.employeeService, this.loginService, this.leaveService,
      this.attendanceService)
      : super(DashboardLoading()) {
    on<LoadDashboardData>((event, emit) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("TOKEN");
      //var refreshToken = preferences.getString("REFRESHTOKEN");
      var defaultFromDate = "${DateTime.now().year}/${DateTime.now().month}/1";
      var lastday =
          DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
      var defaultToDate =
          "${DateTime.now().year}/${DateTime.now().month}/$lastday";
      String todayInTime = "N/A";
      String remarks = "N/A";
      try {
        // var refreshTokenRequest =
        //     LoginResponse(token: token, refreshToken: refreshToken);
        // var refreshTokenResponse =
        //     await loginService.getRefreshToken(refreshTokenRequest);
        // if (refreshTokenResponse.token != "") {
        //   preferences.setString("TOKEN", refreshTokenResponse.token!);
        //   preferences.setString(
        //       "REFRESHTOKEN", refreshTokenResponse.refreshToken!);
        // }

        if (token != "") {
          var response =
              await employeeService.getEmployeeDetails("Bearer " + token!);
          var leaveSummaryResponse =
              await leaveService.getLeaveSummary("Bearer " + token);
          var attendanceResponse = await attendanceService.getAttendanceFull(
              "Bearer " + token, defaultFromDate, defaultToDate);
          if (response.name != "") {
            String result = response.name!.substring(
                response.name!.indexOf('. ') + 1,
                response.name!.lastIndexOf(''));
            if (response.employeeId != null) {
              preferences.setInt("EMPID", response.employeeId!);
            }
            if (attendanceResponse.isNotEmpty) {
              bool contains = false;
              for (var items in attendanceResponse) {
                contains =
                    items.daysType!.contains('Present With Missing Punch');
                if (contains == true) break;
              }
              if (contains == true) {
                todayInTime = attendanceResponse
                    .lastWhere((element) => element.daysType!
                        .contains('Present With Missing Punch'))
                    .inTime!;
                remarks = "Present";
              } else {
                todayInTime = "N/A";
                remarks = "Absent";
              }
            }
            emit(
              DashboardLoadedState(
                  result,
                  response.workShiftName!,
                  leaveSummaryResponse,
                  todayInTime,
                  remarks,
                  attendanceResponse),
            );
          } else {
            emit(const DashboardDataLoadFailed("Failed To Load Data"));
          }
        } else {
          emit(const DashboardDataLoadFailed("Failed To Load Data"));
        }
      } on DioError catch (ex) {
        emit(DashboardDataLoadFailed(ex.message.toString()));
      }
    });
  }

  // Future<LoginResponse> getRefreshToken(
  //     String token, String refreshToken, SharedPreferences preferences) async {
  //   LoginResponse refreshTokenRequest =
  //       LoginResponse(token: token, refreshToken: refreshToken);
  //   var refreshTokenResponse =
  //       await loginService.getRefreshToken(refreshTokenRequest);

  //   if (refreshTokenResponse.token != "") {
  //     preferences.setString("TOKEN", refreshTokenResponse.token!);
  //     preferences.setString("REFRESHTOKEN", refreshTokenResponse.refreshToken!);
  //   }
  //   return refreshTokenResponse;
  // }
}
