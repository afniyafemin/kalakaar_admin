import 'package:flutter/material.dart';
import 'package:kalakaar_admin/constants/color_constant.dart';

import '../../main.dart';
import '../../services/fetch_data.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {

  @override
  void initState(){
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.whiteColor,
      body: data.isEmpty? Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
          child: DataTable(
            sortAscending: true,
            columnSpacing: width*0.1,
              headingTextStyle: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: width*0.01
              ),
              headingRowColor: WidgetStatePropertyAll(ClrConstant.primaryColor),
              columns: [
                DataColumn(label: Text("Sl no")),
                DataColumn(label: Text("user name")),
                DataColumn(label: Text("email")),
                DataColumn(label: Text("location")),
                DataColumn(label: Text("ratings")),
                DataColumn(label: Text("messages")),
              ],
            rows: data.map((item) {
              return DataRow(cells: [
                DataCell(Text(item['sl no'].toString())),
                DataCell(Text(item['username'].toString())),
                DataCell(Text(item['email'].toString())),
                DataCell(Text(item['location'].toString())),
                DataCell(Text(item['Ratings'].toString())),
                DataCell(Text(item['messages'].toString())),
              ]);
            },).toList()
          )
      ),
    );
  }
}
