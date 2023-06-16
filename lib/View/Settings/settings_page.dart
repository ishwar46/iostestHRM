import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Base/app_language.dart';
import '../../core/Base/app_locale.dart';
import '../../core/Base/authentication.dart';
import '../../core/Base/shared_prefs.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences preferences;
  bool? fingerEnrolled = false;
  bool? isEnglish = false;
  var _appLocale;
  late String currentDefaultSystemLocale;
  int selectedLangIndex = 0;
  Locale? _currentLocale;
  AppLanguage? dropdownValue;
  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool? hasBiometrics = false;
  bool? fingerprintEnabled = false;

  Future<void> initializePreferences() async {
    preferences = await SharedPreferences.getInstance();
    fingerEnrolled = preferences.getBool("FINGERPRINTENROLLED");
    isEnglish = preferences.getBool("SELECTEDLANGUAGE");
    _currentLocale = await getLocale();
    hasBiometrics = await localAuthentication.canCheckBiometrics;
  }

  @override
  void initState() {
    initializePreferences().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocale = Provider.of<AppLocale>(context);
    getLocale().then((locale) {
      _appLocale.changeLocale(Locale(locale.languageCode));
      dropdownValue = AppLanguage.languages()
          .firstWhere((element) => element.languageCode == locale.languageCode);
      _setFlag();
    });
  }

  void _setFlag() {
    currentDefaultSystemLocale = _appLocale.locale.languageCode.split('_')[0];
    setState(() {
      selectedLangIndex = _getLangIndex(currentDefaultSystemLocale);
    });
  }

  int _getLangIndex(String currentDefaultSystemLocale) {
    int langIndex = 0;
    switch (currentDefaultSystemLocale) {
      case 'en':
        langIndex = 0;
        break;
      case 'ne':
        langIndex = 1;
        break;
    }
    return langIndex;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    bool SStatus = fingerEnrolled == true ? true : false;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.primary,
        elevation: 0.0,
        title: Text(
          localization.setting,
          style: const TextStyle(
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
        toolbarHeight: 40,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.zero,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localization.customize,
                    style: const TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListTile(
                  title: Text(
                    localization.theme,
                    style: const TextStyle(fontSize: 14, letterSpacing: 1),
                  ),
                  subtitle: Text(
                    EasyDynamicTheme.of(context).themeMode.toString().substring(
                        EasyDynamicTheme.of(context)
                                .themeMode
                                .toString()
                                .indexOf('.') +
                            1,
                        EasyDynamicTheme.of(context)
                            .themeMode
                            .toString()
                            .lastIndexOf('')),
                    style: const TextStyle(
                        color: AppColor.lightText, fontSize: 12),
                  ),
                  leading: const Icon(
                    Icons.color_lens_outlined,
                    color: AppColor.primary,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  enableFeedback: true,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.light_mode_rounded),
                                title: Text(localization.light),
                                onTap: () async {
                                  EasyDynamicTheme.of(context)
                                      .changeTheme(dark: false);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.dark_mode_rounded),
                                title: Text(localization.dark),
                                onTap: () async {
                                  EasyDynamicTheme.of(context)
                                      .changeTheme(dark: true);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.dark_mode_rounded),
                                title: Text(localization.system_theme),
                                onTap: () async {
                                  EasyDynamicTheme.of(context)
                                      .changeTheme(dynamic: true);
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
                ListTile(
                  title: Text(
                    localization.language,
                    style: const TextStyle(fontSize: 14, letterSpacing: 1),
                  ),
                  subtitle: Text(
                    dropdownValue?.languageCode ?? "EN",
                    style: const TextStyle(
                        color: AppColor.lightText, fontSize: 12),
                  ),
                  leading: const Icon(
                    Icons.language_outlined,
                    color: AppColor.primary,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  enableFeedback: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Image.asset(
                                'assets/img/english.jpg',
                                height: 40,
                                width: 40,
                              ),
                              title: const Text("EN"),
                              onTap: () async {
                                _appLocale.changeLocale(const Locale('en'));
                                _setFlag();
                                preferences.setBool("SELECTEDLANGUAGE", false);
                                setLocale('en');
                                Navigator.pop(context);
                                setState(() {
                                  isEnglish = true;
                                });
                              },
                            ),
                            ListTile(
                              leading: Image.asset(
                                'assets/img/nepal.jpg',
                                height: 30,
                                width: 30,
                              ),
                              title: const Text('NP'),
                              onTap: () async {
                                _appLocale.changeLocale(const Locale('ne'));
                                _setFlag();
                                preferences.setBool("SELECTEDLANGUAGE", true);
                                setLocale('ne');
                                Navigator.pop(context);
                                setState(() {
                                  isEnglish = false;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const Divider(
                  color: AppColor.titleText,
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    localization.account_settings,
                    style: const TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        localization.fingerprint_login,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'productSans',
                            letterSpacing: 1.3),
                      ),
                      FlutterSwitch(
                        width: 55.0,
                        height: 25.0,
                        valueFontSize: 25.0,
                        toggleSize: 25.0,
                        value: SStatus,
                        activeColor: Colors.green.shade300,
                        onToggle: (val) async {
                          try {
                            //check if there is authencations,
                            if (hasBiometrics!) {
                              List<BiometricType> availableBiometrics =
                                  await localAuthentication
                                      .getAvailableBiometrics();
                              if (availableBiometrics.isEmpty) {
                                EasyLoading.showError(
                                    "Fingerprint Sercurity not added in your device. Please add fingerprint lock to use this feature.");
                                return;
                              }
                              if (Platform.isIOS) {
                                if (availableBiometrics
                                        .contains(BiometricType.face) ||
                                    availableBiometrics
                                        .contains(BiometricType.strong) ||
                                    availableBiometrics
                                        .contains(BiometricType.weak)) {
                                  bool isAuthenticated = await Authentication
                                      .authenticateWithBiometrics();

                                  if (isAuthenticated) {
                                    setState(() {
                                      fingerEnrolled = val;
                                      if (val == true) {
                                        preferences.setBool(
                                            "FINGERPRINTENROLLED", true);
                                      } else {
                                        preferences.setBool(
                                            "FINGERPRINTENROLLED", false);
                                      }
                                    });
                                  }
                                }
                              } else {
                                if (availableBiometrics
                                        .contains(BiometricType.fingerprint) ||
                                    availableBiometrics
                                        .contains(BiometricType.strong) ||
                                    availableBiometrics
                                        .contains(BiometricType.weak)) {
                                  bool isAuthenticated = await Authentication
                                      .authenticateWithBiometrics();
                                  if (isAuthenticated) {
                                    setState(() {
                                      fingerEnrolled = val;
                                      if (val == true) {
                                        preferences.setBool(
                                            "FINGERPRINTENROLLED", true);
                                      } else {
                                        preferences.setBool(
                                            "FINGERPRINTENROLLED", false);
                                      }
                                    });
                                  }
                                }
                              }
                            }
                          } catch (ex) {
                            EasyLoading.showError(ex.toString());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
