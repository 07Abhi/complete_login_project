import 'package:completeloginproject/screens/userscreen.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:completeloginproject/constant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:completeloginproject/widgets/entryfield.dart';
import 'package:completeloginproject/widgets/officialbutton.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:completeloginproject/screens/facebookuserscreen.dart';
import 'package:completeloginproject/screens/googleuserpage.dart';
import 'dart:convert' as JSON;

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPageId';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;
  Map userProfile;
  String email;
  String password;
  final textEmailController = TextEditingController();
  final textPasswordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth shareduser = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email'], hostedDomain: '', clientId: '');

  Future<void> SignUpWithFacebook() async {
    try {
      var result = await _facebookLogin.logIn(['email']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        final token = result.accessToken.token;
        final graphRespone = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphRespone.body);
        
        setState(() {
          userProfile = profile;
        });
        FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
        return user;
      }
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> SignUpWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      return user;
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 40.0, right: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Sign In',
                  style: KredTextStyle,
                ),
                SizedBox(
                  height: 50.0,
                ),
                EntryField(
                  hintext: 'Email Address',
                  typeofentry: TextInputType.emailAddress,
                  data: (value) {
                    email = value;
                  },
                  textController: textEmailController,
                ),
                SizedBox(
                  height: 30.0,
                ),
                EntryField(
                  hintext: 'Password',
                  hidden: true,
                  data: (value) {
                    password = value;
                  },
                  textController: textPasswordController,
                ),
                SizedBox(
                  height: 60.0,
                ),
                OfficialButton(
                  colours: Color(0xffd4140f),
                  btnText: 'Login',
                  textColor: Colors.white,
                  btnAction: () async {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    try {
                      setState(() {
                        showSpinner = true;
                      });
                      final loginUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (loginUser != null) {
                        Toast.show('Welcome', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            textColor: Colors.white,
                            backgroundColor: Colors.grey);
                        textEmailController.clear();
                        textPasswordController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserScreen(
                              authSignout: _auth,
                            ),
                          ),
                        );
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      Toast.show('Unable To request!!', context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          textColor: Colors.white,
                          backgroundColor: Colors.grey);
                      print(e.message);
                    }
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'OR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 20.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 50.0,
                  child: FacebookSignInButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      await SignUpWithFacebook();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FacebookUser(
                            fbProfileData: userProfile,
                            fbUser: _facebookLogin,
                            authSignout: _auth,
                          ),
                        ),
                      );
                      setState(() {
                        showSpinner = false;
                      });
                    },
                    borderRadius: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 50.0,
                  child: GoogleSignInButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      await SignUpWithGoogle();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoogleUser(
                            authSignout: _auth,
                            googleSignInData: _googleSignIn,
                          ),
                        ),
                      );
                      setState(() {
                        showSpinner = false;
                      });
                    },
                    darkMode: true,
                    borderRadius: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
