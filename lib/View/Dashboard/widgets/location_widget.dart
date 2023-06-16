import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrm/core/Bloc/Leave/leave_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/textfield/custom_textfield.dart';
import '../../../data/Services/leave_service.dart';
import '../../../data/Services/login_service.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({
    super.key,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
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
LatLng? latitudeLong = LatLng(27.712020, 85.312950);
loc.Location location = loc.Location();
bool serviceEnabled = false;

class _LocationWidgetState extends State<LocationWidget> {
  TextEditingController locationController = TextEditingController();
  late LeaveBloc leaveBloc;
  LoginService loginService = LoginService(Dio());
  LeaveService leaveService = LeaveService(Dio());

  @override
  void initState() {
    super.initState();
    leaveBloc = LeaveBloc(loginService, leaveService);
    checkLocationPermission();
  }

  Future checkLocationPermission() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
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
      //  localeIdentifier: "ne_NP"
    );
    locationController.text = placemarks!.isNotEmpty
        ? "Uranus Tech Nepal Pvt.Ltd, ${placemarks![2].name!},${placemarks![3].street!}, ${placemarks![3].country!}"
        : "N/A";
    EasyLoading.dismiss();
    leaveBloc.add(LoadLeaveTypeandPerson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;

    return CustomTextField(
      label: "Location",
      hintText: "",
      ontap: () async {
        EasyLoading.show(status: localization.geocoding_location);
        await checkLocationPermission();
        EasyLoading.dismiss();
        EasyLoading.showSuccess(localization.location_refresh_success);
      },
      suffixImage: "assets/img/material-symbols_refresh.png",
      prefixImage: "assets/img/map-marker.png",
      controller: locationController,
    );
  }
}
