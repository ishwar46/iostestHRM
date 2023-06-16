import 'package:flutter/material.dart';

import '../Styles/app_color.dart';

class HeaderTab extends StatelessWidget {
  const HeaderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: AppColor.whiteText,
          ),
        ),
      ],
    );
  }
}
