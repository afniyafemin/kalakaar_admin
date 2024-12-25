import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';
import '../../main.dart';
import '../../services/fetch_data.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<Map<String, dynamic>> data = []; // Initialize data
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Simulate data fetching
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    // Replace with your actual data fetching logic
    setState(() {
      data = [
        {
          'sl no': 1,
          'username': 'John Doe',
          'email': 'john@example.com',
          'location': 'New York',
          'Ratings': 5,
          'messages': 10
        },
        {
          'sl no': 2,
          'username': 'Jane Smith',
          'email': 'jane@example.com',
          'location': 'Los Angeles',
          'Ratings': 4,
          'messages': 5
        },
        // Add more sample data as needed
      ];
      isLoading = false; // Set loading to false after fetching data
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Get width
    double height = MediaQuery.of(context).size.height; // Get height

    return Scaffold(
      appBar: AppBar(
        title: Text("User  Table"),
        backgroundColor: ClrConstant.primaryColor,
      ),
      backgroundColor: ClrConstant.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(width * 0.02), // Add padding around the content
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                      height: height * 0.01), // Space between header and data
                  Expanded(
                    child: ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the user's events page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserEventsPage(
                                    username: data[index]['username']),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                //nav to event calendar
                              },
                              child: CircleAvatar(
                                radius: width * 0.05, // Adjust avatar size
                                backgroundColor: ClrConstant.primaryColor,
                                child: Icon(Icons.event),
                              ),
                            ),
                            title: Text(data[index]['username'].toString(),
                                style: TextStyle(fontSize: width * 0.035)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index]['email'].toString(),
                                    style: TextStyle(fontSize: width * 0.03)),
                                Text(data[index]['location'].toString(),
                                    style: TextStyle(fontSize: width * 0.03)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: List.generate(
                                      data[index]['Ratings'], (starIndex) {
                                    return Icon(Icons.star,
                                        color: Colors.amber,
                                        size: width * 0.04);
                                  }),
                                ),
                                SizedBox(
                                    width: width *
                                        0.02),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.message, size: width * 0.05),
                                    if (data[index]['messages'] > 0)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.8),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          constraints: BoxConstraints(
                                            minWidth: 10,
                                            minHeight: 10,
                                          ),
                                          child: Text(
                                            data[index]['messages'].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(); // Divider between list items
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// Dummy UserEventsPage for navigation
class UserEventsPage extends StatelessWidget {
  final String username;

  const UserEventsPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$username Events')),
      body: Center(child: Text('Events for $username')),
    );
  }
}
