import 'package:completeloginproject/screens/facebookuserscreen.dart';
import 'package:completeloginproject/screens/forgetpassword.dart';
import 'package:completeloginproject/screens/googleuserpage.dart';
import 'package:completeloginproject/screens/loginpage.dart';
import 'package:completeloginproject/screens/userscreen.dart';
import 'package:flutter/material.dart';
import 'package:completeloginproject/screens/signuppage.dart';
import 'package:completeloginproject/screens/starting.dart';
import 'screens/splashpage.dart';
import 'screens/onboardscreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashPage.id,
      routes: {
        StartingPage.id: (context) => StartingPage(),
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => SignUpPage(),
        ForgetPassword.id:(context)=>ForgetPassword(),
        UserScreen.id:(context)=>UserScreen(),
        SplashPage.id:(context)=>SplashPage(),
        OnBoardScreen.id:(context)=>OnBoardScreen(),
        GoogleUser.id:(context)=>GoogleUser(),
        FacebookUser.id:(context)=>FacebookUser(),
      },
    );
  }
}
