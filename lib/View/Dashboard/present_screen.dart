      import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/Bloc/Dashboard/dashboard_bloc.dart';
import '../../data/Services/attendance_service.dart';
import '../../data/Services/employee_service.dart';
import '../../data/Services/leave_service.dart';
import '../../data/Services/login_service.dart';


// ignore: must_be_immutable
class PresentScreen extends StatefulWidget {
  const PresentScreen({
    super.key,
  });

  @override
  State<PresentScreen> createState() => _PresentScreenState();
}

class _PresentScreenState extends State<PresentScreen> {
  EmployeeService employeeService = EmployeeService(Dio());
  LoginService loginService = LoginService(Dio());
  LeaveService leaveService = LeaveService(Dio());
  AttendanceService attendanceService = AttendanceService(Dio());
  late DashboardBloc dashboardBloc;

  @override
  @override
  void initState() {
    super.initState();
    dashboardBloc = DashboardBloc(
        employeeService, loginService, leaveService, attendanceService);
  }

  List<String> present = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dashboardBloc..add(LoadDashboardData()),
      child: Scaffold(body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DashboardLoadedState) {
            present.clear();
             final presentList = state.personalAttendanceDetailsResponse
                .where((item) => item.daysType!.contains('Present')).map((e) => e.daysType!)
                .toList();
                  if (presentList.isEmpty) {
                  return const Center(
                    child: Text('No attendance data found.'),
                  );
                } else {
                  return Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: presentList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                            //  Text(state.personalAttendanceDetailsResponse.)
                              Text(presentList[index].toString()),
                            ],
                          );
                        }),
                  );
                }

           
          } else if (state is DashboardDataLoadFailed) {
            return Container(
              height: 30,
              width: 30,
              color: Colors.red,
              child: const CircularProgressIndicator(),
            );
          }
          return Container(
            height: 50,
            width: 50,
            color: Colors.green,
            child: const CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
