import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> fetchAdminData() async {
  User? admin = FirebaseAuth.instance.currentUser;

  if (admin != null) {
    // print("current user UID :${user.uid}");
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection(
          'admin').doc(admin.uid).get();

      if (doc.exists) {
        return doc['email'];
      } else {
        print("User document does not exist.");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  return null;
}