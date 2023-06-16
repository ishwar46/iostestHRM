import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrm/View/Home/home_page.dart';

import '../../core/Styles/app_color.dart';
import '../Leave/leave_application.page.dart';

class ApplicationPageNew extends StatefulWidget {
  const ApplicationPageNew({super.key});

  @override
  State<ApplicationPageNew> createState() => _ApplicationPageNewState();
}

class _ApplicationPageNewState extends State<ApplicationPageNew> {
  //List of Application
  List<String> items = [
    'Leave Application',
    'Punch Request',
    'Official Visit',
    'Late/Early Approval',
  ];

  List<IconData> icons = [
    Icons.calendar_today,
    Icons.favorite,
    Icons.thumb_up,
    Icons.check_circle,
  ];
  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.primary,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: Text(
          localization.applications,
          style: const TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Row(
                children: [
                  Icon(
                    icons[index],
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      items[index],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.primary,
                    ),
                    onPressed: () {
                      if (index == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LeaveApplicationPage()));
                      } else if (index == 1) {
                        Navigator.pushNamed(context, '/page2');
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
