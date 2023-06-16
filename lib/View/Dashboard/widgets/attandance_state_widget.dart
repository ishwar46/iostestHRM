import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/Styles/app_color.dart';
import '../../../core/Styles/dimension.dart';
import '../present_screen.dart';

class AttendenceStateWidget extends StatelessWidget {
  const AttendenceStateWidget({
    super.key,
    required this.textTheme,
    required this.localization,
  });

  final TextTheme textTheme;
  final AppLocalizations localization;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimension.h10 * 16,
      width: MediaQuery.of(context).size.width,
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimension.h2 * 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimension.h8 * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PresentAbsentWidget(
                  ontap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PresentScreen(),
                    ));
                  },
                  textTheme: textTheme,
                  borderColor: Colors.green,
                  iconImage: "assets/img/account-check.png",
                  number: '14',
                  text: localization.present,
                ),
                PresentAbsentWidget(
                  ontap: () {},
                  textTheme: textTheme,
                  borderColor: Colors.red,
                  iconImage: "assets/img/account-multiple-remove.png",
                  number: '10',
                  text: localization.absent,
                ),
                PresentAbsentWidget(
                  ontap: () {},
                  textTheme: textTheme,
                  borderColor: AppColor.primary,
                  iconImage: "assets/img/exit-run.png",
                  number: '0',
                  text: localization.onLeave,
                ),
                PresentAbsentWidget(
                  ontap: () {},
                  textTheme: textTheme,
                  borderColor: Colors.yellow,
                  iconImage: "assets/img/receipt-clock.png",
                  number: '4',
                  text: localization.pending,
                )
              ],
            ),
          ),
          const Spacer(),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Dimension.h10 * 2,
                  width: Dimension.screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimension.h7 * 2),
                        topRight: Radius.circular(Dimension.h7 * 2),
                      )),
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.h7 * 2),
                      topRight: Radius.circular(Dimension.h7 * 2),
                    )),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class PresentAbsentWidget extends StatelessWidget {
  final Color borderColor;
  final String iconImage;
  final String number;
  final String text;
  void Function() ontap;

  PresentAbsentWidget(
      {super.key,
      required this.textTheme,
      required this.borderColor,
      required this.iconImage,
      required this.number,
      required this.ontap,
      required this.text});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: Dimension.h10 * 7,
        width: Dimension.h10 * 7,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimension.h7),
            border: Border.all(color: borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: Image.asset(iconImage),
                ),
                SizedBox(
                  width: Dimension.h2 * 2,
                ),
                Text(
                  number,
                  style: textTheme.bodyMedium!.copyWith(color: borderColor),
                )
              ],
            ),
            SizedBox(
              height: Dimension.h2 * 3,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'nunito',
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
