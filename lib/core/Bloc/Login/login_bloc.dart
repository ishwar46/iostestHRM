import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/Model/Request/login_request.dart';
import '../../../data/Model/Response/login_response.dart';
import '../../../data/Services/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService;
  LoginBloc(this.loginService) : super(LoginLoadingstate()) {
    on<AppStarted>(
      (event, emit) async {
        EncryptedSharedPreferences encryptedSharedPreferences =
            EncryptedSharedPreferences();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        if (preferences.containsKey("TOKEN")) {
          try {
            var rememberUsername =
                await encryptedSharedPreferences.getString("REMEMBER_USERNAME");
            var rememberPassword =
                await encryptedSharedPreferences.getString("REMEMBER_PASSWORD");
            var companyCode = preferences.getString("COMPANYCODE");
            LoginRequest loginRequest = LoginRequest(
                userName: rememberUsername,
                password: rememberPassword,
                companyCode: companyCode);
            var response = await loginService.getToken(loginRequest);
            if (response.token != "") {
              var refreshTokenRequest = LoginResponse(
                  token: response.token, refreshToken: response.refreshToken);
              var refreshTokenResponse =
                  await loginService.getRefreshToken(refreshTokenRequest);
              if (refreshTokenResponse.token != "") {
                preferences.setString("TOKEN", refreshTokenResponse.token!);
                preferences.setString(
                    "REFRESHTOKEN", refreshTokenResponse.refreshToken!);
              }
              if (refreshTokenResponse.token != "") {
                emit(LoginSuccessState());
                emit(Authenticated());
              }
            } else {
              emit(const LoginFailedState("Username or Password Incorrect"));
              emit(Unauthenticated());
            }
          } on DioError {
            emit(Unauthenticated());
          }
        } else {
          emit(Unauthenticated());
        }
      },
    );
    on<LoginClickEvent>((event, emit) async {
      emit(LoginLoadingstate());

      EncryptedSharedPreferences encryptedSharedPreferences =
          EncryptedSharedPreferences();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      LoginRequest loginRequest = LoginRequest(
          userName: event.username,
          password: event.password,
          companyCode: event.companyCode);
      try {
        var response = await loginService.getToken(loginRequest);
        if (response.token != "") {
          var refreshTokenRequest = LoginResponse(
              token: response.token, refreshToken: response.refreshToken);
          var refreshTokenResponse =
              await loginService.getRefreshToken(refreshTokenRequest);

          if (refreshTokenResponse.token != "") {
            preferences.setString("TOKEN", refreshTokenResponse.token!);
            preferences.setString(
                "REFRESHTOKEN", refreshTokenResponse.refreshToken!);
            preferences.setBool("FINGEPRINT_ENABLED", true);
            preferences.setString("COMPANYCODE", event.companyCode);
            encryptedSharedPreferences.setString(
                'REMEMBER_USERNAME', event.username);
            encryptedSharedPreferences.setString(
                'REMEMBER_PASSWORD', event.password);
            emit(LoginSuccessState());
            emit(Authenticated());
          }
        } else {
          emit(const LoginFailedState("Username or Password Incorrect"));
          emit(Unauthenticated());
        }
      } on DioError catch (ex) {
        emit(LoginFailedState(ex.response!.data['Message']));
        emit(Unauthenticated());
      }
    });
    on<FingerPrintLogin>(
      (event, emit) async {
        EncryptedSharedPreferences encryptedSharedPreferences =
            EncryptedSharedPreferences();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        try {
          var fingerprintEnabled = preferences.getBool("FINGEPRINT_ENABLED");
          if (fingerprintEnabled == true) {
            var rememberUsername =
                await encryptedSharedPreferences.getString("REMEMBER_USERNAME");
            var rememberPassword =
                await encryptedSharedPreferences.getString("REMEMBER_PASSWORD");
            var companyCode = preferences.getString("COMPANYCODE");
            LoginRequest loginRequest = LoginRequest(
                userName: rememberUsername,
                password: rememberPassword,
                companyCode: companyCode);
            var response = await loginService.getToken(loginRequest);
            if (response.token != "") {
              var refreshTokenRequest = LoginResponse(
                  token: response.token, refreshToken: response.refreshToken);
              var refreshTokenResponse =
                  await loginService.getRefreshToken(refreshTokenRequest);
              if (refreshTokenResponse.token != "") {
                preferences.setString("TOKEN", refreshTokenResponse.token!);
                preferences.setString(
                    "REFRESHTOKEN", refreshTokenResponse.refreshToken!);
              }
              if (refreshTokenResponse.token != "") {
                emit(LoginSuccessState());
                emit(Authenticated());
              }
            } else {
              emit(const LoginFailedState("Username or Password Incorrect"));
              emit(Unauthenticated());
            }
          } else {
            emit(const LoginFailedState(
                "First time login should be using credentials"));
            emit(Unauthenticated());
          }
        } on DioError {
          emit(Unauthenticated());
        }
      },
    );
    on<LogoutClickEvent>(
      (event, emit) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove("TOKEN");
        await preferences.remove("REFRESHTOKEN");
        emit(Unauthenticated());
        emit(LoggedOutState());
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
  //     preferences.setString("TOKENFORREFRESH", refreshTokenResponse.token!);
  //     preferences.setString("REFRESHTOKEN", refreshTokenResponse.refreshToken!);
  //   }
  //   return refreshTokenResponse;
  // }
}
