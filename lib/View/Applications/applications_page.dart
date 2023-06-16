import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/View/Attendance/manual_attendance_page.dart';
import 'package:hrm/View/Leave/leave_application.page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Home/home_page.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => ApplicationPageState();
}

class ApplicationPageState extends State<ApplicationPage> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.primary,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: Text(
          localization.applications,
          style: const TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
    );
  }
}

class _listOfMenu extends StatelessWidget {
  const _listOfMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(
              localization.applications,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const _leaveApplication(),
          const _manualAttendance(),
          ListTile(
            title: Text(
              localization.office_visit,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'productSans',
                  letterSpacing: 1.3),
            ),
            leading: Image.asset(
              'assets/img/office.png',
              width: 20,
              height: 20,
            ),
            trailing: const Icon(Icons.navigate_next_rounded),
            onTap: () {
              EasyLoading.showToast(
                localization.feature_not_available,
                dismissOnTap: true,
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/img/punch.png',
              width: 20,
              height: 20,
            ),
            title: Text(
              localization.late_early_request,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'productSans',
                  letterSpacing: 1.3),
            ),
            trailing: const Icon(Icons.navigate_next_rounded),
            onTap: () {
              EasyLoading.showToast(
                localization.feature_not_available,
                dismissOnTap: true,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _manualAttendance extends StatelessWidget {
  const _manualAttendance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return ListTile(
      leading: Image.asset(
        'assets/img/finger.png',
        width: 20,
        height: 20,
      ),
      title: Text(
        localization.punch_request,
        style: const TextStyle(
            fontSize: 14.0, fontFamily: 'productSans', letterSpacing: 1.3),
      ),
      //leading: Icon(Icons.password_rounded),
      trailing: const Icon(Icons.navigate_next_rounded),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ManualAttendancePage(),
            ));
      },
    );
  }
}

class _leaveApplication extends StatelessWidget {
  const _leaveApplication({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return ListTile(
      leading: Image.asset(
        'assets/img/schedule.png',
        width: 20,
        height: 20,
      ),
      title: Text(
        localization.leave_application,
        style: const TextStyle(
            fontSize: 14.0, fontFamily: 'productSans', letterSpacing: 1.3),
      ),
      trailing: const Icon(Icons.navigate_next_rounded),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LeaveApplicationPage(),
            ));
      },
    );
  }
}
