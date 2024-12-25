import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

var click = true;

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ClrConstant.primaryColor,
      //   title: Text("Events",
      //   style: TextStyle(
      //     color: ClrConstant.whiteColor,
      //     fontWeight: FontWeight.w800
      //   ),),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    click = !click;
                  });
                },
                child: AnimatedContainer(
                  height: height * 0.075,
                  width: width * 1,
                  color: ClrConstant.blackColor,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Text(
                          "Requested",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ClrConstant.whiteColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Scheduled",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ClrConstant.whiteColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                left: click ? width * 0.45 : width * 0.00,
                right: click ? width * 0.00 : width * 0.45,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      click = !click;
                    });
                  },
                  child: AnimatedContainer(
                    height: height * 0.075,
                    width: width * 0.6,
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: ClrConstant.primaryColor,
                      // borderRadius:
                      //     BorderRadius.circular(30), // Rounded corners
                    ),
                    child: Center(
                      child: Text(
                        click ? "Scheduled" : "Requested",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ClrConstant.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              height: height * 0.02), // Space between the toggle and the list
          Expanded(
            child: click
                ? ListView.separated(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: width * 0.05, // Adjust avatar size
                          backgroundColor: ClrConstant.primaryColor,
                        ),
                        title: Text(
                          "Event Name",
                          style: TextStyle(
                            fontSize: width * 0.04, // Adjust font size
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Event Description",
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Date and Time",
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(Icons.location_on),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: height * 0.01);
                    },
                  )
                : ListView.separated(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: width * 0.05, // Adjust avatar size
                          backgroundColor: ClrConstant.primaryColor,
                        ),
                        title: Text(
                          " Event Name",
                          style: TextStyle(
                            fontSize: width * 0.04, // Adjust font size
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Event Description",
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Date and Time",
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
                                // Handle cancel action
                              },
                              child: Icon(Icons.cancel),
                            ),
                            SizedBox(width: width * 0.03),
                            InkWell(
                              onTap: () {
                                // Handle add action
                              },
                              child: Icon(Icons.add_box),
                            ),
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
