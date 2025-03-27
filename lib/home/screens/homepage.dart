import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/home/screens/events.dart';
import 'package:kalakaar_admin/home/screens/users.dart';
import '../../constants/color_constant.dart';
import '../../services/fetch_admin_data.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int userCount = 0;
  int eventCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    listenForNewUsers();
  }

  Future<void> fetchData() async {
    try {
      final userSnapshot = await FirebaseFirestore.instance.collection('users').get();
      final eventSnapshot = await FirebaseFirestore.instance.collection('events').get();

      setState(() {
        userCount = userSnapshot.docs.length;
        eventCount = eventSnapshot.docs.length;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void listenForNewUsers() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          var newUser = change.doc.data() ?? {};
          String userId = change.doc.id;
          String userName = newUser['username'] ?? 'Unknown User';
          String joinedTime = DateTime.now().toLocal().toString();

          FirebaseFirestore.instance.collection('notifications').add({
            'message': "New User: $userName joined on $joinedTime",
            'timestamp': FieldValue.serverTimestamp(),
            'userId': userId,
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ClrConstant.whiteColor,
      appBar: AppBar(
        backgroundColor: ClrConstant.primaryColor,
        title: FutureBuilder<String?>(
          future: fetchAdminData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }
            else {
              return Text("Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: ClrConstant.whiteColor
                ),
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.02),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: ClrConstant.primaryColor, width: 3),
                borderRadius: BorderRadius.circular(width * 0.03),
                color: ClrConstant.primaryColor.withOpacity(0.8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Overview",
                    style: TextStyle(
                      color: ClrConstant.blackColor,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Users",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w900,
                                color: ClrConstant.blackColor.withOpacity(0.25),
                              )),
                          Text(userCount.toString(),
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Events",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w900,
                                color: ClrConstant.blackColor.withOpacity(0.25),
                              )),
                          Text(eventCount.toString(),
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  Users()),
                    );
                  },
                  child: Container(
                    height: height*0.15,
                      width: width*0.75,
                      decoration: BoxDecoration(
                        color: ClrConstant.primaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(width*0.05),
                        border: Border.all(
                          color: ClrConstant.primaryColor,
                          width: width*0.01
                        )
                      ),
                      child: Center(child: Text("Manage Users",
                        style: TextStyle(
                          color: ClrConstant.whiteColor,
                          fontWeight: FontWeight.w800,
                          fontSize: width*0.04
                        ),
                      ))
                  ),
                ),
                SizedBox(height: height*0.03,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EventsPage()),
                    );
                  },
                  child: Container(
                      height: height*0.15,
                      width: width*0.75,
                      decoration: BoxDecoration(
                          color: ClrConstant.primaryColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(width*0.05),
                          border: Border.all(
                              color: ClrConstant.primaryColor,
                              width: width*0.01
                          )
                      ),
                      child: Center(child: Text("Manage Events",
                        style: TextStyle(
                            color: ClrConstant.whiteColor,
                            fontWeight: FontWeight.w800,
                            fontSize: width*0.04
                        ),
                      ))
                  ),
                ),
              ],
            ),
            SizedBox(height: height*0.05,)


            // SizedBox(height: height * 0.02),
            // Expanded(
            //   child: Container(
            //     padding: EdgeInsets.all(width * 0.05),
            //     decoration: BoxDecoration(
            //       border: Border.all(color: ClrConstant.primaryColor, width: 2),
            //       borderRadius: BorderRadius.circular(8),
            //       color: Colors.white,
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Notifications",
            //           style: TextStyle(
            //             color: ClrConstant.primaryColor,
            //             fontSize: width * 0.05,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         Expanded(
            //           child: StreamBuilder<QuerySnapshot>(
            //             stream: FirebaseFirestore.instance
            //                 .collection('notifications')
            //                 .orderBy('timestamp', descending: true)
            //                 .snapshots(),
            //             builder: (context, snapshot) {
            //               if (!snapshot.hasData) {
            //                 return const Center(child: CircularProgressIndicator());
            //               }
            //
            //               final notifications = snapshot.data!.docs;
            //
            //               return ListView.builder(
            //                 itemCount: notifications.length,
            //                 itemBuilder: (context, index) {
            //                   final notification = notifications[index];
            //                   final message = notification['message'];
            //                   final notificationId = notification.id;
            //
            //                   return Dismissible(
            //                     key: Key(notificationId),
            //                     onDismissed: (direction) {
            //                       FirebaseFirestore.instance
            //                           .collection('notifications')
            //                           .doc(notificationId)
            //                           .delete();
            //
            //                       ScaffoldMessenger.of(context).showSnackBar(
            //                         const SnackBar(
            //                             content: Text("Notification dismissed")),
            //                       );
            //                     },
            //                     background: Container(color: ClrConstant.primaryColor),
            //                     child: ListTile(
            //                       leading: Icon(Icons.person_add,
            //                           color: ClrConstant.primaryColor),
            //                       title: Text(message),
            //                     ),
            //                   );
            //                 },
            //               );
            //             },
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),


          ],
        ),
      ),
    );
  }
}
