import 'package:flutter/material.dart';

import '../../../core/Styles/app_color.dart';
import '../../../core/Styles/dimension.dart';

class RemarksFieldWidget extends StatefulWidget {
  String selectedValue;
   RemarksFieldWidget({
    super.key,
    required this.selectedValue
  });

  @override
  State<RemarksFieldWidget> createState() => _RemarksFieldWidgetState();
}

class _RemarksFieldWidgetState extends State<RemarksFieldWidget> {
  String selectedValue = "Working From Home";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(
          value: "Working From Home", child: Text("Working From Home")),
      DropdownMenuItem(
          value: "Working From office", child: Text("Working From office")),
      DropdownMenuItem(
          value: "Working From nowhere", child: Text("Working From nowhere")),
      DropdownMenuItem(value: "no work", child: Text("no work")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimension.h7 * 2),
      height: Dimension.h10 * 5,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.lighttextfield.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: AppColor.lighttextfield.withOpacity(0.2))),
      child: Row(
        children: [
          SizedBox(
              height: Dimension.h2 * 10,
              width: Dimension.h2 * 10,
              child: Image.asset(
                  "assets/img/mdi_application-edit-outline.png")),
          SizedBox(
            width: Dimension.h8 * 3,
          ),
          Expanded(
            child: DropdownButton(
                underline: const SizedBox(
                  height: 0,
                ),
                elevation: 0,
                isExpanded: true,
                value: selectedValue,
                iconEnabledColor: AppColor.primary,
                iconSize: Dimension.h10 * 3,
                style: textTheme.labelLarge!.copyWith(
                    color: AppColor.subtitleText, fontSize: 15),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  }
                },
                items: dropdownItems),
          ),
        ],
      ),
    );
  }
}