// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/core/Styles/dimension.dart';
import 'package:hrm/data/Model/Request/manual_attendance_request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/location_widget.dart';
import '../widgets/remarks_field_widget.dart';
import '../widgets/todays_date_widget.dart';

class ManualAttendanceScreen extends StatefulWidget {
  const ManualAttendanceScreen({super.key});

  @override
  State<ManualAttendanceScreen> createState() => _ManualAttendanceScreenState();
}

class _ManualAttendanceScreenState extends State<ManualAttendanceScreen> {
  ImagePicker picker = ImagePicker();
  XFile? photo;
  Uint8List? capturedPhoto;
  String? base64code;
  SharedPreferences? preferences;
  String? selectedValue;
  //remarksController.text = "Working From Home";

  Future initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    DateFormat dayformatter = DateFormat('EEEE');
    String day = dayformatter.format(DateTime.now());
    DateFormat timeformatter = DateFormat('hh:mm a');

    String time = timeformatter.format(DateTime.now());
    DateFormat dateformatter = DateFormat('d MMM, y');
    String date = dateformatter.format(DateTime.now());
    debugPrint(date);
    debugPrint(day);
    debugPrint(time);

    TextEditingController locationController = TextEditingController();

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: AppColor.whiteText,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/img/back.png",
              color: AppColor.primary,
              height: 20,
              width: 20,
            )),
        title: Text(
          "Manual Attendance",
          style: TextStyle(
              color: AppColor.primary,
              fontSize: Dimension.h10 * 2,
              fontWeight: FontWeight.w500,
              fontFamily: "nunito"),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimension.h8 * 2, vertical: Dimension.h8 * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodaysDateWidget(date: date, textTheme: textTheme, day: day),
            SizedBox(
              height: Dimension.h10 * 2,
            ),
            Text(
              "Check In Time",
              style:
                  textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: Dimension.h10,
            ),
            Container(
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
                      child: Image.asset("assets/img/carbon_time.png")),
                  SizedBox(
                    width: Dimension.h8 * 3,
                  ),
                  Text(
                    time,
                    style: textTheme.labelLarge!
                        .copyWith(color: AppColor.subtitleText, fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimension.h10 * 2,
            ),
            Text(
              "Remarks",
              style:
                  textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: Dimension.h10,
            ),
            RemarksFieldWidget(
              selectedValue: selectedValue ?? "",
            ),
            SizedBox(
              height: Dimension.h10 * 2,
            ),
            const LocationWidget(),
            SizedBox(
              height: Dimension.h10 * 2,
            ),
            ImageShowingWidget(
                picker: picker,
                photo: photo,
                capturedPhoto: capturedPhoto,
                base64code: base64code ?? ""),
            SizedBox(
              height: Dimension.h10 * 2,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  if (base64code == null || base64code == "") {
                    return EasyLoading.showError(
                        "Please upload the necessary document");
                  }
                  ManualAttendanceRequest manualAttendanceRequest =
                      ManualAttendanceRequest(
                          employeeId: preferences!.getInt("EMPID"),
                          attendanceDate: date,
                          attendanceTime: time,
                          reason: selectedValue,
                          location:
                              "${position!.longitude},${position!.latitude}",
                          file: base64code);
                },
                child: Container(
                  width: Dimension.screenWidth / 3,
                  height: Dimension.h10 * 4,
                  decoration: BoxDecoration(
                      color: AppColor.whiteText,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.primary)),
                  child: const Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                        fontFamily: "nunito",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageShowingWidget extends StatefulWidget {
  ImageShowingWidget({
    super.key,
    required this.base64code,
    required this.picker,
    required this.photo,
    required this.capturedPhoto,
  });

  ImagePicker picker;
  XFile? photo;
  Uint8List? capturedPhoto;
  String base64code;

  @override
  State<ImageShowingWidget> createState() => _ImageShowingWidgetState();
}

class _ImageShowingWidgetState extends State<ImageShowingWidget> {
  bool hasImage = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimension.screenWidth,
      height: Dimension.screenHeight / 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimension.screenWidth / 2,
            child: const Text(
              "Please Upload Your Image To Proceed Further.",
              style: TextStyle(
                  fontFamily: "nunito",
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: Dimension.h10,
          ),
          Expanded(
              child: Container(
            height: Dimension.screenWidth / 3,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 199, 219, 224),
              borderRadius: BorderRadius.circular(4),
            ),
            child: hasImage
                ? Image.memory(widget.capturedPhoto!)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: Dimension.h2 * 28,
                          width: Dimension.h2 * 28,
                          child: Image.asset(
                              "assets/img/cloud-upload-outline.png")),
                      SizedBox(
                        height: Dimension.h10,
                      ),
                      InkWell(
                        onTap: () async {
                          widget.photo = await widget.picker.pickImage(
                              source: ImageSource.camera,
                              maxHeight: 600,
                              maxWidth: 600,
                              imageQuality: 70,
                              preferredCameraDevice: CameraDevice.front);
                          if (widget.photo != null) {
                            widget.capturedPhoto =
                                await widget.photo!.readAsBytes();
                            widget.base64code =
                                base64Encode(widget.capturedPhoto!);
                            hasImage = true;
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: Dimension.h10 * 10,
                          height: Dimension.h10 * 3,
                          decoration: BoxDecoration(
                              color: AppColor.bgColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.lightText)),
                          child: const Center(child: Text("Open Camera")),
                        ),
                      ),
                    ],
                  ),
          ))
        ],
      ),
    );
  }
}
