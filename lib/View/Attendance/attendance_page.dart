import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/Bloc/Attendance/attendance_bloc.dart';
import '../../core/Styles/app_color.dart';
import '../../data/Services/attendance_service.dart';
import '../../data/Services/employee_service.dart';
import '../../data/Services/login_service.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  final LoginService loginService = LoginService(Dio());
  final EmployeeService employeeService = EmployeeService(Dio());
  final AttendanceService attendanceService = AttendanceService(Dio());
  late AttendanceBloc _attendanceBloc;
  String? selectedItem;

  final List<SelectedListItem> _listOfMonths = [
    SelectedListItem(isSelected: false, name: "January"),
    SelectedListItem(isSelected: false, name: "February"),
    SelectedListItem(isSelected: false, name: "March"),
    SelectedListItem(isSelected: false, name: "April"),
    SelectedListItem(isSelected: false, name: "May"),
    SelectedListItem(isSelected: false, name: "June"),
    SelectedListItem(isSelected: false, name: "July"),
    SelectedListItem(isSelected: false, name: "August"),
    SelectedListItem(isSelected: false, name: "September"),
    SelectedListItem(isSelected: false, name: "October"),
    SelectedListItem(isSelected: false, name: "November"),
    SelectedListItem(isSelected: false, name: "December"),
  ];

  String getFromDate(String fromDate) {
    if (fromDate == "January") {
      return "${DateTime.now().year}/1/1";
    } else if (fromDate == "February") {
      return "${DateTime.now().year}/2/1";
    } else if (fromDate == "March") {
      return "${DateTime.now().year}/3/1";
    } else if (fromDate == "April") {
      return "${DateTime.now().year}/4/1";
    } else if (fromDate == "May") {
      return "${DateTime.now().year}/5/1";
    } else if (fromDate == "June") {
      return "${DateTime.now().year}/6/1";
    } else if (fromDate == "July") {
      return "${DateTime.now().year}/7/1";
    } else if (fromDate == "August") {
      return "${DateTime.now().year}/8/1";
    } else if (fromDate == "September") {
      return "${DateTime.now().year}/9/1";
    } else if (fromDate == "October") {
      return "${DateTime.now().year}/10/1";
    } else if (fromDate == "November") {
      return "${DateTime.now().year}/11/1";
    } else {
      return "${DateTime.now().year}/12/1";
    }
  }

  String getToDate(String toDate) {
    if (toDate == "January") {
      return "${DateTime.now().year}/2/1";
    } else if (toDate == "February") {
      return "${DateTime.now().year}/3/1";
    } else if (toDate == "March") {
      return "${DateTime.now().year}/4/1";
    } else if (toDate == "April") {
      return "${DateTime.now().year}/5/1";
    } else if (toDate == "May") {
      return "${DateTime.now().year}/6/1";
    } else if (toDate == "June") {
      return "${DateTime.now().year}/7/1";
    } else if (toDate == "July") {
      return "${DateTime.now().year}/8/1";
    } else if (toDate == "August") {
      return "${DateTime.now().year}/9/1";
    } else if (toDate == "September") {
      return "${DateTime.now().year}/10/1";
    } else if (toDate == "October") {
      return "${DateTime.now().year}/11/1";
    } else if (toDate == "November") {
      return "${DateTime.now().year}/12/1";
    } else {
      return "${DateTime.now().year + 1}/1/1";
    }
  }

  String getMonth(int currentMonthIndex) {
    return DateFormat('MMM').format(DateTime(0, currentMonthIndex)).toString();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        selectedItems: (var selected) async {
          setState(() {
            selectedItem = selected.first.name;
          });
          var fromDate = getFromDate(selected.first.name);
          var toDate = getToDate(selected.first.name);
          _attendanceBloc.add(
            LoadAttendanceDetail(fromDate, toDate),
          );
        },
        data: _listOfMonths,
        bottomSheetTitle: const Text("Month"),
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _attendanceBloc =
        AttendanceBloc(loginService, employeeService, attendanceService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    var defaultFromDate = "${DateTime.now().year}/${DateTime.now().month}/1";
    var lastday =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    var defaultToDate =
        "${DateTime.now().year}/${DateTime.now().month}/$lastday";
    return BlocProvider(
      create: (context) => _attendanceBloc
        ..add(LoadAttendanceDetail(defaultFromDate, defaultToDate)),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.primary,
          elevation: 0.0,
          title: Text(
            localization.attendance,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              letterSpacing: 1.2,
            ),
          ),
          toolbarHeight: 40,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.height / 11,
                                child: AspectRatio(
                                  aspectRatio: 2 / 0.01,
                                  child: BlocBuilder<AttendanceBloc,
                                      AttendanceState>(
                                    builder: (context, state) {
                                      if (state is AttendanceLoading) {
                                        return const Center(
                                          child: SizedBox(
                                              height: 15,
                                              width: 15,
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                      if (state is AttendanceDataLoaded) {
                                        List<num> hours = <num>[];
                                        List<num> minute = <num>[];
                                        List<num> seconds = <num>[];
                                        List<String?> remarks = <String>[];
                                        double totalWorkingDays = 0;

                                        for (var items in state
                                            .personalAttendanceDetailsResponse) {
                                          if (items.daysType!
                                              .contains('Saturday')) {
                                            remarks.add(items.daysType);
                                          }
                                          if (items.daysType!
                                              .contains('HoliDay')) {
                                            remarks.add(items.daysType);
                                          }
                                          var totalWorks =
                                              items.totalWork?.split(':');
                                          if (totalWorks![0] == "") {
                                          } else {
                                            hours.add(num.parse(totalWorks[0]));
                                            minute
                                                .add(num.parse(totalWorks[1]));
                                            seconds
                                                .add(num.parse(totalWorks[2]));
                                          }
                                        }

                                        var sumOfHours = hours.sum;
                                        var sumOfMinutes = minute.sum;
                                        var sumOfSeconds = seconds.sum;

                                        var totalHoursWorked = (sumOfHours +
                                            sumOfMinutes / 60 +
                                            sumOfSeconds / 60);

                                        return PieChart(
                                          PieChartData(
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              sections: <PieChartSectionData>[
                                                PieChartSectionData(
                                                  color: AppColor.primary,
                                                  value:
                                                      ((state.personalAttendanceDetailsResponse
                                                                      .length -
                                                                  remarks
                                                                      .length) *
                                                              8) -
                                                          totalHoursWorked,
                                                  radius: 8,
                                                  showTitle: false,
                                                ),
                                                PieChartSectionData(
                                                  color: AppColor.attentionText,
                                                  value:
                                                      (state.personalAttendanceDetailsResponse
                                                                  .length -
                                                              remarks.length) *
                                                          8,
                                                  radius: 8,
                                                  showTitle: false,
                                                ),
                                              ],
                                              centerSpaceRadius: 10),
                                        );
                                      }
                                      if (state is AttendanceDataLoadFailed) {
                                        return Container();
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localization.work_hours,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "$defaultFromDate - $defaultToDate",
                                    style: const TextStyle(
                                        color: AppColor.lightText,
                                        fontSize: 12,
                                        letterSpacing: 1.2),
                                  )
                                ],
                              ),
                              BlocBuilder<AttendanceBloc, AttendanceState>(
                                builder: (context, state) {
                                  if (state is AttendanceLoading) {
                                    // return const Center(
                                    //   child: SizedBox(
                                    //       height: 10,
                                    //       width: 10,
                                    //       child: CircularProgressIndicator()),
                                    // );
                                  }
                                  if (state is AttendanceDataLoaded) {
                                    List<num> hours = <num>[];
                                    List<num> minute = <num>[];
                                    List<num> seconds = <num>[];
                                    for (var items in state
                                        .personalAttendanceDetailsResponse) {
                                      var totalWorks =
                                          items.totalWork?.split(':');
                                      if (totalWorks![0] == "") {
                                      } else {
                                        hours.add(num.parse(totalWorks[0]));
                                        minute.add(num.parse(totalWorks[1]));
                                        seconds.add(num.parse(totalWorks[2]));
                                      }
                                    }
                                    var sumOfHours = hours.sum;
                                    var sumOfMinutes = minute.sum / 60;
                                    var sumOfSeconds = seconds.sum / 60;

                                    var totalHoursWorked = (sumOfHours +
                                        sumOfMinutes.round() +
                                        sumOfSeconds.round());
                                    return Column(
                                      children: [
                                        Text(
                                          totalHoursWorked.toStringAsFixed(2),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          localization.hrs,
                                          style: const TextStyle(fontSize: 12),
                                        )
                                      ],
                                    );
                                  }
                                  if (state is AttendanceDataLoadFailed) {
                                    return Container();
                                  }
                                  return Container();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: AppColor.primary),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            label: Row(
                              children: [
                                const Icon(
                                  Icons.filter_alt_rounded,
                                  size: 18,
                                  color: AppColor.primary,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  localization.filter.toUpperCase(),
                                  style:
                                      const TextStyle(color: AppColor.primary),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              onTextFieldTap();
                            },
                            child: Chip(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: AppColor.primary),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              label: Row(
                                children: [
                                  Text(
                                      selectedItem ??
                                          getMonth(DateTime.now().month),
                                      style: const TextStyle(
                                          color: AppColor.primary)),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Icon(Icons.arrow_drop_down,
                                      size: 20, color: AppColor.primary),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<AttendanceBloc, AttendanceState>(
                        builder: (context, state) {
                          if (state is AttendanceLoading) {
                            return const Center(
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator()),
                            );
                          }
                          if (state is AttendanceDataLoaded) {
                            return SingleChildScrollView(
                              child: Table(
                                defaultColumnWidth:
                                    const IntrinsicColumnWidth(),
                                children: state.tableRows,
                                border: TableBorder.all(color: AppColor.titleText, width: 0.5),

                                // border: const TableBorder(
                                //   left: BorderSide(color: AppColor.titleText),
                                //   right: BorderSide(color: AppColor.titleText),
                                //   top: BorderSide(color: AppColor.titleText),
                                //   bottom: BorderSide(color: AppColor.titleText),
                                //   horizontalInside:
                                //       BorderSide(color: AppColor.titleText),
                                // ),
                              ),
                            );
                          }
                          if (state is AttendanceDataLoadFailed) {
                            return const _noData();
                          }
                          return const _noData();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _noData extends StatelessWidget {
  const _noData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        LottieBuilder.asset("assets/lottie/emptybox.json", repeat: true),
        const SizedBox(
          height: 34,
        ),
        Text(localization.no_data)
      ],
    );
  }
}
