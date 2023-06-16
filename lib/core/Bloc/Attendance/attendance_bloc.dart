import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/Model/Request/manual_attendance_request.dart';
import '../../../data/Model/Response/personal_attendance_details_response.dart';
import '../../../data/Services/attendance_service.dart';
import '../../../data/Services/employee_service.dart';
import '../../../data/Services/login_service.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final EmployeeService employeeService;
  final LoginService loginService;
  final AttendanceService attendanceService;

  List<TableRow> tableRows = [];
  AttendanceBloc(
      this.loginService, this.employeeService, this.attendanceService)
      : super(AttendanceLoading()) {
    on<LoadAttendanceDetail>((event, emit) async {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var token = preferences.getString("TOKEN");
        var refreshToken = preferences.getString("REFRESHTOKEN");
        // var refreshTokenResponse =
        //     await getRefreshToken(token!, refreshToken!, preferences);
        var attendanceResponse = await attendanceService.getAttendanceFull(
            "Bearer ${token!}", event.fromDate, event.toDate);
        if (attendanceResponse.isNotEmpty) {
          if (tableRows.isNotEmpty) {
            tableRows.clear();
          }
          tableRows.add(const TableRow(children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Date',
                style: TextStyle(fontFamily: 'productSansBold'),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'In Time',
                style: TextStyle(fontFamily: 'productSansBold'),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Out Time',
                  style: TextStyle(fontFamily: 'productSansBold'),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Hours',
                  style: TextStyle(fontFamily: 'productSansBold'),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Remarks',
                  style: TextStyle(fontFamily: 'productSansBold'),
                  textAlign: TextAlign.center),
            ),
          ]));
          for (var items in attendanceResponse) {
            tableRows.add(TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(items.inDate!,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(items.inTime!,
                    style: const TextStyle(fontSize: 12,color: Colors.green),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(items.outTime!,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(items.totalWork!,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center),
              ),
                Padding(
                padding:  const EdgeInsets.all(6.0),
                child: Text(items.daysType != null ? items.daysType! : "NA",
                
                    style:  TextStyle(fontSize: 12,
                    color:  items.daysType == "Absent" ? Colors.red : items.daysType == "Present"? Colors.green:Colors.black,
                    ),
                    textAlign: TextAlign.center),
              )
            ]));
          }
          emit(AttendanceDataLoaded(attendanceResponse, tableRows));
        } else {
          emit(const AttendanceDataLoadFailed("Failed to load data"));
        }
      } on DioError catch (ex) {
        emit(AttendanceDataLoadFailed(ex.response!.statusMessage!));
      }
    });
    on<ManualAttendanceClicked>(
      (event, emit) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var token = preferences.getString("TOKEN");
        var refreshToken = preferences.getString("REFRESHTOKEN");
        try {
          var manualAttendanceResposne =
              await attendanceService.postManualAttendanceRequest(
                  "Bearer ${token!}", event.manualAttendanceRequest);
          if (manualAttendanceResposne.statusCode == 200) {
            emit(ManualAttendanceRequestSuccessful());
          }
        } on DioError catch (ex) {
          print(ex);
          emit(const ManualAttendanceRequestFailed(
              "Failed to request. Please try again in a minute"));
        }
      },
    );
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
