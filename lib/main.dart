
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/firebase_options.dart';
import 'package:kalakaar_admin/home/login/stream_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp( MyApp());
}

var height;
var width;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     height=MediaQuery.of(context).size.height;
     width=MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamPage()
    );
  }
}

