import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';
import 'package:kalakaar_admin/home/screens/users_list.dart';
import 'package:kalakaar_admin/home/screens/events.dart';
import 'package:kalakaar_admin/home/screens/users.dart';
import 'package:kalakaar_admin/message/message_page.dart';
import 'package:kalakaar_admin/services/fetch_data.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';
import '../../services/fetch_admin_data.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int userCount = 0; // Placeholder for user count
  int eventCount = 0; // Placeholder for event count
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Simulate data fetching
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    // Replace with your actual data fetching logic
    setState(() {
      userCount = 10; // Example user count
      eventCount = 5; // Example event count
      isLoading = false; // Set loading to false after fetching data
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Get width
    double height = MediaQuery.of(context).size.height; // Get height

    return Scaffold(
      backgroundColor: ClrConstant.whiteColor,
      appBar: AppBar(
        backgroundColor: ClrConstant.primaryColor,
        title: FutureBuilder<String?>(
          future: fetchAdminData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              return Text("Welcome");
            } else {
              return Text("No admin data found");
            }
          },
        ),
        actions: [
          IconButton(
            icon: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.message,size: width*0.07,),
                if (eventCount > 0) // Show badge if there are unread messages
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: height*0.02,
                      width: width*0.04,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Center(
                        child: Text(
                          eventCount.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MessagePage()));
              // Handle message icon press
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.02),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: [
                    Container(
                      height: height*0.2,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ClrConstant.primaryColor, width: 3),
                        borderRadius: BorderRadius.circular(width*0.03),
                        color: ClrConstant.primaryColor.withOpacity(0.8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Overview",
                            style: TextStyle(
                              color: ClrConstant.whiteColor,
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
                                        color: ClrConstant.blackColor.withOpacity(0.25)
                                      )
                                  ),
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
                                          color: ClrConstant.blackColor.withOpacity(0.25)
                                      )
                                  ),
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
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: ClrConstant.primaryColor,
                            backgroundColor: Colors.white, // Text color
                            side: BorderSide(
                                color: ClrConstant.primaryColor), // Border color
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Users()),
                            );
                          },
                          child: Text("Manage Users"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: ClrConstant.primaryColor,
                            backgroundColor: Colors.white, // Text color
                            side: BorderSide(
                                color: ClrConstant.primaryColor), // Border color
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventsPage()),
                            );
                          },
                          child: Text("Manage Events"),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02), // Space between navigation and notifications
                    Container(
                      padding: EdgeInsets.all(width * 0.05),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ClrConstant.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notifications",
                            style: TextStyle(
                              color: ClrConstant.primaryColor,
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              height: height*0.4,
                              child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(Icons.person_add,
                                          color: ClrConstant.primaryColor),
                                      title: Text("New User: John Doe"),
                                      subtitle: Text("Joined on 2023-10-01"),
                                    );
                                  },
                                itemCount: 2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
            ),
      ),
    );
  }
}
