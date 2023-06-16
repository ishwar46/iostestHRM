import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hrm/core/Styles/app_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Bloc/Leave/leave_bloc.dart';
import '../../core/Utils/base_img.dart';
import '../../data/Model/Request/leave_application_request.dart';
import '../../data/Model/Response/leave_apply_type_response.dart';
import '../../data/Services/leave_service.dart';
import '../../data/Services/login_service.dart';

class LeaveRequestPage extends StatefulWidget {
  const LeaveRequestPage({Key? key}) : super(key: key);

  @override
  State<LeaveRequestPage> createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final _formKeySubject = GlobalKey<FormState>();
  final _formKeyReason = GlobalKey<FormState>();
  late LeaveBloc _leaveBloc;
  late TextEditingController _subjectController;
  late TextEditingController _reasonController;
  final LoginService loginService = LoginService(Dio());
  final LeaveService leaveService = LeaveService(Dio());
  NepaliDateTime _fromSelectedDateTime = NepaliDateTime.now();
  NepaliDateTime _toSelectedDateTime = NepaliDateTime.now();
  List<LeaveApplyTypeResponse> leavetypesList = <LeaveApplyTypeResponse>[];
  List<String> leaveTypes = <String>[];
  List<LeaveApplyTypeResponse> leavePersonList = <LeaveApplyTypeResponse>[];
  List<String> leavePerson = <String>[];
  String? LeaveType;
  int LeaveApplyToId = 0;
  int LeaveTypeId = 0;
  bool isHalf = false;

  late SharedPreferences preferences;
  XFile? photo;
  Uint8List uint8list = base64Decode(BaseImg.selfieGifBase64);
  Uint8List? capturedPhoto;
  final ImagePicker _picker = ImagePicker();
  String? uploadedBase64;

  setHalfOrFull(int index) {
    if (index != null) {
      if (index == 0) {
        isHalf = true;
      } else if (index == 0) {
        isHalf = false;
      }
    } else {
      isHalf = false;
    }
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initializePreference();
    _subjectController = TextEditingController();
    _reasonController = TextEditingController();
    _leaveBloc = LeaveBloc(loginService, leaveService);
    super.initState();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  getShortDateTime(DateTime datetime) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    var formattedDate = dateFormat.format(datetime);
    return formattedDate;
  }

  bool isPhotoUploadVisible(String leaveType) {
    if (leaveType == "Sick Leave") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => _leaveBloc..add(LoadLeaveTypeandPerson()),
      child: BlocListener<LeaveBloc, LeaveState>(
        listener: (context, state) {
          if (state is LeaveRequestSuccessful) {
            EasyLoading.showSuccess(localization.leave_request_success,
                duration: const Duration(seconds: 5), dismissOnTap: true);
          }
          if (state is LeaveRequestFailed) {
            EasyLoading.showError(state.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.primary,
            elevation: 0.0,
            title: Text(
              localization.leave_requests,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
            toolbarHeight: 40,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: BlocBuilder<LeaveBloc, LeaveState>(
                          bloc: _leaveBloc..add(LoadLeaveTypeandPerson()),
                          builder: (context, state) {
                            if (state is LeaveTypesDetailsLoaded) {
                              if (leavetypesList.isNotEmpty) {
                                leavetypesList.clear();
                                leaveTypes.clear();
                              }
                              leavetypesList = state.leaveApplyTypeList;
                              for (var items in state.leaveApplyTypeList) {
                                leaveTypes.add(items.name!);
                              }
                              return DropDown(
                                isExpanded: true,
                                showUnderline: false,
                                icon: const Icon(Icons.arrow_drop_down),
                                hint: Text(
                                  localization.select_leave_type,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                                dropDownType: DropDownType.Button,
                                items: leaveTypes,
                                onChanged: (selected) {
                                  //_leaveBloc.add(LoadLeaveSummaryDetails());
                                  LeaveType = selected.toString();
                                  LeaveTypeId = leavetypesList[leaveTypes
                                          .indexOf(selected.toString())]
                                      .id!;
                                  _leaveBloc.add(LoadLeaveTypeandPerson());
                                  setState(() {});
                                },
                              );
                            }
                            if (state is LeaveTypeLoadFailed) {
                              return Container();
                            }
                            return Container();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: _formKeySubject,
                        child: TextFormField(
                          controller: _subjectController,
                          maxLines: 1,
                          showCursor: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.primary),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            hintText: localization.subject,
                            hintStyle: const TextStyle(
                                fontSize: 12, color: AppColor.lightText),
                            prefixIcon: const Icon(
                              Icons.short_text,
                              size: 20,
                            ),
                          ),
                          validator: (subject) {
                            if (subject == null || subject == "") {
                              return localization
                                  .please_enter_application_subject;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.primary),
                                borderRadius: BorderRadius.circular(10)),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  localization.from,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'productSans',
                                      color: AppColor.primary),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      _fromSelectedDateTime =
                                          (await showMaterialDatePicker(
                                        context: context,
                                        initialDate: NepaliDateTime.now(),
                                        firstDate: NepaliDateTime.now(),
                                        lastDate: NepaliDateTime(2090),
                                      ))!;
                                      _leaveBloc.add(LoadLeaveTypeandPerson());
                                      setState(() {});
                                    } catch (ex) {}
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range_outlined,
                                        color: AppColor.primary,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        _fromSelectedDateTime
                                            .format("yyyy" '/' "M" '/' "d"),
                                        style: const TextStyle(
                                            fontFamily: 'productSans',
                                            fontSize: 14.0,
                                            color: AppColor.primary),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.primary),
                                borderRadius: BorderRadius.circular(10)),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  localization.to,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'productSans',
                                      color: AppColor.primary),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      _toSelectedDateTime =
                                          (await showMaterialDatePicker(
                                        context: context,
                                        initialDate: NepaliDateTime.now(),
                                        firstDate: NepaliDateTime.now(),
                                        lastDate: NepaliDateTime(2090),
                                      ))!;
                                      _leaveBloc.add(LoadLeaveTypeandPerson());
                                      setState(() {});
                                    } catch (ex) {}
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range_outlined,
                                        color: AppColor.primary,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        _toSelectedDateTime
                                            .format("yyyy" '/' "M" '/' "d"),
                                        style: const TextStyle(
                                            fontFamily: 'productSans',
                                            fontSize: 14.0,
                                            color: AppColor.primary),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ToggleSwitch(
                        activeBgColor: const [
                          AppColor.primary,
                        ],
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: AppColor.subtitleText,
                        minWidth: MediaQuery.of(context).size.width,
                        initialLabelIndex: 1,
                        totalSwitches: 2,
                        labels: const ['Half', 'Full'],
                        onToggle: (index) {
                          setHalfOrFull(index!);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: _formKeyReason,
                        child: TextFormField(
                          controller: _reasonController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: localization.reason,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.primary),
                            ),
                            hintStyle: const TextStyle(
                                fontSize: 14, color: AppColor.lightText),
                          ),
                          validator: (subject) {
                            if (subject == null || subject == "") {
                              return localization.reason_cannot_be_empty;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: BlocBuilder<LeaveBloc, LeaveState>(
                          bloc: _leaveBloc..add(LoadLeaveTypeandPerson()),
                          builder: (context, state) {
                            if (state is LeaveTypesDetailsLoaded) {
                              if (leavePersonList.isNotEmpty) {
                                leavePersonList.clear();
                                leavePerson.clear();
                              }
                              leavePersonList = state.leaveApplyPersonList;
                              for (var items in state.leaveApplyPersonList) {
                                leavePerson.add(items.name!);
                              }
                              return DropDown(
                                isExpanded: true,
                                showUnderline: false,
                                icon: const Icon(Icons.arrow_drop_down),
                                hint: Text(
                                  localization.apply_to,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                                dropDownType: DropDownType.Button,
                                items: leavePerson,
                                onChanged: (selected) {
                                  //_leaveBloc.add(LoadLeaveSummaryDetails());
                                  LeaveApplyToId = leavePersonList[leavePerson
                                          .indexOf(selected.toString())]
                                      .id!;
                                },
                              );
                            }
                            if (state is LeaveTypeLoadFailed) {
                              return Container();
                            }
                            return Container();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Visibility(
                        visible: isPhotoUploadVisible(LeaveType ?? "N/A"),
                        child: InkWell(
                          onTap: () async {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(
                                            Icons.photo_camera_front_outlined),
                                        title: Text(localization.camera),
                                        onTap: () async {
                                          photo = await _picker.pickImage(
                                              source: ImageSource.camera,
                                              maxHeight: 600,
                                              maxWidth: 600,
                                              imageQuality: 70,
                                              preferredCameraDevice:
                                                  CameraDevice.front);
                                          if (photo != null) {
                                            Navigator.pop(context);
                                            capturedPhoto =
                                                await photo!.readAsBytes();
                                            final kb =
                                                capturedPhoto!.length / 1024;
                                            final mb = kb / 1024;
                                            uploadedBase64 =
                                                base64Encode(capturedPhoto!);
                                          }
                                          _leaveBloc
                                              .add(LoadLeaveTypeandPerson());
                                          setState(() {});
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                            Icons.photo_library_outlined),
                                        title: Text(localization.gallery),
                                        onTap: () async {
                                          photo = await _picker.pickImage(
                                              source: ImageSource.gallery,
                                              maxHeight: 600,
                                              maxWidth: 600,
                                              imageQuality: 70);
                                          if (photo != null) {
                                            Navigator.pop(context);
                                            capturedPhoto =
                                                await photo!.readAsBytes();
                                            uploadedBase64 =
                                                base64Encode(capturedPhoto!);
                                          }
                                          _leaveBloc
                                              .add(LoadLeaveTypeandPerson());
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 2,
                            width: MediaQuery.of(context).size.width,
                            child: Image.memory(capturedPhoto ?? uint8list),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.primary),
                            fixedSize: MaterialStateProperty.all<Size>(
                                const Size(380, 40)),
                          ),
                          child: Text(
                            localization.request,
                            style: const TextStyle(
                                fontSize: 12.0,
                                fontFamily: 'productSans',
                                color: AppColor.whiteText),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            if (LeaveType == "Sick Leave") {
                              if (_formKeySubject.currentState!.validate()) {
                                if (_formKeyReason.currentState!.validate()) {
                                  if (uploadedBase64 == "" ||
                                      uploadedBase64 == null) {
                                    return EasyLoading.showError(
                                        localization.upload_required_doc);
                                  }
                                }
                              }
                            }
                            if (_formKeySubject.currentState!.validate()) {
                              if (_formKeyReason.currentState!.validate()) {
                                LeaveApplicationRequest
                                    leaveApplicationRequest =
                                    LeaveApplicationRequest(
                                        employeeId: preferences.getInt("EMPID"),
                                        recomendTo: LeaveApplyToId,
                                        leaveTypeId: LeaveTypeId,
                                        subject: _subjectController.text,
                                        discription: _reasonController.text,
                                        leaveSubmitDate: getShortDateTime(
                                            _fromSelectedDateTime.toDateTime()),
                                        requestDate:
                                            getShortDateTime(DateTime.now()),
                                        fromdate: getShortDateTime(
                                            _fromSelectedDateTime.toDateTime()),
                                        toDate: getShortDateTime(
                                            _toSelectedDateTime.toDateTime()),
                                        halfDay: isHalf,
                                        isActive: true,
                                        file: uploadedBase64 ?? "");
                                _leaveBloc.add(
                                    LeaveRequestClick(leaveApplicationRequest));
                                Navigator.of(context).pop();
                              }
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
