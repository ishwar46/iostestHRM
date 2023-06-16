import 'package:flutter/material.dart';
import 'package:hrm/core/Styles/app_color.dart';

import '../../../core/Styles/dimension.dart';

class ReportboxWidget extends StatelessWidget {
  const ReportboxWidget({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimension.h7)),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimension.h2 * 6, vertical: Dimension.h8 * 2),
        height: Dimension.h2 * 90,
        width: Dimension.screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reports",
                    style: TextStyle(
                        color: AppColor.primary,
                        fontSize: Dimension.h8 * 2,
                        fontWeight: FontWeight.w700)),
                Text(
                  "Personal Attendance Report",
                  style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimension.h7 * 2 + 1),
                ),
                Text(
                  "DayInOut Report",
                  style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimension.h7 * 2 + 1),
                ),
                Text(
                  "Daily Attendance Summary",
                  style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Dimension.h7 * 2 + 1),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("View All",
                    style: TextStyle(
                        color: AppColor.primary,
                        fontSize: Dimension.h8 * 2,
                        fontWeight: FontWeight.w600)),
                Text(
                  "View",
                  style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimension.h8 * 2,
                      color: AppColor.titleText),
                ),
                Text(
                  "View",
                  style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimension.h8 * 2,
                      color: AppColor.titleText),
                ),
                Text(
                  "View",
                  style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimension.h8 * 2,
                      color: AppColor.titleText),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
