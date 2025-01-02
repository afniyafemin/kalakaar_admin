import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';

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
      backgroundColor: ClrConstant.whiteColor,
      body: //Text('$username'),
      Column()
    );
  }
}
