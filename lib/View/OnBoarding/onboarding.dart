import 'package:flutter/material.dart';
import 'package:hrm/core/Styles/app_color.dart';
import 'package:hrm/View/Login/login_page.dart';
import 'package:introduction_slider/introduction_slider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _introKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      key: _introKey,
      items: [
        IntroductionSliderItem(
            title: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Welcome to the Uranus HRM   \n       Mobile Application",
                style: titleStyle,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Welcome aboard the HR Management Mobile App! Streamline your HR experience with easy access to tools and features. Your privacy and security are our top priorities. Enjoy!",
                style: bodyStyle,
              ),
            ),
            logo: const Image(image: AssetImage('assets/img/b1.png'))),
        IntroductionSliderItem(
          logo: const Image(image: AssetImage('assets/img/b2.png')),
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Employee Profile",
              style: titleStyle,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "View and update your personal information, including contact details, emergency contacts, and employment history. You can also upload a profile picture to personalize your account.",
              style: bodyStyle,
            ),
          ),
        ),
        IntroductionSliderItem(
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Attendance Tracking",
              style: titleStyle,
            ),
          ),
          logo: const Image(
            image: AssetImage("assets/img/b3.png"),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Log your daily attendance by checking in and out using the app. You can view your attendance history and receive alerts for late arrivals or early departures.",
              style: bodyStyle,
            ),
          ),
        ),
        IntroductionSliderItem(
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Payroll and Compensation",
              style: titleStyle,
            ),
          ),
          logo: const Image(image: AssetImage("assets/img/b4.png")),
          subtitle: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Access your pay stubs, tax documents, and compensation details securely. Stay up-to-date with salary revisions, bonuses, and incentives.",
              style: bodyStyle,
            ),
          ),
        )
      ],
      done: const Done(
          child: Text(
            "Get Started",
            style: TextStyle(color: AppColor.primary, fontSize: 25),
          ),
          home: LoginPage()),
      // showStatusBar: true,
      next: const Next(
          child: Icon(
        Icons.arrow_forward_ios,
        color: AppColor.primary,
      )
          // child: Text(
          //   "Next",
          //   style: titleStyle,
          // ),
          ),
      dotIndicator: const DotIndicator(
          size: 10,
          selectedColor: Colors.white,
          unselectedColor: AppColor.primary),
      back: const Back(
          child: Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
      )),
    );
  }

  final bodyStyle = const TextStyle(fontSize: 14, color: AppColor.bgText);
  final titleStyle = const TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.bgText);
}
