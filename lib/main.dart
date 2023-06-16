import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hrm/View/splash_screen.dart';
import 'package:hrm/core/Bloc/Profile/profile_bloc.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/core/Styles/themes.dart';
import 'package:hrm/View/Login/login_page.dart';
import 'package:hrm/data/Services/employee_service.dart';
import 'package:hrm/data/Services/login_service.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/Base/app_locale.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColor.primary));
  await Firebase.initializeApp();
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    FirebaseCrashlytics.instance.app.setAutomaticDataCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  runApp(
    EasyDynamicThemeWidget(child: const MyApp()),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.black38
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.black
    ..maskColor = Colors.transparent
    ..indicatorColor = AppColor.primary
    ..textStyle = const TextStyle(
      color: Colors.white,
    )
    ..userInteractions = false
    ..fontSize = 12
    ..indicatorSize = 30.0
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> gloablNavigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    //initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(minutes: 15),
        invalidateSessionForUserInactivity: const Duration(minutes: 30));
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout
        EasyLoading.showToast(
          "Session timed out. Please Login again to continue.",
          dismissOnTap: true,
          duration: const Duration(seconds: 9999),
        );
        Navigator.push(
            gloablNavigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        EasyLoading.showToast(
          "Session timed out. Please Login again to continue.",
          dismissOnTap: true,
          duration: const Duration(seconds: 9999),
        );
        Navigator.push(
            gloablNavigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
      }
    });
    final LoginService loginService = LoginService(Dio());
    final EmployeeService employeeService = EmployeeService(Dio());
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(loginService, employeeService))
      ],
      child: ChangeNotifierProvider(
        create: (context) => AppLocale(),
        child: Consumer<AppLocale>(builder: (context, locale, child) {
          return SessionTimeoutManager(
            sessionConfig: sessionConfig,
            child: GetMaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale.locale,
              navigatorKey: gloablNavigatorKey,
              title: 'HRM',
              debugShowCheckedModeBanner: false,
              theme: lightThemeData,
              darkTheme: darkThemeData,
              themeMode: EasyDynamicTheme.of(context).themeMode!,
              home: const SplashScreen(),
              builder: EasyLoading.init(),
            ),
          );
        }),
      ),
    );
  }
}
