import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/View/Login/login_page.dart';
import 'package:hrm/View/Profile/profile_details_page.dart';
import 'package:hrm/View/Settings/privacy_page.dart';
import 'package:hrm/View/Settings/settings_page.dart';
import 'package:hrm/View/Settings/terms_and_condition_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Bloc/Profile/profile_bloc.dart';
import '../../data/Services/employee_service.dart';
import '../../data/Services/login_service.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({Key? key}) : super(key: key);

  @override
  State<ProfileMainPage> createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  final LoginService loginService = LoginService(Dio());
  final EmployeeService employeeService = EmployeeService(Dio());
  late ProfileBloc profileBloc;
  late SharedPreferences preferences;
  String phoneNo = '+9779851254170';
  String landLine = '+977015244670';

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initializePreference();
    profileBloc = ProfileBloc(loginService, employeeService);
    super.initState();
  }

  String getInitials(String personName) => personName.isNotEmpty
      ? personName
          .trim()
          .replaceAll(RegExp(' +'), ' ')
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(2)
          .join()
      : '';

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => profileBloc..add(LoadMasterDetails()),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileDetailsLoading) {
                        return const Center(
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()),
                        );
                      }
                      if (state is MasterDetailsLoaded) {
                        var name =
                            state.employeePersonalDetailsResponse?.name ??
                                "Default Profile";
                        String fullName = name.substring(
                            name.indexOf('. ') + 1, name.lastIndexOf(''));
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: AppColor.bgColor,
                                child: Text(
                                  getInitials(fullName),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                fullName,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                state.employeePersonalDetailsResponse
                                        ?.designationName ??
                                    "N/A",
                                style: const TextStyle(
                                    color: AppColor.lightText, fontSize: 12),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                state.employeePersonalDetailsResponse
                                        ?.officeName ??
                                    "N/A",
                                style: const TextStyle(
                                    color: AppColor.lightText, fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is MasterDetailsLoadFailed) {
                        return Container();
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.count(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 8,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () async {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: const Icon(
                                                Icons.phone_iphone_outlined),
                                            title:
                                                Text(localization.call_mobile),
                                            onTap: () async {
                                              await FlutterPhoneDirectCaller
                                                  .callNumber(phoneNo);
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                                Icons.phone_in_talk_rounded),
                                            title: Text(
                                                localization.call_landline),
                                            onTap: () async {
                                              await FlutterPhoneDirectCaller
                                                  .callNumber(landLine);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/img/question-mark.png',
                                          height: 25,
                                          width: 25,
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          localization.helpdesk,
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsPage(),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/img/setting.png',
                                          height: 25,
                                          width: 25,
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          localization.setting,
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () async {
                                  await preferences.remove("TOKEN");
                                  await preferences.remove("REFRESHTOKEN");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/img/logout.png',
                                          height: 25,
                                          width: 25,
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          localization.logout,
                                          style: const TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                localization.acc_info,
                                style: const TextStyle(
                                    fontSize: 14, letterSpacing: 1),
                              ),
                              leading: Image.asset(
                                'assets/img/group.png',
                                width: 25,
                                height: 25,
                              ),
                              trailing: const Icon(Icons.chevron_right_rounded),
                              enableFeedback: true,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileDetailsPage(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text(
                                localization.terms_and_condt,
                                style: const TextStyle(
                                    fontSize: 14, letterSpacing: 1),
                              ),
                              leading: Image.asset(
                                'assets/img/accept.png',
                                width: 25,
                                height: 25,
                              ),
                              trailing: const Icon(Icons.chevron_right_rounded),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsConditionPage(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text(
                                localization.privacy,
                                style: const TextStyle(
                                    fontSize: 14, letterSpacing: 1),
                              ),
                              leading: Image.asset(
                                'assets/img/shield.png',
                                width: 25,
                                height: 25,
                              ),
                              trailing: const Icon(Icons.chevron_right_rounded),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PrivacyPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
