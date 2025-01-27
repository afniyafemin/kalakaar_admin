import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';

import '../../main.dart';

class UserProfile extends StatefulWidget {
  final String username;
  const UserProfile({super.key, required this.username});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ClrConstant.whiteColor
        ),
        backgroundColor: ClrConstant.primaryColor,
        title: Text("profile",
          style: TextStyle(
            color: ClrConstant.whiteColor,
            fontWeight: FontWeight.w900
          ),
        ),
      ),
      backgroundColor: ClrConstant.whiteColor,
      body: //Text('$username'),
      Padding(
        padding: EdgeInsets.all(width*0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: width*0.175,
                      backgroundColor: ClrConstant.primaryColor,
                    ),
                    Text(widget.username,
                      style: TextStyle(
                          color: ClrConstant.blackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: width*0.05
                      ),
                    )
                  ],
                ),
                Container(
                  height: height*0.075,
                  width: width*0.4,
                  decoration: BoxDecoration(
                      color: ClrConstant.whiteColor,
                      borderRadius: BorderRadius.circular(width*0.03),
                      border: Border.all(
                          color: ClrConstant.primaryColor,
                          width: width*0.005
                      )
                  ),
                  child: Center(
                    child: Text("n followers",
                      style: TextStyle(
                          color:ClrConstant.blackColor,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Container(
                  height: height*0.1,
                  width: width*0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.05),
                    color: ClrConstant.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,4),
                        color: ClrConstant.blackColor.withOpacity(0.1),
                        blurRadius: width*0.03,
                        spreadRadius: width*0.003
                      )
                    ]
                  ),
                  child: Center(child: Text("Gallery",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: width*0.04
                    ),
                  ),),
                ),
                SizedBox(height: height*0.05),
                Container(
                  height: height*0.1,
                  width: width*0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width*0.05),
                      color: ClrConstant.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,4),
                            color: ClrConstant.blackColor.withOpacity(0.1),
                            blurRadius: width*0.03,
                            spreadRadius: width*0.003
                        )
                      ]
                  ),
                  child: Center(child: Text("Events",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: width*0.04
                    ),
                  ),),
                ),
                SizedBox(height: height*0.05),
                Container(
                  height: height*0.1,
                  width: width*0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width*0.05),
                      color: ClrConstant.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,4),
                            color: ClrConstant.blackColor.withOpacity(0.1),
                            blurRadius: width*0.03,
                            spreadRadius: width*0.003
                        )
                      ]
                  ),
                  child: Center(child: Text("favorites",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: width*0.04
                    ),
                  ),),
                )
              ],
            ),

          ],
        ),
      )
    );
  }
}
