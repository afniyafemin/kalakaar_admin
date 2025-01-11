import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/color_constant.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
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
      print('Error fetching reports: $e');
    }
    return reports; // Return the list of reports
  }

  Future<String> fetchUsername(String? userId) async {
    if (userId == null) return "Unknown User"; // Default if userId is null

    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data()?['username'] ?? "Unknown User"; // Username or default
      }
      return "Unknown User"; // User not found
    } catch (e) {
      print('Error fetching username: $e');
      return "Unknown User";
    }
  }

  Future<void> _removeReport(String reportId) async {
    try {
      await FirebaseFirestore.instance.collection('reports').doc(reportId).delete();
      print("Report $reportId has been removed.");
    } catch (e) {
      print("Error removing report: $e");
    }
  }

  Future<void> _removeUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      print("User $userId has been removed.");
    } catch (e) {
      print("Error removing user: $e");
    }
  }

  void _showActionDialog(BuildContext context, Map<String, dynamic> report, String reportedUsername, String reporterUsername) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Actions for Report"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Reported User: $reportedUsername"),
              Text("By: $reporterUsername"),
              Text("Reason: ${report['reason'] ?? 'No reason provided'}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _removeUser(report['reportedUser Id']);
                Navigator.of(context).pop();
              },
              child: Text("Remove User"),
            ),
            TextButton(
              onPressed: () {
                _removeReport(report['id']);
                Navigator.of(context).pop();
              },
              child: Text("Dismiss Report"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showReportDialog(String userId) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Report User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  labelText: "Reason for reporting",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                String reason = reasonController.text.trim();
                if (reason.isNotEmpty) {
                  await _submitReport(reason, userId);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please provide a reason.")),
                  );
                }
              },
              child: Text("Report"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitReport(String reason, String reportedUserId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance.collection('reports').add({
          'reportedUser Id': reportedUserId,
          'reporterUser Id': currentUser.uid,
          'reason': reason,
          'timestamp': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Report submitted successfully.")),
        );
      } catch (e) {
        print('Error submitting report: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error submitting report.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
          future: fetchReports(),
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

            return FutureBuilder<List<Map<String, String>>>(
              future: Future.wait(reports.map((report) async {
                final reportedUser = await fetchUsername(report['reportedUser Id']);
                final reporterUser = await fetchUsername(report['reporterUser Id']);
                return {
                  'reportedUsername': reportedUser,
                  'reporterUsername': reporterUser,
                };
              })),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (userSnapshot.hasError) {
                  return Center(child: Text('Error fetching usernames: ${userSnapshot.error}'));
                }

                final userMappings = userSnapshot.data!;

                return ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    final report = reports[index];
                    final userMap = userMappings[index];

                    return GestureDetector(
                      onTap: () {
                        _showActionDialog(
                          context,
                          report,
                          userMap['reportedUsername']!,
                          userMap['reporterUsername']!,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ClrConstant.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userMap['reportedUsername']} got reported",
                              style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "By ${userMap['reporterUsername']}",
                              style: TextStyle(fontSize: width * 0.04, color: Colors.grey[700]),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Reason: ${report['reason'] ?? 'No reason provided'}",
                              style: TextStyle(fontSize: width * 0.04),
                            ),
                          ],
                        ),
                      ),
                    );
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
