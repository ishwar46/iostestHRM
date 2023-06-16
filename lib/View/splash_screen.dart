import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/View/Home/home_page.dart';
import 'package:hrm/View/OnBoarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/Bloc/Login/login_bloc.dart';
import '../data/Services/login_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SharedPreferences preferences;
  bool? isRunning = false;
  LoginService loginService = LoginService(Dio());
  late LoginBloc _loginBloc;

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    initializePreference();
    _loginBloc = LoginBloc(loginService);
    _loginBloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Timer(
              const Duration(seconds: 3),
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            );
          }
          if (state is Unauthenticated) {
            Timer(
              const Duration(seconds: 3),
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const OnBoardingScreen(),
                  ),
                );
              },
            );
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  Center(child: Image.asset("assets/img/uranuslogo.png")),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Powered By: \nUranusTechNepal",
                      style: TextStyle(
                          fontFamily: "productSans",
                          letterSpacing: 1.2,
                          fontSize: 12,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
