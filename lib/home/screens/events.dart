import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../main.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}
var click=true;
bool pass=true;

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          children: [
            Stack(
                children: [
                  InkWell(
                  onTap: () {
                    click=!click;
                    setState(() {

                    });
                  },
                  child: AnimatedContainer(
                    height: height*0.075,
                    width: width*1,
                    color: ClrConstant.blackColor,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(child: Text("Requested" ,style: TextStyle(fontWeight: FontWeight.w500,
                            color:ClrConstant.whiteColor.withOpacity(0.5)))),
                        //SizedBox(width: width*0.4,),
                        Center(child: Text("Scheduled" ,style: TextStyle(fontWeight: FontWeight.w500,
                            color:ClrConstant.whiteColor.withOpacity(0.5)))),
                      ],
                    ),
                  ),
                ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left:click?width*0.45:width*0.00 ,
                    right:click?width*0.00:width*0.45 ,
                    child: InkWell(
                      onTap: () {
                        click=!click;
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => animation?EventPage():UploadPage()));
                        setState(() {

                        });
                      },
                      child: AnimatedContainer(
                          height: height*0.075,
                          width: width*0.6,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: ClrConstant.primaryColor
                          ),
                          child: Center(child: Text(click?"Scheduled":"Requested" ,style: TextStyle(fontWeight: FontWeight.w700,
                              color:ClrConstant.whiteColor)))
                      ),
                    ),
                  )
                ]
                  ),
        click?
        Container(
          child: Expanded(
            child: ListView.separated(
              itemCount: 20,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading:CircleAvatar(
                    radius: width*0.03,
                    backgroundColor: ClrConstant.primaryColor,
                  ) ,
                  title: Text("Event Name",
                    style: TextStyle(
                        fontSize: width*0.015,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Event Description",
                        style: TextStyle(
                            fontSize: width*0.01,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text("Date and Time",
                        style: TextStyle(
                          fontSize: width*0.01,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox()
                    ],
                  ),
                  trailing: Icon(Icons.location_on),
                );
              },
              separatorBuilder: (BuildContext context, int index) {return SizedBox(height: height*0.01,); },


            ),
          ),
        ):
        Container(
          child: Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading:CircleAvatar(
                    radius: width*0.03,
                    backgroundColor: ClrConstant.primaryColor,
                  ) ,
                  title: Text("Event Name",
                    style: TextStyle(
                        fontSize: width*0.015,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Event Description",
                        style: TextStyle(
                            fontSize: width*0.01,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      Text("Date and Time",
                        style: TextStyle(
                            fontSize: width*0.01,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox()
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: (){

                        },
                          child: Icon(Icons.cancel)
                      ),
                      SizedBox(width: width*0.03,),
                      InkWell(
                        onTap : (){

                        },
                          child: Icon(Icons.add_box)
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {return SizedBox(height: height*0.01,); },


            ),
          ),
        )
          ],
        ),
    );
  }
}
