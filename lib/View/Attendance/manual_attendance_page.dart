import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/Bloc/Attendance/attendance_bloc.dart';
import '../../core/Bloc/Leave/leave_bloc.dart';
import '../../core/Utils/base_img.dart';
import '../../data/Model/Request/manual_attendance_request.dart';
import '../../data/Model/Response/leave_apply_type_response.dart';
import '../../data/Services/attendance_service.dart';
import '../../data/Services/employee_service.dart';
import '../../data/Services/leave_service.dart';
import '../../data/Services/login_service.dart';

class ManualAttendancePage extends StatefulWidget {
  const ManualAttendancePage({Key? key}) : super(key: key);

  @override
  State<ManualAttendancePage> createState() => _ManualAttendancePageState();
}

Position? position = Position(
    longitude: 27.7172,
    latitude: 85.3240,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1);
List<Placemark>? placemarks = <Placemark>[];
String? preciseLocation = "N/A";
LatLng? latitudeLong = LatLng(27.700636, 85.312180);
loc.Location _location = loc.Location();
bool _serviceEnabled = false;

String getShortDate(DateTime timeNow) {
  DateFormat monthformatter = DateFormat('yyyy-MM-dd');
  return monthformatter.format(timeNow);
}

String getTime(DateTime timeNow) {
  DateFormat monthformatter = DateFormat('HH:mm');
  return monthformatter.format(timeNow);
}

class _ManualAttendancePageState extends State<ManualAttendancePage> {
  final _formKey = GlobalKey<FormState>();
  MapController mapController = MapController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  XFile? photo;
  Uint8List uint8listDefault = base64Decode(BaseImg.selfieGifBase64);
  Uint8List? capturedPhoto;
  final ImagePicker _picker = ImagePicker();
  String? uploadedBase64;
  late AttendanceBloc attendanceBloc;
  late LeaveBloc leaveBloc;
  LoginService loginService = LoginService(Dio());
  EmployeeService employeeService = EmployeeService(Dio());
  AttendanceService attendanceService = AttendanceService(Dio());
  LeaveService leaveService = LeaveService(Dio());
  late SharedPreferences preferences;
  List<LeaveApplyTypeResponse> leavePersonList = <LeaveApplyTypeResponse>[];
  List<String> leavePerson = <String>[];
  int LeaveApplyToId = 0;
  File? _scannedImage;

  Future initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initializePreference();
    checkLocationPermission();
    leaveBloc = LeaveBloc(loginService, leaveService);
    attendanceBloc =
        AttendanceBloc(loginService, employeeService, attendanceService);
    dateController.text = getShortDate(DateTime.now());
    timeController.text = getTime(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future checkLocationPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        await checkLocationPermission();
      }
    }

    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        EasyLoading.show(status: "Getting Location");
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        if (position != null) {
          latitudeLong = LatLng(position!.latitude, position!.longitude);
        }
        await geocodeOfLongLat();
        EasyLoading.dismiss();
      } else if (status.isDenied) {
        Map<Permission, PermissionStatus> status =
            await [Permission.location, Permission.camera].request();
        EasyLoading.show(status: "Getting Location");
        await checkLocationPermission();
        EasyLoading.dismiss();
      }
    } else {
      Map<Permission, PermissionStatus> status =
          await [Permission.location, Permission.camera].request();
      EasyLoading.show(status: "Getting Location");
      await checkLocationPermission();
      EasyLoading.dismiss();
    }
    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    }
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    if (await Permission.camera.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future geocodeOfLongLat() async {
    placemarks = await placemarkFromCoordinates(
        position!.latitude, position!.longitude,
        localeIdentifier: "ne_NP");
    locationController.text = placemarks!.isNotEmpty
        ? "${placemarks![0].name!}, ${placemarks![1].name!}, ${placemarks![2].name!}\n${placemarks![3].street!}, ${placemarks![3].country!}"
        : "N/A";
    EasyLoading.dismiss();
    leaveBloc.add(LoadLeaveTypeandPerson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => attendanceBloc,
      child: BlocListener<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is ManualAttendanceRequestSuccessful) {
            EasyLoading.showSuccess("Attendance request successful");
            Navigator.pop(context);
          }
          if (state is ManualAttendanceRequestFailed) {
            EasyLoading.showError("Failed to request");
          }
        },
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.primary,
            elevation: 0.0,
            title: Text(
              localization.manual_attendance,
              style: const TextStyle(fontSize: 16.0),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.date,
                          style: const TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: dateController,
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                          enabled: false,
                          showCursor: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.primary),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            prefixIcon: Icon(
                              Icons.date_range,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.time,
                          style: const TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: timeController,
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
                          enabled: false,
                          showCursor: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.primary),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            prefixIcon: Icon(
                              Icons.access_time,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.remarks,
                          style: const TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: remarksController,
                            maxLines: 1,
                            showCursor: false,
                            style: const TextStyle(
                                fontSize: 12, color: AppColor.titleText),
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
                              hintText: localization.elevtricity_down,
                              hintStyle: const TextStyle(
                                  fontSize: 12, color: AppColor.lightText),
                              prefixIcon: const Icon(
                                Icons.short_text,
                                size: 20,
                              ),
                            ),
                            validator: (remarks) {
                              if (remarks == null || remarks == "") {
                                return localization
                                    .please_enter_remark_for_attendance;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.location,
                          style: const TextStyle(
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: locationController,
                          enabled: true,
                          maxLines: 2,
                          showCursor: false,
                          enableInteractiveSelection: false,
                          style: const TextStyle(
                              fontSize: 12, color: AppColor.lightText),
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
                            prefixIcon: const Icon(
                              Icons.location_pin,
                              size: 20,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.refresh_rounded,
                                size: 20,
                              ),
                              onPressed: () async {
                                EasyLoading.show(
                                    status: localization.geocoding_location);
                                await checkLocationPermission();
                                EasyLoading.dismiss();
                                EasyLoading.showSuccess(
                                    localization.location_refresh_success);
                              },
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width,
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                            screenSize: MediaQuery.of(context).size,
                            center:
                                LatLng(position!.latitude, position!.longitude),
                            zoom: 14,
                            maxZoom: 18),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: const ['a', 'b', 'c'],
                            tileProvider: NetworkTileProvider(),
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(
                                    position!.latitude, position!.longitude),
                                width: 50,
                                height: 50,
                                builder: (context) => const Icon(
                                  Icons.location_pin,
                                  color: AppColor.attentionText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 90,width: 90,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: BlocBuilder<LeaveBloc, LeaveState>(
                        bloc: leaveBloc..add(LoadLeaveTypeandPerson()),
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
                                print("xbwucvuiiiiidddd ${leavePersonList[leavePerson
                                        .indexOf(selected.toString())]
                                    .id!}");
                                LeaveApplyToId = leavePersonList[leavePerson
                                        .indexOf(selected.toString())]
                                    .id!;
                                leaveBloc.add(LoadLeaveTypeandPerson());
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
                    InkWell(
                      onTap: () async {
                        photo = await _picker.pickImage(
                            source: ImageSource.camera,
                            maxHeight: 600,
                            maxWidth: 600,
                            imageQuality: 70,
                            preferredCameraDevice: CameraDevice.front);
                        if (photo != null) {
                          capturedPhoto = await photo!.readAsBytes();
                          uploadedBase64 = base64Encode(capturedPhoto!);
                        }
                        setState(() {});
                        // openImageScanner(context);
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width,
                        child: Image.memory(capturedPhoto ?? uint8listDefault),
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
                          if (_formKey.currentState!.validate()) {
                            if (uploadedBase64 == null ||
                                uploadedBase64 == "") {
                              return EasyLoading.showError(
                                  localization.upload_required_doc);
                            }
                            ManualAttendanceRequest manualAttendanceRequest =
                                ManualAttendanceRequest(
                              employeeId: preferences.getInt("EMPID"),
                              attendanceDate: getShortDate(DateTime.now()),
                              attendanceTime: getTime(DateTime.now()),
                              reason: remarksController.text,
                             
                              location:
                                  "${position!.longitude},${position!.latitude}",
                              file: uploadedBase64,
                            );
                            attendanceBloc.add(ManualAttendanceClicked(
                                manualAttendanceRequest));
                          }
                        }),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
