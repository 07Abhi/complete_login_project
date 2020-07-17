import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class UserScreen extends StatefulWidget {
  static const String id = 'UserScreenId';
  FirebaseAuth authSignout;
  GoogleSignIn googleSignInData;
  Map fbProfileData;
  FacebookLogin fbUser;

  UserScreen(
      {this.authSignout,
      this.fbProfileData,
      this.fbUser,
      this.googleSignInData});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future<void> signOut() async {
    //print('${widget.fbUser} our data ');
    final result = await widget.fbUser.logOut();
    FirebaseUser user;
    widget.authSignout.signOut();
    return user = null;
  }

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
                if (widget.fbUser != null) {
                  await signOut();
                } else if (widget.googleSignInData != null) {
                  await widget.authSignout.signOut().then((value) {
                    widget.googleSignInData.signOut();
                  });
                  Navigator.pop(context);
                } else {
                  widget.authSignout.signOut();
                  Navigator.pop(context);
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
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
//          Visibility(
//            visible: (widget.fbUser!=null && widget.googleSignInData!=null)?true:false,
//            child: Image(
//              image: widget.fbUser != null
//                  ? NetworkImage(widget.fbProfileData['picture']['data']['url'])
//                  : NetworkImage(widget.googleSignInData.currentUser.photoUrl),
//            ),
//          ),
//          Visibility(
//            visible: (widget.fbUser!=null && widget.googleSignInData!=null)?true:false,
//            child: Text(
//              widget.fbUser != null
//                  ? widget.fbProfileData['name']
//                  : widget.googleSignInData.currentUser.displayName,
//              style: KredTextStyle,
//              textAlign: TextAlign.center,
//            ),
//          ),
          ],
        ),
      ),
    );
  }
}
