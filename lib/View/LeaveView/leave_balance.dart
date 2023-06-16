import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/Styles/app_color.dart';

class LeaveBalance extends StatefulWidget {
  const LeaveBalance({super.key});

  @override
  State<LeaveBalance> createState() => _LeaveBalanceState();
}

class _LeaveBalanceState extends State<LeaveBalance> {
  List<String> dropDownItems = ['Head Office ', 'Branch office '];
  List<String> employeeItems = [
    'Bikrant Basyal',
    'Ishwar Thakur',
    'Anusha Subedi',
    'Raju Shah',
    'Sandeep Thapa'
  ];
  List<String> leaveTypeItems = ['Sick Leave', 'Casual Leave', 'ManLagi Leave'];
  List<String> yearItems = ['2020', '2021', '2022', '2023'];
  String? year;
  String? selectedItem;
  String? employee;
  String? leave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColor.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/img/back.png',
            width: 12,
          ),
        ),
        title: Text(
          "Leave Balance",
          style: GoogleFonts.montserrat(
              fontSize: 23,
              letterSpacing: 1.5,
              color: AppColor.primary,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomContainer(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            height: 60,
            width: double.infinity,
            child: DropdownButton(
              style: const TextStyle(fontSize: 20, color: AppColor.primary),
              alignment: Alignment.center,
              value: selectedItem,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.primary,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue!;
                });
              },
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    "Select Office ",
                    style: TextStyle(color: AppColor.black, fontSize: 20),
                  ),
                ),
                ...dropDownItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList()
              ],
              itemHeight: 50,
              iconSize: 30,
              elevation: 0,
              underline: const SizedBox(
                height: 0,
              ),
              isExpanded: true,
            ),
          ),
          CustomContainer(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            child: DropdownButton(
              style: const TextStyle(fontSize: 20, color: AppColor.primary),
              alignment: Alignment.center,
              value: employee,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.primary,
              ),
              onChanged: (String? value) {
                setState(() {
                  employee = value!;
                });
              },
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    " Employee Name ",
                    style: TextStyle(color: AppColor.black, fontSize: 20),
                  ),
                ),
                ...employeeItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList()
              ],
              itemHeight: 50,
              iconSize: 30,
              elevation: 0,
              underline: const SizedBox(
                height: 0,
              ),
              isExpanded: true,
            ),
          ),
          CustomContainer(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            height: 60,
            width: double.infinity,
            child: DropdownButton(
              style: const TextStyle(fontSize: 20, color: AppColor.primary),
              alignment: Alignment.center,
              value: leave,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.primary,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  leave = newValue!;
                });
              },
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    "Leave Type ",
                    style: TextStyle(color: AppColor.black, fontSize: 20),
                  ),
                ),
                ...leaveTypeItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList()
              ],
              itemHeight: 50,
              iconSize: 30,
              elevation: 0,
              underline: const SizedBox(
                height: 0,
              ),
              isExpanded: true,
            ),
          ),
          CustomContainer(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            height: 60,
            width: double.infinity,
            child: DropdownButton(
              style: const TextStyle(fontSize: 20, color: AppColor.primary),
              alignment: Alignment.center,
              value: year,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.primary,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  year = newValue!;
                });
              },
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    "Select Year ",
                    style: TextStyle(color: AppColor.black, fontSize: 20),
                  ),
                ),
                ...yearItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList()
              ],
              itemHeight: 50,
              iconSize: 30,
              elevation: 0,
              underline: const SizedBox(
                height: 0,
              ),
              isExpanded: true,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  showAdditionalInfo = true;
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(150),
                backgroundColor: AppColor.primary,
                // padding: const EdgeInsets.all(10),
              ),
              child: Text("View All", style: styleText),
            ),
          ),
          Container(
            color: AppColor.primary,
            height: 50,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Branch Name",
                  style: styleText,
                ),
                Text(
                  "Emp Name",
                  style: styleText,
                ),
                Text(
                  "Leave Type",
                  style: styleText,
                ),
                Text(
                  "Year",
                  style: styleText,
                ),
                Text(
                  "Leave Balance",
                  style: styleText,
                )
              ],
            ),
          ),
          if (showAdditionalInfo)
            Container(
              color: const Color(0xFFD6F4F9),
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(0),
              // margin: const EdgeInsets.only(left: 20, right: 20),
              // padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Main Office ",
                    style: text,
                  ),
                  Text(
                    "Ishwar Thakur",
                    style: text,
                  ),
                  Text(
                    "Casual",
                    style: text,
                  ),
                  Text(
                    "2020/05/01",
                    style: text,
                  ),
                  Row(
                    children: [
                      Container(
                        color: AppColor.bgText,
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(8),
                        child: const Text("30"),
                      ),
                      const Image(
                        image: AssetImage('assets/img/dots.png'),
                        height: 25,
                        width: 25,
                      )
                    ],
                  )
                  // Image.asset(
                  //   'assets/img/check.png',
                  //   scale: 3,
                  // )
                ],
              ),
            )
        ],
      ),
    );
  }

  bool showAdditionalInfo = false;
  final styleText = const TextStyle(color: AppColor.bgColor);
  final text = const TextStyle(color: Colors.black);
}

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final dynamic child;
  final dynamic margin;
  final dynamic padding;

  const CustomContainer(
      {super.key,
      required this.height,
      required this.width,
      this.child,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.primary, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: child,
    );
  }
}
