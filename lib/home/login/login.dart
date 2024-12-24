
import 'package:flutter/material.dart';
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
                   decoration: InputDecoration(
                     fillColor: ClrConstant.primaryColor,
                     label: Text("Username",
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
                   obscureText: pass?true:false,
                   obscuringCharacter: "*",
                   maxLength: 8,
                   decoration: InputDecoration(
                     focusColor: ClrConstant.whiteColor,
                     counterText: " ",
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
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>SideBarXScreen(),));
                setState(() {

                });
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
