import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:completeloginproject/constant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:completeloginproject/widgets/officialbutton.dart';
import '../widgets/entryfield.dart';

class ForgetPassword extends StatefulWidget {
  static const String id = 'ForgetPasswordId';

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool showSpinner = false;
  String email;
  FirebaseAuth _authForgetPass = FirebaseAuth.instance;
  final textEmailController = TextEditingController();

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
            padding: EdgeInsets.only(left: 25.0, top: 40.0, right: 30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Forget Password',
                    style: KredTextStyle,
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  EntryField(
                    hintext: 'Registered Email Id',
                    typeofentry: TextInputType.emailAddress,
                    data: (value) {
                      email = value;
                    },
                    textController: textEmailController,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  OfficialButton(
                    btnText: 'Go',
                    colours: Colors.grey.shade700,
                    textColor: Colors.white,
                    btnAction: () async {
                      try {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        setState(() {
                          showSpinner = true;
                        });
                        await _authForgetPass.sendPasswordResetEmail(email: email);
                        textEmailController.clear();
                        Toast.show('Mail sent to registered email!!', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            textColor: Colors.white,
                            backgroundColor: Colors.grey);
                        Navigator.pop(context);
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        Toast.show('Some Error Occur', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM,
                            textColor: Colors.white,
                            backgroundColor: Colors.grey);
                        print(e.message);
                      }
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
