import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/View/Home/home_page.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Base/authentication.dart';
import '../../core/Base/connectivity.dart';
import '../../core/Bloc/Login/login_bloc.dart';
import '../../data/Services/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();
  late SharedPreferences preferences;
  LoginService loginService = LoginService(Dio());
  late LoginBloc _loginBloc;
  final MyConnectivity _connectivity = MyConnectivity.instance;
  Map _source = {ConnectivityResult.none: false};
  String? ConnectionType = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  AppUpdateInfo? _updateInfo;
  String? versionName;
  bool? rememberMe = false;
  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool? hasBiometrics = false;
  bool? fingerprintEnabled = false;
  DateTime currentBackPressTime = DateTime.now();
  var jsonDecoded;
  bool _passwordVisible = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/companycode.json');
    jsonDecoded = await json.decode(response);
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(
        () {
          _updateInfo = info;
          if (info.updateAvailability == UpdateAvailability.updateAvailable) {
            try {
              setState(() {
                InAppUpdate.performImmediateUpdate();
              });
            } catch (ex) {
              print(ex);
            }
          }
        },
      );
    }).catchError((ex, s) async {
      print(ex);
    });
  }

  Future<void> initializePreference() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName = packageInfo.version;
    preferences = await SharedPreferences.getInstance();
    fingerprintEnabled = preferences.getBool("FINGERPRINTENROLLED");
    if (fingerprintEnabled == null) {
      fingerprintEnabled == false;
    }
    if (preferences.containsKey("REMEMBER_ME")) {
      rememberMe = preferences.getBool("REMEMBER_ME");
      if (rememberMe == true) {
        usernameController.text =
            await encryptedSharedPreferences.getString("REMEMBER_USERNAME");
      }
    }
    await checkForUpdate();
    hasBiometrics = await localAuthentication.canCheckBiometrics;
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Exit App",
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
            content: Text(
              "Are you sure you want to exit ?",
              style: GoogleFonts.montserrat(fontSize: 12),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No", style: GoogleFonts.montserrat(fontSize: 12)),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text("Yes", style: GoogleFonts.montserrat(fontSize: 12)),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _onRememberMeChanged(bool newValue) async {
    if (rememberMe != null) {
      rememberMe = newValue;
      if (rememberMe == true) {
        if (usernameController.text != "" &&
            passwordController.text.isNotEmpty) {
          preferences.setBool("REMEMBER_ME", true);
        }
      } else {
        await preferences.setBool('REMEMBER_ME', false);
      }
    }
    //setState(() {});
  }

  @override
  void initState() {
    readJson();
    initializePreference();
    _loginBloc = LoginBloc(loginService);
    //_loginBloc.add(AppStarted());
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
        switch (_source.keys.toList()[0]) {
          case ConnectivityResult.mobile:
            ConnectionType = 'Online';
            break;
          case ConnectivityResult.wifi:
            ConnectionType = 'Online';
            break;
          case ConnectivityResult.none:
          default:
            ConnectionType = 'Offline';
            EasyLoading.showError("No Internet connection available",
                dismissOnTap: true, duration: const Duration(seconds: 30));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            EasyLoading.dismiss();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const LoginPage();
                },
              ),
            );
          }
          if (state is LoginLoadingstate) {
            setState(
              () {
                const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          if (state is LoginSuccessState) {
            EasyLoading.dismiss();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ),
            );
          }
          if (state is LoginFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColor.primary,
                padding: const EdgeInsets.all(20),
              ),
            );
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            final timegap = DateTime.now().difference(currentBackPressTime);
            final cantExit = timegap >= const Duration(seconds: 2);
            currentBackPressTime = DateTime.now();
            if (cantExit) {
              //show snackbar
              var snack = SnackBar(
                content: Text(
                  localization.press_back_to_exit,
                  style: const TextStyle(
                    letterSpacing: 1.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return false;
            } else {
              await SystemNavigator.pop();
              return false;
            }
          },
          child: Scaffold(
            backgroundColor: AppColor.background,
            key: _scaffoldKey,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Image.asset(
                          "assets/img/uranuslogo.png",
                          repeat: ImageRepeat.noRepeat,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "LOGIN",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  letterSpacing: 1.5,
                                  color: AppColor.primary),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Login Message
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Please Login to Continue",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  letterSpacing: 1.5,
                                  color: AppColor.primary),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Image.asset("assets/img/bg.png"),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(color: AppColor.bgText),
                                showCursor: false,
                                controller: usernameController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.primary,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.primary),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  label: Text(
                                    localization.username,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        letterSpacing: 1.5,
                                        color: AppColor.bgText),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.account_circle_outlined,
                                    size: 20,
                                    color: AppColor.bgText,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return localization.username_required;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle(color: AppColor.bgText),
                                showCursor: false,
                                controller: passwordController,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColor.primary),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColor.primary),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    label: Text(
                                      localization.password,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          letterSpacing: 1.5,
                                          color: AppColor.bgText),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock_open_outlined,
                                      size: 20,
                                      color: AppColor.bgText,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 15,
                                        color: AppColor.bgText,
                                      ),
                                    )),
                                validator: (value) {
                                  if (value == "") {
                                    return localization
                                        .password_cannot_be_empty;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              Checkbox(
                                side: const BorderSide(color: AppColor.bgText),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                overlayColor: MaterialStateProperty.all<Color>(
                                    AppColor.bgText),
                                checkColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                activeColor: AppColor.primary,
                                value: rememberMe,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberMe = value;
                                  });
                                  _onRememberMeChanged(value!);
                                },
                              ),
                              Text(
                                localization.remember_me,
                                style: const TextStyle(
                                    fontSize: 13.0, color: AppColor.bgText),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: fingerprintEnabled ?? false,
                          child: Visibility(
                            visible: hasBiometrics ?? false,
                            child: InkWell(
                              onTap: () async {
                                try {
                                  //check if there is authencations,
                                  if (hasBiometrics!) {
                                    List<BiometricType> availableBiometrics =
                                        await localAuthentication
                                            .getAvailableBiometrics();
                                    if (Platform.isIOS) {
                                      if (availableBiometrics
                                              .contains(BiometricType.face) ||
                                          availableBiometrics
                                              .contains(BiometricType.strong) ||
                                          availableBiometrics
                                              .contains(BiometricType.weak)) {
                                        bool isAuthenticated =
                                            await Authentication
                                                .authenticateWithBiometrics();

                                        if (isAuthenticated) {
                                          EasyLoading.show(
                                              status: localization.logging_in);
                                          _loginBloc.add(FingerPrintLogin());
                                        }
                                      }
                                    } else {
                                      if (availableBiometrics.contains(
                                              BiometricType.fingerprint) ||
                                          availableBiometrics
                                              .contains(BiometricType.strong) ||
                                          availableBiometrics
                                              .contains(BiometricType.weak)) {
                                        bool isAuthenticated =
                                            await Authentication
                                                .authenticateWithBiometrics();
                                        if (isAuthenticated) {
                                          EasyLoading.show(
                                              status: localization.logging_in);
                                          _loginBloc.add(FingerPrintLogin());
                                        }
                                      }
                                    }
                                  }
                                } catch (ex) {
                                  EasyLoading.showError(ex.toString());
                                  print(ex);
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.fingerprint_outlined,
                                    ),
                                    Text(
                                      localization.login_with_fingerprint,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.primary),
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size(330, 30)),
                          ),
                          child: Text(
                            localization.login.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                letterSpacing: 1.3, color: AppColor.whiteText),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            EasyLoading.show(status: localization.logging_in);
                            _loginBloc.add(
                              LoginClickEvent(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  companyCode: jsonDecoded[0]['companyCode']),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "© ${DateTime.now().year} Uranus HRM",
                                style: const TextStyle(
                                    color: AppColor.lightText, fontSize: 12),
                              ),
                              Text(
                                "Version $versionName",
                                style: const TextStyle(
                                    color: AppColor.lightText, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
