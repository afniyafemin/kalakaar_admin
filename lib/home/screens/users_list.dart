import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';
import 'package:kalakaar_admin/home/screens/users.dart';
import '../../main.dart';
import '../../services/fetch_data.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  // bool isLoading = true; // Loading state

  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsersByCategory(category_); // Fetch users based on the selected category
  }

  Future<void> fetchUsersByCategory(String category) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('category', isEqualTo: category) // Assuming 'category' is the field in Firestore
          .get();

      setState(() {
        users = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id; // Add the document ID to the data
          return data;
        }).toList();
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Get width
    double height = MediaQuery.of(context).size.height; // Get height

    return Scaffold(
      appBar: AppBar(
        title: Text(
        category_ ?? "Category", // Use null-aware operator
        style: TextStyle(
        fontWeight: FontWeight.w600,
        color: ClrConstant.whiteColor,
        fontSize: width * 0.03,
    ),
    ),
    centerTitle: true,
    backgroundColor: ClrConstant.blackColor,),
      body: Padding(
        padding: EdgeInsets.all(width * 0.02), // Add padding around the content
        child:  Column(
                children: [
                  SizedBox(
                      height: height * 0.01), // Space between header and data
                  Expanded(
                    child: ListView.separated(
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the user's events page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserEventsPage(
                                    username: users[index]['username']),
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
                            title: Text(users[index]["username"] ?? "Unknown User",
                                style: TextStyle(fontSize: width * 0.035)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(users[index]['email']??"N/A",
                                    style: TextStyle(fontSize: width * 0.03)),
                                Text(users[index]['city']??"N/A",
                                    style: TextStyle(fontSize: width * 0.03)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: (users[index]['Ratings'] != null)
                                      ? List.generate(users[index]['Ratings'], (starIndex) {
                                    return Icon(Icons.star,
                                        color: Colors.amber,
                                        size: width * 0.04);
                                  }): [Text('No Ratings')],
                                ),
                                SizedBox(
                                    width: width *
                                        0.02),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.message, size: width * 0.05),
                                    if (users[index]['messages'] != null && users[index]['messages'] > 0)
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
                                            users[index]['messages']??"N/A",
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
