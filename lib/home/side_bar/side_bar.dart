
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/services/fetch_admin_data.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';
import '../screens/users.dart';


class SideBarXScreen extends StatefulWidget {
  const SideBarXScreen({Key? key}) : super(key: key);

  @override
  State<SideBarXScreen> createState() => _SideBarXScreenState();
}

class _SideBarXScreenState extends State<SideBarXScreen> {
  late SidebarXController _controller;

  PageController pageController = PageController();
  int _currentIndex = 0;
  List<Widget> Pages = [
    Users(),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellowAccent,
    )
  ];
  @override
  void initState() {
    super.initState();
    _controller = SidebarXController(selectedIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String?>(
          future: fetchAdminData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }else if (snapshot.hasError) {
              return Center(child: Text("Error : ${snapshot.hasError}"),);
            }  else if (snapshot.hasData) {
              return Text("${snapshot.hasData}");
            }else{
              return Center(child: Text("no admin data found"));
            }
          },
        )
        ),
      body: Row(
        children: [
          SidebarX(
            controller: _controller,
            extendedTheme: SidebarXTheme(
                width: width*0.125,
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                hoverTextStyle: TextStyle(
                    color: ClrConstant.whiteColor.withOpacity(0.4)
                )// Adjust the expanded width here
            ),
            theme: SidebarXTheme(
              padding: EdgeInsets.only(top: height*0.03),
              decoration: BoxDecoration(
                color: ClrConstant.primaryColor,
              ),
              width: width*0.06,
              itemTextPadding: EdgeInsets.only(left: width*0.01),
              selectedItemTextPadding: EdgeInsets.only(left: width*0.01),
              textStyle: TextStyle(color: Colors.white),
              selectedTextStyle: TextStyle(color: ClrConstant.whiteColor),
              iconTheme: IconThemeData(color: Colors.black),
              selectedIconTheme:
              IconThemeData(
                  color: ClrConstant.whiteColor),
            ),
            items: [
              SidebarXItem(
                label: 'Events',
                icon: Icons.event,
                onTap: () {
                  pageController.animateToPage(0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              SidebarXItem(
                label: 'Users',
                icon: Icons.group,
                onTap: () {
                  pageController.animateToPage(1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);

                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              SidebarXItem(
                label: 'Reports',
                icon: Icons.report,
                onTap: () {
                  pageController.animateToPage(2,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);

                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                _controller.selectIndex(value);
              },
              controller: pageController,
              children: List.generate(
                Pages.length,
                (index) => Pages[index],
              ),
            ),
          )
          // ))
        ],
      ),
    );
  }
}
