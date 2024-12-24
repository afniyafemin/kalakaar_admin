import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';
import 'package:kalakaar_admin/home/screens/table_screen.dart';
import 'package:kalakaar_admin/services/fetch_data.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';


class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}
List  category =["Dancing","Instrumental Music","Malabar Arts","Martial and Ritual Arts","Western""Dancing"];

class _UsersState extends State<Users> {

  var selected_category;
  var selected_index;

  List <Map<String , String>> categories =[
    {
      "name" : "dancing",
      "img" : ImgConstant.dancing
    },
    {
      "name" : "Instrumental music",
      "img" : ImgConstant.instrumental_music
    },
    {
      "name" : "Malabar Arts",
      "img" : ImgConstant.malabar
    },
    {
      "name" : "Ritual Arts",
      "img" : ImgConstant.martial
    },
    {
      "name" : "western",
      "img" : ImgConstant.western
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(width*0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //search bar
            Center(
              child: Container(
                height: height*0.06,
                width: width*0.8,
                child: TextFormField(
                  cursorHeight: width*0.015,
                  cursorColor: ClrConstant.primaryColor,
                  decoration: InputDecoration(
                    label: Text("Search here",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                          color: ClrConstant.blackColor.withOpacity(0.5),
                          fontSize: width*0.0075
                      ),

                    ),
                    prefixIcon: Icon(Icons.search,size: width*0.015,),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width*0.03),
                        borderSide: BorderSide(
                            color: ClrConstant.blackColor
                        )
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.01,),
            Container(
              height: height*0.875,
              width: width*1,
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      selected_index=index;
                      selected_category = categories[selected_index]["name"];
                      fetchData();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TableScreen(),));
                      setState(() {

                      });
                    },
                    child: Container(
                      height: height*0.1,
                      child: ListTile(
                        title: Text(categories[index]["name"]!),
                        leading: CircleAvatar(
                          radius: width*0.03,
                          backgroundImage: AssetImage(categories[index]["img"]!),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: ClrConstant.primaryColor,
                  );
                },
                itemCount: categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
