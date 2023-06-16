import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/Model/Response/holiday_details_response.dart';
import '../../../data/Services/holiday_service.dart';
import '../../../data/Services/login_service.dart';

part 'holiday_event.dart';

part 'holiday_state.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  final HolidayService holidayService;
  final LoginService loginService;
  final _selectedDay = DateTime.now();

  HolidayBloc(this.loginService, this.holidayService)
      : super(HolidayLoading()) {
    on<LoadHolidayDetails>((event, emit) async {
      List<HolidayDetailsResponse> holList = <HolidayDetailsResponse>[];
      Map<DateTime, List<HolidayDetailsResponse>> events =
          <DateTime, List<HolidayDetailsResponse>>{};
      LinkedHashMap<DateTime, List<HolidayDetailsResponse>> kEvents =
          LinkedHashMap<DateTime, List<HolidayDetailsResponse>>();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString("TOKEN");
      var refreshToken = preferences.getString("REFRESHTOKEN");
      // var refreshTokenResponse =
      //     await getRefreshToken(token!, refreshToken!, preferences);
      try {
        holList = await holidayService.getHolidayDetails("Bearer " + token!);
        if (holList.isNotEmpty) {
          for (var item in holList) {
            final eventDate = DateTime.parse(item.dFrom!);
            events.addAll({
              eventDate: [item],
            });
          }
          kEvents.addAll(events);
          emit(
            HolidayLoaded(holList, kEvents),
          );
        } else {
          emit(HolidayLoadFailed());
        }
      } on DioError {
        emit(HolidayLoadFailed());
      }
    });
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

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
