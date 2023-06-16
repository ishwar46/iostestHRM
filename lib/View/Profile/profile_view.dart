import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/Bloc/Profile/profile_bloc.dart';
import '../../core/Styles/app_color.dart';
import '../../data/Model/Response/employee_personal_details.dart';
import '../../data/Services/employee_service.dart';
import '../../data/Services/login_service.dart';
import '../Login/login_page.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late SharedPreferences preferences;
  late ProfileBloc profileBloc;
  final LoginService loginService = LoginService(Dio());

  final EmployeeService employeeService = EmployeeService(Dio());

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    profileBloc = ProfileBloc(loginService, employeeService);
    BlocProvider.of<ProfileBloc>(context).add(LoadMasterDetails());
    initializePreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/img/back.png',
            width: 13,
          ),
        ),
        backgroundColor: AppColor.background,
        title: Text(
          "Profile",
          style: GoogleFonts.montserrat(
              fontSize: 25,
              letterSpacing: 1.5,
              color: AppColor.primary,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await preferences.remove("TOKEN");
              await preferences.remove("REFRESHTOKEN");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: Image.asset('assets/img/logout.png'),
          ), //LogOut
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/img/setting1.png'),
          )
        ],
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is MasterDetailsLoaded) {
            EmployeePersonalDetailsResponse? employeeDetails =
                state.employeePersonalDetailsResponse;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/img/man.png'),
                            radius: 70,
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      color: AppColor.primary,
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        employeeDetails?.name ?? '',
                        style: GoogleFonts.montserrat(
                            fontSize: 20,
                            // letterSpacing: 1.5,
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        employeeDetails?.emailId ?? '',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          // letterSpacing: 1.5,
                          color: AppColor.bgText,
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primary),
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(190, 50)),
                        ),
                        child: Text(
                          "Edit Profile",
                          style: GoogleFonts.montserrat(
                              fontSize: 17,
                              // letterSpacing: 1.5,
                              color: AppColor.background,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      thickness: 0.7,
                      color: AppColor.bgText,
                    ),
                  ),
                  Row(
                    //  Contact Number
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 18),
                        child: CircleAvatar(
                          backgroundColor: AppColor.primary,
                          radius: 25,
                          child: Image.asset(
                            'assets/img/phone.png',
                            height: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: Text(
                          employeeDetails?.mobileNumber ?? "",
                          style: GoogleFonts.montserrat(
                              fontSize: 17,
                              // letterSpacing: 1.5,
                              color: AppColor.bgText,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  Row(
                    //Locatio
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 18),
                        child: CircleAvatar(
                          backgroundColor: AppColor.primary,
                          radius: 25,
                          child: Image.asset(
                            'assets/img/marker.png',
                            height: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: Text(
                          employeeDetails?.cityNameT ?? ' --- ',
                          style: GoogleFonts.montserrat(
                              fontSize: 17,
                              // letterSpacing: 1.5,
                              color: AppColor.bgText,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 18),
                        child: CircleAvatar(
                          backgroundColor: AppColor.primary,
                          radius: 25,
                          child: Image.asset(
                            'assets/img/account.png',
                            height: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: Text(
                          employeeDetails?.designationName ?? "",
                          style: GoogleFonts.montserrat(
                              fontSize: 17,
                              // letterSpacing: 1.5,
                              color: AppColor.bgText,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  Row(
                    // Position
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 18),
                        child: CircleAvatar(
                          backgroundColor: AppColor.primary,
                          radius: 25,
                          child: Image.asset(
                            'assets/img/account.png',
                            height: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: Text(
                          employeeDetails?.departmentName ?? "",
                          style: GoogleFonts.montserrat(
                              fontSize: 17,
                              // letterSpacing: 1.5,
                              color: AppColor.bgText,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "On the Web",
                              style: GoogleFonts.montserrat(
                                  fontSize: 25,
                                  // letterSpacing: 1.5,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/img/facebook.png'),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/img/insta.png'),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/img/twitter.png'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is MasterDetailsLoadFailed) {
            return const Center(
              child: Text("Failed to load data"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
