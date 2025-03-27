import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';

import '../../main.dart';

class UserProfile extends StatefulWidget {
  final String userId;
  final String username;

  const UserProfile({super.key, required this.username, required this.userId});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _followersCount = 0; // Store the count of followers

  @override
  void initState() {
    super.initState();
    fetchFollowers(); // Fetch followers when widget loads
  }

  // Function to get followers count
  Future<int> getFollowersCount(String userId) async {
    try {
      QuerySnapshot followersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('followers')
          .get();

      print(followersSnapshot );
      return followersSnapshot.size; // Returns the count of followers
    } catch (e) {
      print("Error getting followers count: $e");
      return 0; // Return 0 in case of error
    }
  }

  // Function to fetch followers and update UI
  void fetchFollowers() async {
    int count = await getFollowersCount(widget.userId);
    setState(() {
      _followersCount = count; // Update UI with new count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ClrConstant.whiteColor),
        backgroundColor: ClrConstant.primaryColor,
        title: Text(
          "Profile",
          style: TextStyle(
              color: ClrConstant.whiteColor, fontWeight: FontWeight.w900),
        ),
      ),
      backgroundColor: ClrConstant.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: width * 0.175,
                      backgroundColor: ClrConstant.primaryColor,
                    ),
                    Text(
                      widget.username,
                      style: TextStyle(
                          color: ClrConstant.blackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: width * 0.05),
                    )
                  ],
                ),
                Container(
                  height: height * 0.075,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      color: ClrConstant.whiteColor,
                      borderRadius: BorderRadius.circular(width * 0.03),
                      border: Border.all(
                          color: ClrConstant.primaryColor,
                          width: width * 0.005)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '$_followersCount', // Updated follower count
                          style: TextStyle(
                              color: ClrConstant.blackColor,
                              fontWeight: FontWeight.w700,
                              fontSize: width * 0.05),
                        ),
                        Text("followers"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                sectionBox("Gallery"),
                SizedBox(height: height * 0.05),
                sectionBox("Events"),
                SizedBox(height: height * 0.05),
                sectionBox("Favorites"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionBox(String title) {
    return Container(
      height: height * 0.1,
      width: width * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.05),
          color: ClrConstant.whiteColor,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                color: ClrConstant.blackColor.withOpacity(0.1),
                blurRadius: width * 0.03,
                spreadRadius: width * 0.003)
          ]),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: width * 0.04),
        ),
      ),
    );
  }
}
