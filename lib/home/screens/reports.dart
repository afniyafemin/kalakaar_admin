
import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../main.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}


class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(width*0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height*0.06,
              width: width*0.8,
              decoration: BoxDecoration(
                color: ClrConstant.primaryColor,
                borderRadius: BorderRadius.circular(width*0.03)
              ),
              child: Center(child: Text("Reports",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),))
            ),
            SizedBox(height: height*0.03,),
            Expanded(
              child: GridView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: height*0.1,
                    width: width*0.5,
                    decoration: BoxDecoration(
                        color: ClrConstant.primaryColor,
                        border: Border(left: BorderSide(color: Colors.white))
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: height*0.1,
                                width: width*0.3,
                                decoration: BoxDecoration(
                                    color: ClrConstant.whiteColor,
                                    border: Border(bottom:BorderSide(color: ClrConstant.blackColor))
                                ),
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: width*0.03,
                                      backgroundColor: ClrConstant.primaryColor,
                                    ),
                                    title:Text("user name") ,
                                  ),
                                ),
                              );
                            },

                          ),
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:1,childAspectRatio: 1),),
            )
          ],
        ),
      ),
    );
  }
}
