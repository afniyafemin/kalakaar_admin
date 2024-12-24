import 'package:firebase_auth/firebase_auth.dart';

Future<void> signin(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Successfully signed in
    print("User  signed in: ${userCredential.user?.email}");
  } on FirebaseAuthException catch (e) {
    // Handle error
    print("Error: ${e.message}");
  }
}