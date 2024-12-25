import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/home/screens/events.dart';
import 'package:kalakaar_admin/home/screens/homepage.dart';
import 'package:kalakaar_admin/home/screens/report_page.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';
import '../screens/users.dart';


class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}
class _CustomNavBarState extends State<CustomNavBar> {

  int currentIndex=0;
   // bool isNavBarVisible = true;
  final FocusNode focusNode = FocusNode();

  List<Widget> pages = [
    Homepage(),
    Users(),
    EventsPage(),
    ReportPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.whiteColor,
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
          color: ClrConstant.primaryColor,
          items: [
            Icon(Icons.home),
            Icon(Icons.group),
            Icon(Icons.event,),
            Icon(Icons.report,),
      ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        height: height * 0.075,
        backgroundColor: ClrConstant.whiteColor,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
