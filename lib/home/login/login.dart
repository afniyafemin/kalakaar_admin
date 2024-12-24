
import 'package:flutter/material.dart';
import 'package:kalakaar_admin/services/sign_in.dart';
import '../../constants/color_constant.dart';
import '../../main.dart';
import '../side_bar/side_bar.dart';



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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: height*0.5,
              width: width*1,
              decoration: BoxDecoration(
                // color: ClrConstant.whiteColor.withOpacity(0.65),
                borderRadius: BorderRadius.circular(width*0.03)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 TextFormField(
                   controller: emailController,
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
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                  await signin(emailController.text , passwordController.text);
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SideBarXScreen(),));
              },
              child: Container(
                height: height*0.075,
                width: width*0.2,
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
    );
  }
}
