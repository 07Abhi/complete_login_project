import 'package:toast/toast.dart';
import 'package:completeloginproject/constant/constants.dart';
import 'package:completeloginproject/screens/loginpage.dart';
import 'package:completeloginproject/screens/signuppage.dart';
import 'package:flutter/material.dart';
import '../widgets/officialbutton.dart';
import '../constant/constants.dart';
import 'package:completeloginproject/screens/forgetpassword.dart';

class StartingPage extends StatefulWidget {
  static const String id = 'WelcomepageId';

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 90.0, bottom: 20.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.phone_iphone,
                size: 150.0,
                color: Color(0xffd4140f),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Say Hello To Your New App',
                textAlign: TextAlign.center,
                style: KredTextStyle,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'We are here for the development purpose.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontFamily: 'Ubuntu',
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              OfficialButton(
                btnText: 'LogIn',
                colours: Color(0xffd4140f),
                textColor: Colors.white,
                btnAction: () {
                  Toast.show('Login Window', context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.grey);
                  Navigator.pushNamed(context, LoginPage.id);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              OfficialButton(
                btnText: 'SignUp',
                textColor: Colors.white,
                colours: Colors.grey.shade700,
                btnAction: () {
                  Toast.show('SignUp Window', context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.grey);
                  Navigator.pushNamed(context, SignUpPage.id);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  Toast.show('Forget Password', context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM,
                      textColor: Colors.white,
                      backgroundColor: Colors.grey);

                  Navigator.pushNamed(context, ForgetPassword.id);
                },
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17.0,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Developer Inc.',
                    style: TextStyle(
                      color: Color(0xffd4140f),
                      fontFamily: 'Ubuntu',
                      fontSize: 18.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
