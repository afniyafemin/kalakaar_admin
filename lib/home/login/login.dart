
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/home/bottom_navigation_bar/custom_nav_bar.dart';
import 'package:kalakaar_admin/services/sign_in.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
bool pass=true;
class _LoginState extends State<Login> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.blackColor,
      body: Padding(
        padding:  EdgeInsets.all(width*0.05),
        child: SingleChildScrollView(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: height*0.1,),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: ClrConstant.primaryColor,
                  filled: true,
                  label: Text("email",
                    style: TextStyle(
                      color: ClrConstant.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(
                          color: ClrConstant.primaryColor,
                          width: width*0.001
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(
                          color: ClrConstant.primaryColor,
                          width: width*0.001
                      )
                  ),
                  suffixIcon: Icon(Icons.person,color: ClrConstant.whiteColor,)
                ),
                cursorColor: ClrConstant.primaryColor,
              ),
              SizedBox(height: height*0.05,),
              TextFormField(
                controller: passwordController,
                obscureText: pass?true:false,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  focusColor: ClrConstant.whiteColor,
                  filled: true,
                  fillColor: ClrConstant.primaryColor,
                  label: Text("Password",
                    style: TextStyle(
                      color: ClrConstant.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(
                          color: ClrConstant.primaryColor,
                          width: width*0.001
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(
                          color: ClrConstant.primaryColor,
                          width: width*0.001
                      )
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        pass=!pass;
                      });
                    },
                      child: Icon(pass?Icons.visibility_off:Icons.visibility,color: ClrConstant.whiteColor,)
                  )
                ),
                cursorColor: ClrConstant.primaryColor,
              ),
              SizedBox(height: height*0.3,),
              GestureDetector(
                  onTap: () async {
                    if (emailController.text == "kalakaaradmin@gmail.com" && passwordController.text == "adminkalakaaradmin") {
                      await signin(emailController.text, passwordController.text);
                      // Navigate to the admin dashboard or sidebar
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomNavBar()));
                    } else {
                      // Show error message for incorrect credentials
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid admin credentials")));
                    }
                  },
                child: Container(
                  height: height*0.06,
                  width: width*0.35,
                  decoration: BoxDecoration(
                    color: ClrConstant.primaryColor,
                    borderRadius: BorderRadius.circular(width*0.05)
                  ),
                  child: Center(child: Text("Login",
                    style: TextStyle(
                      color: ClrConstant.whiteColor,
                      fontWeight: FontWeight.w800
                    ),
                  ),),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
