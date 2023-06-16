import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/Styles/app_color.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  List<String> dropDownItems = ['Head Office ', 'Branch office '];
  List<String> employeeItems = [
    'Bikrant Basyal',
    'Ishwar Thakur',
    'Anusha Subedi',
    'Raju Shah',
    'Sandeep Thapa'
  ];
  String? selectedItem;
  String? employee;

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
          "Leave History",
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
              style: const TextStyle(fontSize: 20, color: Colors.black),
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _fromDateController,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context, _fromDateController);
                  },
                  decoration: const InputDecoration(
                    labelText: "From Date",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary, width: 2),
                    ),
                  ),
                )),
                SizedBox(width: MediaQuery.of(context).size.width / 10),
                Expanded(
                    child: TextField(
                  controller: _toDateController,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context, _toDateController);
                  },
                  decoration: const InputDecoration(
                    labelText: "To Date",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.bottomRight,
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
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Name",
                  style: styleText,
                ),
                Text(
                  "From",
                  style: styleText,
                ),
                Text(
                  "To",
                  style: styleText,
                ),
                Text(
                  "Leave Type",
                  style: styleText,
                ),
                Text(
                  "Status",
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
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Ishwar Thakur",
                    style: text,
                  ),
                  Text(
                    "2023/02/03",
                    style: text,
                  ),
                  Text(
                    "2023/02/06",
                    style: text,
                  ),
                  Text(
                    "Sick Leave",
                    style: text,
                  ),
                  Image.asset(
                    'assets/img/check.png',
                    scale: 3,
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  final styleText = const TextStyle(color: AppColor.bgColor);
  final text = const TextStyle(color: Colors.black);

  bool showAdditionalInfo = false;

  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      controller.text = formattedDate;
    }
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }
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
