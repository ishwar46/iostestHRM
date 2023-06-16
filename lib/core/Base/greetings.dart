import 'package:flutter/widgets.dart';

class Greetings {
  String greeting(BuildContext context) {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Morning";
    }
    if (hour < 17) {
      return "Afternoon";
    }
    return "Evening";
  }
}
