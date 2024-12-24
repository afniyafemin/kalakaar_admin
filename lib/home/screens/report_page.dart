import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Get width
    double height = MediaQuery.of(context).size.height; // Get height

    // Sample reports data
    final List<Map<String, String>> reports = [
      {
        "title": "User  Registration Report",
        "description": "Details of users registered in the last month.",
        "date": "2023-10-01",
      },
      {
        "title": "Event Participation Report",
        "description": "Summary of user participation in events.",
        "date": "2023-10-05",
      },
      {
        "title": "Feedback Report",
        "description": "User  feedback collected from recent events.",
        "date": "2023-10-10",
      },
      {
        "title": "User  Activity Report",
        "description": "Overview of user activities on the platform.",
        "date": "2023-10-15",
      },
      {
        "title": "Upcoming Events Report",
        "description": "List of events scheduled for the next month.",
        "date": "2023-10-20",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reports",
          style: TextStyle(
            color: ClrConstant.whiteColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: ClrConstant.primaryColor,
        centerTitle: true,
      ),
      backgroundColor: ClrConstant.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(width * 0.02),
        child: Column(
          children: [
            // Section for generating new report
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.02),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: ClrConstant.whiteColor,
                  backgroundColor: ClrConstant.primaryColor,
                ),
                onPressed: () {
                  // Logic to generate a new report
                  print("Generate new report");
                },
                child: Text("Generate New Report"),
              ),
            ),
            // List of reports
            Expanded(
              child: ListView.separated(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.report, color: ClrConstant.primaryColor),
                    title: Text(reports[index]["title"]!, style: TextStyle(fontSize: width * 0.045)),
                    subtitle: Text(reports[index]["description"]!, style: TextStyle(fontSize: width * 0.035)),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        // Navigate to detailed report view
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportDetailPage(report: reports[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(color: ClrConstant.primaryColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Detailed Report Page
class ReportDetailPage extends StatelessWidget {
  final Map<String, String> report;

  const ReportDetailPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Get width
    double height = MediaQuery.of(context).size.height; // Get height

    return Scaffold(
        appBar: AppBar(
          title: Text(report["title"]!),
          backgroundColor: ClrConstant.primaryColor,
        ),
        body: Padding(
        padding: EdgeInsets.all(width * 0.02),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    report["title"]!,
    style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: height * 0.02),
    Text(
    "Description: ${report["description"]!}",
    style: TextStyle(fontSize: width * 0.045),
    ),
    SizedBox(height: height * 0.02),
    Text(
    "Date: ${report["date"]!}",
    style: TextStyle(fontSize: width * 0.045),
    ),
      SizedBox(height: height * 0.02),
      // You can add more details or actions related to the report here
      Text(
        "Additional Details:",
        style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: height * 0.01),
      Text(
        "This section can include charts, graphs, or any other relevant data related to the report.",
        style: TextStyle(fontSize: width * 0.04),
      ),
      SizedBox(height: height * 0.02),
      ElevatedButton(
        onPressed: () {
          // Logic to download or export the report
          print("Download or export report");
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: ClrConstant.whiteColor, backgroundColor: ClrConstant.primaryColor,
        ),
        child: Text("Download Report"),
      ),
    ],
    ),
        ),
    );
  }
}