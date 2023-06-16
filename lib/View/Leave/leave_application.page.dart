import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/View/Leave/leave_request_page.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Bloc/Leave/leave_bloc.dart';
import '../../data/Services/leave_service.dart';
import '../../data/Services/login_service.dart';

class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({Key? key}) : super(key: key);

  @override
  State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  final LoginService loginService = LoginService(Dio());
  final LeaveService leaveService = LeaveService(Dio());
  late LeaveBloc _leaveBloc;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Color getColor(bool approvedStatus) {
    if (approvedStatus == true) {
      return Colors.green;
    } else {
      return AppColor.attentionText;
    }
  }

  @override
  void initState() {
    _leaveBloc = LeaveBloc(loginService, leaveService);
    super.initState();
  }

  String convertToShowMonth(String dateTime) {
    DateFormat Monthformatter = DateFormat('MMM');
    if (dateTime != "") {
      var parsedTime = DateTime.parse(dateTime);
      return Monthformatter.format(parsedTime);
    } else {
      return "N/A";
    }
  }

  String convertToShowDay(String dateTime) {
    DateFormat dayformatter = DateFormat('dd');
    if (dateTime != "") {
      var parsedTime = DateTime.parse(dateTime);
      return dayformatter.format(parsedTime);
    } else {
      return "N/A";
    }
  }

  String convertFromToDate(String fromDate, String toDate) {
    DateFormat Monthformatter = DateFormat('MMM-dd');
    if (fromDate != "" && toDate != "") {
      var parsedFrom = DateTime.parse(fromDate);
      var parsedTo = DateTime.parse(toDate);
      var concatDate =
          "${Monthformatter.format(parsedFrom)} | ${Monthformatter.format(parsedTo)}";
      return concatDate;
    } else {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => _leaveBloc..add(LoadLeaveSummaryDetails()),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.primary,
          elevation: 0.0,
          title: Text(
            localization.leave_application,
            style: GoogleFonts.montserrat(
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
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.primary,
            foregroundColor: AppColor.whiteText,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaveRequestPage(),
                  ));
            },
            child: const Icon(LineIcons.calendarPlus)),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    child: BlocBuilder<LeaveBloc, LeaveState>(
                      builder: (context, state) {
                        if (state is LeaveDetailsLoading) {
                          return const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is LeaveDetailsLoaded) {
                          if (state.leaveSummaryList.isNotEmpty) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                  height:
                                      MediaQuery.of(context).size.height / 11,
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
                                                value: double.parse(state
                                                    .leaveSummaryList[0]
                                                    .takenDays!),
                                                radius: 10,
                                                showTitle: false),
                                            PieChartSectionData(
                                                color: AppColor.primary,
                                                value: double.parse(state
                                                    .leaveSummaryList[0]
                                                    .remainingLeave!),
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
                                      state.leaveSummaryList[0]
                                              .remainingLeave ??
                                          "N/A",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
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
                                    Text(
                                      state.leaveSummaryList[0].takenDays ??
                                          "N/A",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
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
                                    Text(
                                      state.leaveSummaryList[0].noOfDays ??
                                          "N/A",
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
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                  height:
                                      MediaQuery.of(context).size.height / 11,
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
                                                value: 12,
                                                radius: 10,
                                                showTitle: false),
                                            PieChartSectionData(
                                                color: AppColor.primary,
                                                value: 0,
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
                                      localization.twelve,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
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
                                    Text(
                                      localization.zero,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.primary),
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
                                    Text(
                                      localization.twelve,
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
                              ],
                            );
                          }
                        }
                        if (state is LeaveDetailsLoadFailed) {
                          return Container();
                        }
                        return Container();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 8, top: 16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  localization.leave_requests,
                                  style: const TextStyle(
                                      fontSize: 14, letterSpacing: 1.2),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<LeaveBloc, LeaveState>(
                          builder: (context, state) {
                            if (state is LeaveDetailsLoading) {
                              return const Center(
                                child: SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator()),
                              );
                            }
                            if (state is LeaveDetailsLoaded) {
                              if (state.leaveDetailsList.isEmpty) {
                                return const _noData();
                              }
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              color: AppColor.primary,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(6))),
                                          padding: const EdgeInsets.all(8),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  convertToShowDay(state
                                                      .leaveDetailsList[index]
                                                      .leaveSubmitDatee!),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      letterSpacing: 1.5,
                                                      color:
                                                          AppColor.whiteText),
                                                ),
                                                Text(
                                                  convertToShowMonth(state
                                                      .leaveDetailsList[index]
                                                      .leaveSubmitDatee!),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      letterSpacing: 1.5,
                                                      color:
                                                          AppColor.whiteText),
                                                ),
                                              ]),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  state.leaveDetailsList[index]
                                                          .subject ??
                                                      "N/A",
                                                  style: const TextStyle(
                                                      fontSize: 14)),
                                              Text(
                                                convertFromToDate(
                                                    state
                                                        .leaveDetailsList[index]
                                                        .leaveSubmitDatee!,
                                                    state
                                                        .leaveDetailsList[index]
                                                        .leaveSubmitDatee!),
                                                style: const TextStyle(
                                                    color: AppColor.lightText,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            width: 4.0,
                                            height: 55,
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                color: getColor(state
                                                    .leaveDetailsList[index]
                                                    .approvedStatus!),
                                                borderRadius:
                                                    BorderRadius.circular(6)))
                                      ],
                                    ),
                                  );
                                },
                                itemCount: state.leaveDetailsList.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(5),
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                              );
                            }
                            if (state is LeaveDetailsLoadFailed) {
                              return const _noData();
                            }
                            return const _noData();
                          },
                        )
                      ],
                    ),
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
