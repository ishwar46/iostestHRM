import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/View/LeaveView/leave_view.dart';
import 'package:hrm/View/Profile/profile_view.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/View/Dashboard/ui/dashboard_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/Bloc/Dashboard/dashboard_bloc.dart';

class MyDrawerNew extends StatefulWidget {
  DashboardBloc? dashboardBloc;
  MyDrawerNew({super.key, this.dashboardBloc});

  @override
  State<MyDrawerNew> createState() => _MyDrawerNewState();
}

class _MyDrawerNewState extends State<MyDrawerNew> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;

    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) {
        return "Good Morning";
      } else if (hour < 17) {
        return "Good Afternoon";
      } else {
        return "Good Evening";
      }
    }

    return BlocBuilder<DashboardBloc, DashboardState>(
      bloc: widget.dashboardBloc,
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const SizedBox(
            height: 10,
            width: 10,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is DashboardLoadedState) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
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
                          style:
                              GoogleFonts.montserrat(color: AppColor.primary),
                        ),
                        //foregroundImage: MemoryImage(uint8list),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        //greeting,
                        getGreeting(),
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            color: AppColor.background),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      //Fetch Name
                      Text(
                        state.name,
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            color: AppColor.background),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(
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
                  leading: const Icon(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileView()));
                  },
                ),
                ListTile(
                  leading: const Icon(
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
                  leading: const Icon(
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
                  leading: const Icon(
                    LineIcons.calendarCheck,
                    color: AppColor.primary,
                  ),
                  title: Text(
                    "Leave",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LeaveView()));
                  },
                ),
                ListTile(
                  leading: const Icon(
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
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
