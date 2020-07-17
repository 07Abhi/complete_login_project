import 'package:completeloginproject/constant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';

class GoogleUser extends StatefulWidget {
  static const String id = 'GoogleScreenId';
  FirebaseAuth authSignout;
  GoogleSignIn googleSignInData;

  GoogleUser({this.authSignout, this.googleSignInData});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<GoogleUser> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Screen',
            style: TextStyle(
                color: Colors.black87, fontFamily: 'Ubuntu', fontSize: 20.0),
          ),
          automaticallyImplyLeading: false,
          leading: null,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await widget.authSignout.signOut().then((value) {
                  widget.googleSignInData.signOut();
                });
                Navigator.pop(context);
                Toast.show('Logout Successfully!!', context,
                    gravity: Toast.BOTTOM,
                    duration: Toast.LENGTH_SHORT,
                    textColor: Colors.white,
                    backgroundColor: Colors.grey);
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
              image: NetworkImage(widget.googleSignInData.currentUser.photoUrl),
            ),
            Text(
              widget.googleSignInData.currentUser.displayName,
              style: KredTextStyle,
              textAlign: TextAlign.center,
            ),
            Text(
              widget.googleSignInData.currentUser.email,
              style: TextStyle(
                  color: Colors.black45,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
