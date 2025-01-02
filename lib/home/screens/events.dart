import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/home/screens/event_details.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

var click = true;

class _EventsPageState extends State<EventsPage> {

  List<Map<String,dynamic>> events = [];

  void initState(){
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('events').get();
      setState(() {
        events = querySnapshot.docs.map((doc) {
          // Include the document ID in the event map
          final data = doc.data() as Map<String, dynamic>;
          data['documentId'] = doc.id; // Add the document ID to the data
          return data;
        }).toList();
      });
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  Future<void> _deleteEvent(int index) async {
    try {
      // Get the document ID from the event at the given index
      String documentId = events[index]['documentId'];

      await FirebaseFirestore.instance.collection('events').doc(documentId).delete();
      setState(() {
        events.removeAt(index);
      });
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ClrConstant.primaryColor,
        title: Text("Events",
        style: TextStyle(
          color: ClrConstant.whiteColor,
          fontWeight: FontWeight.w800
        ),),
        centerTitle: true,
      ),
      body: Column(
        children: [

          Expanded(
            child: ListView.separated(
                    itemCount: events.length,
                    itemBuilder: (BuildContext context, int index) {
                      final event = events[index];
                      String formattedDate;
                      if (event['date'] is Timestamp) {
                        formattedDate = event['date'].toDate().toString() ?? 'No Date';
                      } else {
                        formattedDate = event['date'] ?? 'No Date'; // Use the string value if not a timestamp
                      }
                      return ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> EventDetails(title: event['title'] ?? 'No Title',
                            description: event['description'] ?? 'No Description',
                            date: formattedDate,)));
                        },
                        leading: CircleAvatar(
                          radius: width * 0.05, // Adjust avatar size
                          backgroundColor: ClrConstant.primaryColor,
                        ),
                        title: Text(
                          event['title'] ?? 'No Name',
                          style: TextStyle(
                            fontSize: width * 0.04, // Adjust font size
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              event['description'] ?? "no description",
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                _deleteEvent(index);
                              },
                              child: Icon(Icons.cancel),
                            ),
                            SizedBox(width: width * 0.03),

                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: height * 0.01);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
