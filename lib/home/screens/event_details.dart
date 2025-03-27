import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kalakaar_admin/constants/image_constant.dart';
import 'package:kalakaar_admin/main.dart';
import '../../constants/color_constant.dart';
class EventDetails extends StatefulWidget {
  final String eventId;

  const EventDetails({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  String title = '';
  String description = '';
  String date = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchEventDetails();
  }

  Future<void> _fetchEventDetails() async {
    try {
      DocumentSnapshot eventDoc = await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.eventId)
          .get();

      if (eventDoc.exists) {
        var data = eventDoc.data() as Map<String, dynamic>;
        setState(() {
          title = data['title'] ?? 'No Title';
          description = data['description'] ?? 'No Description';
          date = data['date'] ?? 'No date';
          imageUrl = data['imageUrl'] ?? ImgConstant.event1; // Default image if no URL
        });
      } else {
        print('Event document does not exist.');
      }
    } catch (e) {
      print('Error fetching event details: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ClrConstant.primaryColor,
        iconTheme: IconThemeData(color: ClrConstant.whiteColor),
        title: Text(
          title,
          style: TextStyle(
              color: ClrConstant.whiteColor,
            fontWeight: FontWeight.w900
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(width*0.03),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*0.01,),
            Center(
              child: Container(
                height: height*0.4,
                width: width*0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width*0.03),
                  boxShadow: [
                    BoxShadow(
                      color: ClrConstant.primaryColor,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 2
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(imageUrl), // Use the fetched image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.02,),
            Divider(
              color: ClrConstant.primaryColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: width*0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: width*0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: width*0.0325),
                ),
                SizedBox(height: 16),
                Text(
                  "Date:",
                  style: TextStyle(
                    fontSize: width*0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(fontSize: width*0.035),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}