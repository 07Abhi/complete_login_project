import 'package:flutter/material.dart';
import 'package:completeloginproject/screens/starting.dart';
import 'package:completeloginproject/screens/onboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SplashPage extends StatefulWidget {
  static const String id = 'SplashPage';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),() async{
      bool visited = await getSharedPrefrences();
      setSharedPreferences();
      if(visited){
        Navigator.pushReplacementNamed(context, StartingPage.id);
      }else{
        Navigator.pushReplacementNamed(context, OnBoardScreen.id);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 380.0,bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Authentication \nHub',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.red,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Text(
                    'Developer Inc.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //color: Color(0xffd4140f),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      fontFamily: 'Ubuntu',
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
setSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool('isLoggedIn', true);
}

getSharedPrefrences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isloggedin = preferences.getBool('isLoggedIn') ?? false;
  return isloggedin;
}
