import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  Future<List<Map<String, dynamic>>> fetchReports() async {
    List<Map<String, dynamic>> reports = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('reports').get();

      reports = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add the document ID to the data
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching reports : $e');
    }
    return reports; // Return the list of reports
  }

  Future<String> fetchUsername(String userId) async {
    String username = "Unknown User";
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        username = userDoc.data()?['username'] ?? "Unknown User";
      }
    } catch (e) {
      print('Error fetching username: $e');
    }
    return username; // Return the username
  }

  void _showActionDialog(BuildContext context, Map<String, dynamic> report) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Actions for ${report['reportedUser Id']}"),
          content: Text("Choose an action:"),
          actions: [
            TextButton(
              onPressed: () {
                // Logic for issuing a warning
                _issueWarning(report['reportedUser Id']);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Warning"),
            ),
            TextButton(
              onPressed: () {
                // Logic for removing the user
                _removeUser (report['reportedUser Id']);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Remove"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _issueWarning(String userId) async {
    // Logic to issue a warning to the user
    print("Warning issued to user: $userId");
  }

  Future<void> _removeUser (String userId) async {
    // Logic to remove the user from the system
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      print("User  $userId has been removed.");
    } catch (e) {
      print("Error removing user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Get width
    double height = MediaQuery.of(context).size.height; // Get height

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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchReports(), // Fetch reports from Firestore
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No reports available.'));
            }

            final reports = snapshot.data!;

            return FutureBuilder<List<String>>(
              future: Future.wait(reports.map((report) => fetchUsername(report['reportedUser Id']))),
              builder: (context, usernameSnapshot) {
                if (usernameSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (usernameSnapshot.hasError) {
                  return Center(child: Text('Error fetching usernames: ${usernameSnapshot.error}'));
                }

                final usernames = usernameSnapshot.data!;

                return ListView.separated(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.report, color: ClrConstant.primaryColor),
                      title: Text(
                        "${usernames[index]} got reported",
                        style: TextStyle(fontSize: width * 0.045),
                      ),
                      subtitle: Text(reports[index]["reason"] ?? "No Description", style: TextStyle(fontSize: width * 0.035)),
                      onTap: () {
                        _showActionDialog(context, reports[index]); // Show action dialog on tap
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: ClrConstant.primaryColor);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Detailed Report Page
class ReportDetailPage extends StatelessWidget {
  final Map<String, dynamic> report;

  const ReportDetailPage
      ({super.key, required this.report});

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
                foregroundColor: ClrConstant.whiteColor,
                backgroundColor: ClrConstant.primaryColor,
              ),
              child: Text("Download Report"),
            ),
          ],
        ),
      ),
    );
  }
}