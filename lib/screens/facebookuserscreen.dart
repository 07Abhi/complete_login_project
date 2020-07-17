import 'package:completeloginproject/constant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FacebookUser extends StatefulWidget {
  static const String id = 'FacebookUserId';
  FirebaseAuth authSignout;
  FacebookLogin fbUser;
  Map fbProfileData;

  FacebookUser({
    this.fbProfileData,
    this.authSignout,
    this.fbUser,
  });

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<FacebookUser> {
  Future<void> signOut() async {
    //print('${widget.fbUser} our data ');
    await widget.fbUser.logOut();
    FirebaseUser user;
    widget.authSignout.signOut();
    return user = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              }
              Toast.show('Logout Successfully!!', context,
                  gravity: Toast.BOTTOM,
                  duration: Toast.LENGTH_SHORT,
                  textColor: Colors.white,
                  backgroundColor: Colors.grey);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image(
            image: NetworkImage(widget.fbProfileData['picture']['data']['url']),
          ),
          Text(
            widget.fbProfileData['name'],
            style: KredTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
