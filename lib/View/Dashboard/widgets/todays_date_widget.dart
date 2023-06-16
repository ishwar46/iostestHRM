import 'package:flutter/material.dart';

import '../../../core/Styles/app_color.dart';
import '../../../core/Styles/dimension.dart';

class TodaysDateWidget extends StatelessWidget {
  const TodaysDateWidget({
    super.key,
    required this.date,
    required this.textTheme,
    required this.day,
  });

  final String date;
  final TextTheme textTheme;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimension.h7 * 2, vertical: Dimension.h8 * 2),
      height: Dimension.h10 * 8,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.textfield.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
          border:
              Border.all(color: AppColor.textfield.withOpacity(0.2))),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: textTheme.labelLarge!.copyWith(
                    color: AppColor.subtitleText, fontSize: 18),
              ),
              const Spacer(),
              Text(
                day,
                style: textTheme.labelLarge!.copyWith(
                    color: AppColor.subtitleText, fontSize: 14),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
              height: Dimension.h2 * 22,
              width: Dimension.h2 * 22,
              child: Image.asset("assets/img/calendar-month.png"))
        ],
      ),
    );
  }
}



