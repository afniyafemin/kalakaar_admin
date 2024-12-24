import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> fetchAdminData() async {
  User? admin = FirebaseAuth.instance.currentUser ;

  if (admin != null) {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('admin')
          .doc(admin.uid)
          .get();

      if (doc.exists) {
        return doc['email'];
      } else {
        print("User  document does not exist for UID: ${admin.uid}");
      }
    } catch (e) {
      print("Error fetching admin data: $e");
      return null;
    }
  } else {
    print("No user is currently signed in.");
  }
  return null;
}