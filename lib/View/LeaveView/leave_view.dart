import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrm/View/LeaveView/leave_balance.dart';
import 'package:hrm/View/LeaveView/leave_history.dart';

import '../../core/Styles/app_color.dart';

class LeaveView extends StatefulWidget {
  const LeaveView({super.key});

  @override
  State<LeaveView> createState() => _LeaveViewState();
}

class _LeaveViewState extends State<LeaveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
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
          "Leave",
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
          Container(
            margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
            padding: const EdgeInsets.all(20),
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(blurRadius: 1)],
            ),
            child: ListTile(
              leading: const ImageIcon(
                AssetImage('assets/img/history.png'),
                color: AppColor.headingText,
                size: 30,
              ),
              title: Text(
                "Leave History",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    color: AppColor.headingText),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LeaveHistory()));
              },
              trailing: const ImageIcon(
                AssetImage(
                  'assets/img/arrowf.png',
                ),
                color: AppColor.headingText,
                size: 30,
              ),
            ),
          ),
          CustomTile(
            child: ListTile(
              leading: const ImageIcon(
                AssetImage('assets/img/blc.png'),
                color: AppColor.headingText,
                size: 30,
              ),
              title: Text(
                "Leave Balance",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    color: AppColor.headingText),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LeaveBalance()));
              },
              trailing: const ImageIcon(
                AssetImage(
                  'assets/img/arrowf.png',
                ),
                color: AppColor.headingText,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final dynamic child;
  const CustomTile({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
        padding: const EdgeInsets.all(20),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(blurRadius: 1)],
        ),
        child: child);
  }
}
