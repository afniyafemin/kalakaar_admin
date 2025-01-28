import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/home/screens/event_details.dart';
import '../../constants/color_constant.dart';
import '../../constants/image_constant.dart';
import '../../main.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  Future<List<Map<String, dynamic>>> _fetchEvents() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('events').get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['documentId'] = doc.id; // Include document ID
        return data;
      }).toList();
    } catch (e) {
      debugPrint("Error fetching events: $e");
      return []; // Return an empty list on error
    }
  }

  Future<void> _deleteEvent(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('events').doc(documentId).delete();
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  void _showDeleteConfirmation(String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ClrConstant.whiteColor,
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to remove this event?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text("Cancel", style: TextStyle(color: ClrConstant.primaryColor)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                _deleteEvent(documentId); // Call delete function
                setState(() {}); // Refresh the UI
              },
              child: Text("Remove", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ClrConstant.primaryColor,
        title: Text(
          "Events",
          style: TextStyle(
            color: ClrConstant.whiteColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No events found."));
          }

          final events = snapshot.data!;

          return ListView.separated(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final event = events[index];
              String formattedDate;
              if (event['date'] is Timestamp) {
                formattedDate = event['date'].toDate().toString();
              } else {
                formattedDate = event['date'] ?? 'No Date';
              }
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetails(
                        eventId: event['eventId'] ?? 'N/A',
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: width*0.05, // Adjust the radius as needed
                  backgroundColor: ClrConstant.primaryColor,
                  backgroundImage: event['imageUrl'] != null
                      ? NetworkImage(event['imageUrl'])
                      : AssetImage(ImgConstant.event1) as ImageProvider,
                ),
                title: Text(
                  '''${event['title']}''' ?? 'No Name',
                  style: TextStyle(
                    fontSize: width*0.04, // Adjust the font size as needed
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: width*0.03, // Adjust the font size as needed
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _showDeleteConfirmation(event['documentId']); // Show confirmation dialog
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10); // Adjust the spacing as needed
            },
          );
        },
      ),
    );
  }
}