import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/View/Dashboard/widgets/drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/Bloc/Dashboard/dashboard_bloc.dart';
import '../../../core/Styles/dimension.dart';
import '../../../data/Services/attendance_service.dart';
import '../../../data/Services/employee_service.dart';
import '../../../data/Services/leave_service.dart';
import '../../../data/Services/login_service.dart';
import '../widgets/attandance_state_widget.dart';
import '../widgets/check_in_out_widget.dart';
import '../widgets/reportbox_widget.dart';
import '../widgets/work_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required});

  @override
  State<Dashboard> createState() => _DashboardState();
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

class _DashboardState extends State<Dashboard> {
  EmployeeService employeeService = EmployeeService(Dio());
  LoginService loginService = LoginService(Dio());
  LeaveService leaveService = LeaveService(Dio());
  AttendanceService attendanceService = AttendanceService(Dio());
  late DashboardBloc dashboardBloc;
  @override
  void initState() {
    super.initState();
    dashboardBloc = DashboardBloc(
        employeeService, loginService, leaveService, attendanceService);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    AppLocalizations localization = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => dashboardBloc..add(LoadDashboardData()),
      child: Scaffold(
        drawer: MyDrawerNew(),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: Dimension.h10 * 8,
          backgroundColor: AppColor.primary,
          title: Row(
            children: [
              const Text(
                "Hello! Admin",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'nunito',
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              const Spacer(),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/img/searchicon.png",
                      height: 25,
                      width: 25,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/img/bell-badge-outline.png",
                        height: 25,
                        width: 25,
                      ),
                      iconSize: 16),
                ],
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AttendenceStateWidget(
                  textTheme: textTheme, localization: localization),
              Container(
                color: Colors.white,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  elevation: 0,
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimension.h8 * 2),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimension.h2 * 5,
                        ),
                        Row(
                          children: [
                            const MonthDateWidget(),
                            SizedBox(
                              width: Dimension.h8 * 2,
                            ),
                            Flexible(
                                child: CheckInOutWidget(textTheme: textTheme))
                          ],
                        ),
                        SizedBox(
                          height: Dimension.h2 * 10,
                        ),
                        ReportboxWidget(textTheme: textTheme),
                        SizedBox(
                          height: Dimension.h2 * 10,
                        ),
                        const WorkChartWidget(),
                        SizedBox(
                          height: Dimension.h2 * 100,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MonthDateWidget extends StatelessWidget {
  const MonthDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat monthformatter = DateFormat('MMM');
    String month = monthformatter.format(DateTime.now());
    DateFormat daysformatter = DateFormat('d');
    String days = daysformatter.format(DateTime.now());

    return Container(
      height: Dimension.h2 * 29,
      width: Dimension.h2 * 29,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimension.h7),
          border: Border.all(color: Colors.grey)),
      child: Column(
        children: [
          Container(
            height: 29,
            width: 58,
            decoration: BoxDecoration(
              color: AppColor.red,
              borderRadius: BorderRadius.circular(Dimension.h2 * 3),
            ),
            child: Center(
                child: Text(
              month,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'nunito'),
            )),
          ),
          SizedBox(
            height: Dimension.h2 * 2,
          ),
          Center(
            child: Text(
              days,
              style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
