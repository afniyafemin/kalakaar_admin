import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';

import 'chatpage.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample user data
    final List<Map<String, String>> users = [
      {"name": "John Doe", "avatar": ImgConstant.fav1}, // Replace with actual asset paths
      {"name": "Jane Smith", "avatar": ImgConstant.fav2},
      {"name": "Alice Johnson", "avatar": ImgConstant.fav3},
      {"name": "Bob Brown", "avatar": ImgConstant.fav4},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages',
        style: TextStyle(
          color: ClrConstant.whiteColor,
          fontWeight: FontWeight.w800,

        ),),
        backgroundColor: ClrConstant.primaryColor,
      ),
      body: ListView.separated(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(users[index]["avatar"]!),
            ),
            title: Text(users[index]["name"]!),
            onTap: () {
              // Navigate to the user's chat page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserChatPage(user: users[index]),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: ClrConstant.primaryColor,
          );
        },
      ),
    );
  }
}
