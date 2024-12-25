import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';
import 'package:kalakaar_admin/home/bottom_navigation_bar/custom_nav_bar.dart';
import 'package:kalakaar_admin/home/screens/users_list.dart';
import 'package:kalakaar_admin/services/fetch_data.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';
import '../../services/fetch_admin_data.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  var selected_category;
  var selected_index;

  List<Map<String, String>> categories = [
    {
      "name": "Dancing",
      "img": ImgConstant.dancing
    },
    {
      "name": "Instrumental Music",
      "img": ImgConstant.instrumental_music
    },
    {
      "name": "Malabar Arts",
      "img": ImgConstant.malabar
    },
    {
      "name": "Ritual Arts",
      "img": ImgConstant.martial
    },
    {
      "name": "Western",
      "img": ImgConstant.western
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ClrConstant.primaryColor,
        title: Text("Users",
          style: TextStyle(
              color: ClrConstant.whiteColor,
              fontWeight: FontWeight.w800
          ),),
        centerTitle: true,
      ),
      backgroundColor: ClrConstant.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01),
                child: Center(
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.9,
                    child: TextFormField(
                      cursorHeight: width * 0.05,
                      cursorColor: ClrConstant.primaryColor,
                      decoration: InputDecoration(
                        fillColor: ClrConstant.primaryColor.withOpacity(0.5),
                        filled: true,
                        labelText: "Search here",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ClrConstant.blackColor,
                          fontSize: width * 0.04,
                        ),
                        prefixIcon: Icon(Icons.search, size: width * 0.05),
                        //contentPadding: EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide(color: ClrConstant.blackColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Categories List
              Container(
                height: height * 0.75, // Adjust height as needed
                width: width * 1,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        selected_index = index;
                        selected_category = categories[selected_index]["name"];
                        fetchData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UsersList()),
                        );
                      },
                      child: Container(
                        height: height * 0.08,
                        child: Center(
                          child: ListTile(
                            title: Text(
                              categories[index]["name"]!,
                              style: TextStyle(fontSize: width * 0.045), // Adjust font size
                            ),
                            leading: CircleAvatar(
                              radius: width * 0.075, // Adjust avatar size
                              backgroundImage: AssetImage(categories[index]["img"]!),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: ClrConstant.primaryColor);
                  },
                  itemCount: categories.length,
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}