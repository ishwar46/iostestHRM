import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Bloc/Holiday/holiday_bloc.dart';
import '../../data/Model/Response/holiday_details_response.dart';
import '../../data/Services/holiday_service.dart';
import '../../data/Services/login_service.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<HolidayDetailsResponse>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late HolidayService holidayService = HolidayService(Dio());
  late LoginService loginService = LoginService(Dio());
  late HolidayBloc _holidayBloc;
  ScrollController scrollController = ScrollController();
  late LinkedHashMap<DateTime, List<HolidayDetailsResponse>> kEvents;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    if ((to.difference(from).inHours / 24).round() <= 0) {
      var timestring = (to.difference(from).inHours / 24)
          .round()
          .toString()
          .substring(
              1,
              (to.difference(from).inHours / 24)
                  .round()
                  .toString()
                  .lastIndexOf(''));
      final TimeStamp =
          DateTime.now().subtract(Duration(days: int.parse(timestring)));
      return timeago.format(TimeStamp);
    } else if ((to.difference(from).inHours / 24).round() > 0.0) {
      return ("${(to.difference(from).inHours / 24).round()} Days Remaining");
    } else {
      return timeago.format(DateTime.now());
    }
  }

  @override
  void initState() {
    _holidayBloc = HolidayBloc(loginService, holidayService)
      ..add(LoadHolidayDetails());
    kEvents = LinkedHashMap<DateTime, List<HolidayDetailsResponse>>(
        equals: isSameDay, hashCode: getHashCode);
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<HolidayDetailsResponse> _getEventsForDay(DateTime day) {
    var a = kEvents[day] ?? [];
    return a;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _holidaySetup(DateTime holiday) {
    if (holiday.weekday == DateTime.saturday) {
      return true;
    } else {
      return false;
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  String getWeekDay(String dateTime) {
    var datetime = DateTime.parse(dateTime);
    DateFormat monthformatter = DateFormat('EEEE');
    String monthAbbr = monthformatter.format(datetime);
    return monthAbbr;
  }

  String getMonthYear(String dateTime) {
    var datetime = DateTime.parse(dateTime);
    DateFormat monthformatter = DateFormat('MMMM, yyyy');
    String monthAbbr = monthformatter.format(datetime);
    return monthAbbr;
  }

  String getShortDateMonth(String dateTime) {
    var datetime = DateTime.parse(dateTime);
    DateFormat monthformatter = DateFormat('MMM');
    String monthAbbr = monthformatter.format(datetime);
    return monthAbbr;
  }

  String getShortDateDay(String dateTime) {
    var datetime = DateTime.parse(dateTime);
    DateFormat dayformatter = DateFormat('dd');
    String dayAbbr = dayformatter.format(datetime);
    return dayAbbr;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => _holidayBloc,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.primary,
          elevation: 0.0,
          title: Text(
            localization.calendar,
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
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<HolidayBloc, HolidayState>(
            builder: (context, state) {
              if (state is HolidayLoading) {
                return const Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()),
                );
              }
              if (state is HolidayLoaded) {
                kEvents.addAll(state.kEvents);
                return Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 1, 1),
                      lastDay: DateTime.utc(2099, 1, 1),
                      focusedDay: _focusedDay,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarFormat: _calendarFormat,
                      calendarBuilders: CalendarBuilders(
                        selectedBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(6.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        todayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(6.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        markerBuilder: (context, date, events) {
                          if (events.isNotEmpty) {
                            return Container(
                              margin: const EdgeInsets.all(6.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColor.attentionText,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 100,
                              height: 100,
                              child: Text(
                                '${date.day}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonDecoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        formatButtonTextStyle:
                            const TextStyle(color: Colors.white),
                        formatButtonShowsNext: false,
                        formatButtonVisible: false,
                        titleTextStyle: GoogleFonts.montserrat(
                            fontSize: 14, letterSpacing: 1.2),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: GoogleFonts.montserrat(fontSize: 12),
                        holidayDecoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        holidayTextStyle: GoogleFonts.montserrat(
                            color: AppColor.attentionText),
                        markerDecoration: const BoxDecoration(
                          color: AppColor.attentionText,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      holidayPredicate: (holiday) {
                        return _holidaySetup(holiday);
                      },
                      eventLoader: _getEventsForDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: _onDaySelected,
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child:
                          ValueListenableBuilder<List<HolidayDetailsResponse>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 4.0,
                                ),
                                child: Card(
                                  color: AppColor.accent,
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                getMonthYear(
                                                    _selectedDay!.toString()),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColor.attentionText),
                                              ),
                                              Text(
                                                _selectedDay!.day.toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color:
                                                        AppColor.attentionText),
                                              ),
                                              Text(
                                                getWeekDay(
                                                    _selectedDay!.toString()),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        AppColor.attentionText),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const VerticalDivider(
                                            color: AppColor.titleText,
                                            thickness: 1,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  value[index].holydayName ??
                                                      "N/A",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: AppColor
                                                          .attentionText),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  daysBetween(
                                                          DateTime.now(),
                                                          DateTime.parse(
                                                              value[index]
                                                                  .dFrom!))
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color:
                                                          AppColor.lightText),
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
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              if (state is HolidayLoadFailed) {
                return Container();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
