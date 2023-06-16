import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/View/Attendance/manual_attendance_page.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Bloc/Dashboard/dashboard_bloc.dart';
import '../../core/Utils/base_img.dart';
import '../../data/Services/attendance_service.dart';
import '../../data/Services/employee_service.dart';
import '../../data/Services/leave_service.dart';
import '../../data/Services/login_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var baseString = BaseImg.baseImg;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Position? position = Position(
      longitude: 27.7172,
      latitude: 85.3240,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1);
  List<Placemark>? placemarks = <Placemark>[];
  var outputFormat = DateFormat('hh:mm a');
  bool isCheckIn = false;
  final _isHours = true;
  late SharedPreferences preferences;
  int? runningTime = 0;
  bool? isRunning = false;
  String? checkInTime;
  Duration? currentTimer;
  bool isRuned = false;
  LoginService loginService = LoginService(Dio());
  EmployeeService employeeService = EmployeeService(Dio());
  LeaveService leaveService = LeaveService(Dio());
  AttendanceService attendanceService = AttendanceService(Dio());
  late DashboardBloc _dashboardBloc;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _dashboardBloc = DashboardBloc(
        employeeService, loginService, leaveService, attendanceService);
    initializePreference();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    DateFormat monthformatter = DateFormat('MMM');
    DateFormat dayformatter = DateFormat('dd');
    DateFormat yearformatter = DateFormat('yy');
    DateFormat weekformatter = DateFormat('EE');
    String DatTimeAbbr =
        "${dayformatter.format(DateTime.now())} ${monthformatter.format(DateTime.now())}, ${yearformatter.format(DateTime.now())} | ${weekformatter.format(DateTime.now())}";
    Uint8List uint8list = base64Decode(baseString);
    return BlocProvider(
      create: (context) => _dashboardBloc..add(LoadDashboardData()),
      child: Scaffold(
        //Drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColor.background,
                      child: Text(
                        getInitials("NA"),
                        style: GoogleFonts.montserrat(color: AppColor.primary),
                      ),
                      //foregroundImage: MemoryImage(uint8list),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      //greeting,
                      _getGreeting(),
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //Fetch Name
                    Text(
                      "NA",
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.home,
                  color: AppColor.primary,
                ),
                title: Text(
                  localization.home,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  LineIcons.user,
                  color: AppColor.primary,
                ),
                title: Text(
                  localization.profile,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  LineIcons.calendar,
                  color: AppColor.primary,
                ),
                title: Text(
                  localization.attendance,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  LineIcons.calendarCheck,
                  color: AppColor.primary,
                ),
                title: Text(
                  localization.leave_application,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  LineIcons.arrowCircleRight,
                  color: AppColor.primary,
                ),
                title: Text(
                  localization.logout,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),

        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 40,
          title: Row(
            children: [
              BlocBuilder<DashboardBloc, DashboardState>(
                bloc: _dashboardBloc,
                builder: (context, state) {
                  if (state is DashboardLoading) {
                    return const SizedBox(
                      height: 10,
                      width: 10,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is DashboardLoadedState) {
                    String fullName = state.name.substring(
                        state.name.indexOf('. ') + 1,
                        state.name.lastIndexOf(''));
                    var names = state.name.split(' ');
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColor.background,
                          child: Text(
                            getInitials(fullName),
                            style:
                                GoogleFonts.montserrat(color: AppColor.primary),
                          ),
                          //foregroundImage: MemoryImage(uint8list),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${_getGreeting()}, ${names[1]}".toUpperCase(),
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2),
                        ),
                        // Text(
                        //   "HI,${names[1]}".toUpperCase(),
                        //   style: GoogleFonts.montserrat(
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w500,
                        //       letterSpacing: 1.2),
                        // ),
                      ],
                    );
                  }
                  if (state is DashboardDataLoadFailed) {
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColor.whiteText,
                          child: Text(
                            "NA",
                            style: GoogleFonts.montserrat(
                                color: AppColor.whiteText),
                          ),
                          //foregroundImage: MemoryImage(uint8list),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "N/A",
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                LineIcons.bell,
                size: 25,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Text(
                        localization.whats_up,
                        style: GoogleFonts.montserrat(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const _todaysDate(),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                localization.check_in_out,
                                style: GoogleFonts.montserrat(
                                  letterSpacing: 1.2,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                DatTimeAbbr,
                                style: GoogleFonts.montserrat(
                                  letterSpacing: 1.2,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder<int>(
                                    initialData: 0,
                                    builder: (context, snap) {
                                      final value = snap.data;
                                      final displayTime =
                                          StopWatchTimer.getDisplayTime(value!,
                                              hours: _isHours,
                                              minute: true,
                                              second: true,
                                              milliSecond: false);
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              displayTime,
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  StreamBuilder<int>(
                                    builder: (context, snapshot) {
                                      var todaysDate =
                                          outputFormat.format(DateTime.now());
                                      return Text(
                                        "${localization.now_is} $todaysDate",
                                        style: const TextStyle(
                                            color: AppColor.lightText,
                                            letterSpacing: 1.2),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColor.primary),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(130, 30)),
                                ),
                                child: Text(
                                  localization.check_in,
                                  style: GoogleFonts.montserrat(
                                      letterSpacing: 1.3,
                                      fontSize: 10,
                                      color: AppColor.whiteText),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ManualAttendancePage(),
                                  ));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _attendanceCard(),
                  const _leaveCard(),
                  const SizedBox(
                    height: 14,
                  ),
                  _carouselView(),
                  const SizedBox(
                    height: 16,
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

class _carouselView extends StatelessWidget {
  _carouselView({
    Key? key,
  }) : super(key: key);

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1115&q=80',
    'https://images.unsplash.com/photo-1434626881859-194d67b2b86f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1474&q=80',
    'https://images.unsplash.com/photo-1427751840561-9852520f8ce8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80',
    'https://images.unsplash.com/photo-1532619675605-1ede6c2ed2b0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization.office_news,
              style: GoogleFonts.montserrat(
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
            items: imgList
                .map((item) => Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _attendanceCard extends StatelessWidget {
  _attendanceCard({
    Key? key,
  }) : super(key: key);
  final LoginService loginService = LoginService(Dio());
  final LeaveService leaveService = LeaveService(Dio());
  final EmployeeService employeeService = EmployeeService(Dio());
  final AttendanceService attendanceService = AttendanceService(Dio());

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    var defaultFromDate = "${DateTime.now().year}/${DateTime.now().month}/1";
    var lastday =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    var defaultToDate =
        "${DateTime.now().year}/${DateTime.now().month}/$lastday";
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    localization.attendance,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, letterSpacing: 1.2),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<DashboardBloc, DashboardState>(
                bloc: DashboardBloc(employeeService, loginService, leaveService,
                    attendanceService)
                  ..add(LoadDashboardData()),
                builder: (context, state) {
                  if (state is DashboardLoading) {
                    return const SizedBox(
                      height: 10,
                      width: 10,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is DashboardLoadedState) {
                    List<num> hours = <num>[];
                    List<num> minute = <num>[];
                    List<num> seconds = <num>[];
                    List<String?> remarks = <String>[];
                    double totalWorkingDays = 0;

                    for (var items in state.personalAttendanceDetailsResponse) {
                      if (items.daysType!.contains('Saturday')) {
                        remarks.add(items.daysType);
                      }
                      if (items.daysType!.contains('HoliDay')) {
                        remarks.add(items.daysType);
                      }
                      var totalWorks = items.totalWork?.split(':');
                      if (totalWorks![0] == "") {
                      } else {
                        hours.add(num.parse(totalWorks[0]));
                        minute.add(num.parse(totalWorks[1]));
                        seconds.add(num.parse(totalWorks[2]));
                      }
                    }

                    var sumOfHours = hours.sum;
                    var sumOfMinutes = minute.sum;
                    var sumOfSeconds = seconds.sum;

                    var totalHoursWorked =
                        (sumOfHours + sumOfMinutes / 60 + sumOfSeconds / 60);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height / 11,
                          child: AspectRatio(
                            aspectRatio: 2 / 0.01,
                            child: PieChart(
                              PieChartData(
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  sections: [
                                    PieChartSectionData(
                                        color: AppColor.primary,
                                        value:
                                            (state.personalAttendanceDetailsResponse
                                                        .length -
                                                    remarks.length) -
                                                hours.length.toDouble(),
                                        radius: 10,
                                        showTitle: false),
                                    PieChartSectionData(
                                        color: AppColor.attentionText,
                                        value:
                                            (state.personalAttendanceDetailsResponse
                                                        .length -
                                                    remarks.length)
                                                .toDouble(),
                                        radius: 10,
                                        showTitle: false),
                                  ],
                                  centerSpaceRadius: 12),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              (state.personalAttendanceDetailsResponse.length -
                                      remarks.length)
                                  .toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primary),
                            ),
                            Text(
                              localization.total,
                              style: const TextStyle(
                                  color: AppColor.lightText,
                                  fontSize: 14,
                                  letterSpacing: 1.2),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              hours.length.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orangeAccent),
                            ),
                            Text(
                              localization.days,
                              style: const TextStyle(
                                  color: AppColor.lightText,
                                  fontSize: 14,
                                  letterSpacing: 1.2),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              totalHoursWorked.toStringAsFixed(2),
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.attentionText),
                            ),
                            Text(
                              localization.hours,
                              style: const TextStyle(
                                  color: AppColor.lightText,
                                  fontSize: 14,
                                  letterSpacing: 1.2),
                            )
                          ],
                        ),
                      ],
                    );
                  }
                  if (state is DashboardDataLoadFailed) {
                    return Container();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ));
  }
}

class _leaveCard extends StatelessWidget {
  const _leaveCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    localization.annual_leave,
                    style: GoogleFonts.montserrat(
                        fontSize: 16, letterSpacing: 1.2),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is DashboardLoadedState) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height / 11,
                          child: AspectRatio(
                            aspectRatio: 2 / 0.01,
                            child: PieChart(
                              PieChartData(
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  sections: [
                                    PieChartSectionData(
                                        color: AppColor.lightText,
                                        value: state.leaveSummaryResponse!
                                                .isNotEmpty
                                            ? double.parse(state
                                                .leaveSummaryResponse!
                                                .last
                                                .noOfDays
                                                .toString())
                                            : 12,
                                        radius: 10,
                                        showTitle: false),
                                    PieChartSectionData(
                                        color: AppColor.primary,
                                        value: state.leaveSummaryResponse!
                                                .isNotEmpty
                                            ? double.parse(state
                                                .leaveSummaryResponse!
                                                .last
                                                .takenDays
                                                .toString())
                                            : 0,
                                        radius: 10,
                                        showTitle: false),
                                  ],
                                  centerSpaceRadius: 12),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            BlocBuilder<DashboardBloc, DashboardState>(
                              builder: (context, state) {
                                if (state is DashboardLoading) {
                                  return const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                if (state is DashboardLoadedState) {
                                  if (state.leaveSummaryResponse!.isNotEmpty) {
                                    return Text(
                                      state.leaveSummaryResponse![0]
                                              .remainingLeave ??
                                          "N/A",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
                                    );
                                  } else {
                                    return Text(
                                      localization.twelve,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
                                    );
                                  }
                                }
                                if (state is DashboardDataLoadFailed) {
                                  return Text(
                                    "N/A",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary),
                                  );
                                }
                                return Container();
                              },
                            ),
                            Text(
                              localization.remain,
                              style: const TextStyle(
                                  color: AppColor.lightText,
                                  fontSize: 14,
                                  letterSpacing: 1.2),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            BlocBuilder<DashboardBloc, DashboardState>(
                              builder: (context, state) {
                                if (state is DashboardLoading) {
                                  return const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                if (state is DashboardLoadedState) {
                                  if (state.leaveSummaryResponse!.isNotEmpty) {
                                    return Text(
                                      state.leaveSummaryResponse![0]
                                              .takenDays ??
                                          "N/A",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
                                    );
                                  } else {
                                    return Text(
                                      localization.zero,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
                                    );
                                  }
                                }
                                if (state is DashboardDataLoadFailed) {
                                  return Text(
                                    "N/A",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary),
                                  );
                                }
                                return Container();
                              },
                            ),
                            Text(
                              localization.taken,
                              style: const TextStyle(
                                  color: AppColor.lightText,
                                  fontSize: 14,
                                  letterSpacing: 1.2),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            BlocBuilder<DashboardBloc, DashboardState>(
                              builder: (context, state) {
                                if (state is DashboardLoading) {
                                  return const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                if (state is DashboardLoadedState) {
                                  if (state.leaveSummaryResponse!.isNotEmpty) {
                                    return Text(
                                      state.leaveSummaryResponse![0].noOfDays ??
                                          "N/A",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
                                    );
                                  } else {
                                    return Text(
                                      localization.twelve,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
                                    );
                                  }
                                }
                                if (state is DashboardDataLoadFailed) {
                                  return Text(
                                    "N/A",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary),
                                  );
                                }
                                return Container();
                              },
                            ),
                            Text(
                              localization.total,
                              style: const TextStyle(
                                  color: AppColor.lightText,
                                  fontSize: 14,
                                  letterSpacing: 1.2),
                            )
                          ],
                        ),
                      ],
                    );
                  }
                  if (state is DashboardLoading) {
                    return const SizedBox(
                      height: 10,
                      width: 10,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is DashboardDataLoadFailed) {
                    return Container();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ));
  }
}

class _todaysDate extends StatelessWidget {
  const _todaysDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    DateFormat monthformatter = DateFormat('MMM');
    String monthAbbr = monthformatter.format(DateTime.now());
    DateFormat dayformatter = DateFormat('dd');
    String dayAbbr = dayformatter.format(DateTime.now());

    return Row(
      children: [
        Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.primary,
                  ),
                  child: Text(
                    monthAbbr,
                    style: GoogleFonts.montserrat(
                        fontSize: 12, color: AppColor.whiteText),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  dayAbbr,
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                width: MediaQuery.of(context).size.width / 1.34,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                        if (state is DashboardLoading) {
                          return const SizedBox(
                            height: 10,
                            width: 10,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is DashboardLoadedState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    localization.shift,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    state.workShiftName,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    localization.punch,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    state.punchTime,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    localization.remarks,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    state.remarks,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        }
                        if (state is DashboardDataLoadFailed) {
                          return Container();
                        }
                        return Container();
                      },
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
