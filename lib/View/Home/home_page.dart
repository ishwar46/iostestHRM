import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hrm/View/Applications/applications_page.dart';
import 'package:hrm/View/Attendance/attendance_page.dart';
import 'package:hrm/View/Calendar/calendar_page.dart';
import 'package:hrm/View/Dashboard/dashboard_page.dart';
import 'package:hrm/View/Profile/profile_main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Styles/app_color.dart';
import '../Dashboard/ui/dashboard_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List _children = [
    const Dashboard(),
    const CalendarPage(),
    const ApplicationPage(),
    const AttendancePage(),
    const ProfileMainPage(),
  ];
  late SharedPreferences preferences;
  DateTime currentBackPressTime = DateTime.now();

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initializePreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return WillPopScope(
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
        body: Center(
          child: _children.elementAt(_currentIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
                child: GNav(
                  haptic: true,
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 4,
                  activeColor: AppColor.primary,
                  iconSize: 20,
                  textStyle:
                      const TextStyle(color: AppColor.primary, fontSize: 12.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      icon: Icons.home_rounded,
                      iconColor: AppColor.lightText,
                      text: localization.home,
                      textSize: 12,
                    ),
                    GButton(
                      icon: Icons.calendar_month_rounded,
                      iconColor: AppColor.lightText,
                      text: localization.calendar,
                      textSize: 12,
                    ),
                    GButton(
                      icon: Icons.access_time_rounded,
                      iconColor: AppColor.lightText,
                      text: localization.office,
                      textSize: 12,
                    ),
                    GButton(
                      icon: Icons.library_books_rounded,
                      iconColor: AppColor.lightText,
                      text: localization.reports,
                      textSize: 12,
                    ),
                    GButton(
                      icon: Icons.account_circle_rounded,
                      iconColor: AppColor.lightText,
                      text: localization.profile,
                      textSize: 12,
                    ),
                  ],
                  selectedIndex: _currentIndex,
                  onTabChange: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
