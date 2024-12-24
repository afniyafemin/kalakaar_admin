import 'package:firebase_auth/firebase_auth.dart';

Future<void> signin(String email, String password) async {
try{
UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password);
}catch(e){
  print(e);
}
}