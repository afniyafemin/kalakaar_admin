
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';
import '../login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),)),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.primaryColor,
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Login(),));
          },
          child: Container(
            // color: ClrConstant.whiteColor,
            child: Center(
              child: Text("Continue",
                style: TextStyle(
                  color: ClrConstant.blackColor,
                  fontWeight: FontWeight.w800,
                  fontSize: width*0.03
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
