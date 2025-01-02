import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';
import 'package:kalakaar_admin/home/bottom_navigation_bar/custom_nav_bar.dart';
import 'package:kalakaar_admin/home/screens/users_list.dart';
import 'package:kalakaar_admin/home/search/search_functionality.dart';
import 'package:kalakaar_admin/services/fetch_data.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';
import '../../services/fetch_admin_data.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

List<Map> category = [
  {"img": ImgConstant.dancing, "txt": "Dancing"},
  {"img": ImgConstant.instrumental_music, "txt": "Instrumental Music"},
  {"img": ImgConstant.malabar, "txt": "Malabar Arts"},
  {"img": ImgConstant.martial, "txt": "Martial and Ritual Arts"},
  {"img": ImgConstant.western, "txt": "Western"},
];
String category_='';

class _UsersState extends State<Users> {
  var selected_category;
  var selected_index;



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
                      onTap: (){
                        showSearch(context: context, delegate: CustomSearchDelegate());
                      },
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
                        category_=category[index]["txt"];
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
                            title: Text(category[index]["txt"],
                              style: TextStyle(fontSize: width * 0.045), // Adjust font size
                            ),
                            leading: CircleAvatar(
                              radius: width * 0.075, // Adjust avatar size
                              backgroundImage: AssetImage(category[index]["img"]),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: ClrConstant.primaryColor);
                  },
                  itemCount: category.length,
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
