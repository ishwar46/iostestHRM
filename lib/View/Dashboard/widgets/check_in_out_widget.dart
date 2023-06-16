import 'package:flutter/material.dart';
import 'package:hrm/View/Attendance/manual_attendance_page.dart';
import 'package:hrm/View/Dashboard/ui/manual_attandance_screen.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/core/Styles/dimension.dart';
import 'package:intl/intl.dart';

class CheckInOutWidget extends StatelessWidget {
  const CheckInOutWidget({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    Stream<DateTime> getTimeStream() {
      return Stream<DateTime>.periodic(
        const Duration(seconds: 1),
        (_) => DateTime.now(),
      );
    }

    String formatTime(DateTime time) {
      final formatter = DateFormat('HH:mm:ss a');
      return formatter.format(time);
    }

    String formatDay(DateTime time) {
      final formatter = DateFormat('EEEE');
      return formatter.format(time);
    }

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimension.h7)),
      child: Container(
        height: Dimension.h10 * 7,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Check In/Out",
                  style: textTheme.labelMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                StreamBuilder<DateTime>(
                  stream: getTimeStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final currentTime = snapshot.data!;
                      final fcurrentTime = formatTime(currentTime);
                      final fcurrentday = formatDay(currentTime);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fcurrentTime,
                            style: TextStyle(
                              fontSize: Dimension.h2 * 8,
                              color: AppColor.primary,
                            ),
                          ),
                          //SizedBox(height: Dimension.h2,),
                          Text(
                            fcurrentday,
                            style: TextStyle(fontSize: Dimension.h2 * 6),
                          ),
                        ],
                      );
                    } else {
                      return Text(
                        'Loading...',
                        style: TextStyle(fontSize: Dimension.h2 * 6),
                      );
                    }
                  },
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              splashColor: Colors.transparent,

              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManualAttendanceScreen(),));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimension.h10, vertical: Dimension.h2),
                height: Dimension.h2 * 18,
                width: Dimension.h10 * 11,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.h7),
                    color: AppColor.primary),
                child: Row(
                  children: [
                    SizedBox(
                      height: Dimension.h8 * 3,
                      width: Dimension.h8 * 3,
                      child: Image.asset("assets/img/fingerprint.png"),
                    ),
                    const Spacer(),
                    Text(
                      "Check In",
                      style: TextStyle(
                          fontSize: Dimension.h7 * 2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
