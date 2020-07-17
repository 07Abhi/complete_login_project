import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import '../widgets/officialbutton.dart';
import 'package:completeloginproject/constant/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/entryfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'SignUpId';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showSpinner = false;
  String email;
  String password;
  String name;
  String mob;
  FirebaseAuth _authsignUp = FirebaseAuth.instance;
  final textNameController = TextEditingController();
  final textNumberController = TextEditingController();
  final textEmailController = TextEditingController();
  final textPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 40.0, right: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Create New Account!!',
                  style: KredTextStyle,
                ),
                SizedBox(
                  height: 50.0,
                ),
                EntryField(
                  hintext: 'Full Name',
                  typeofentry: TextInputType.text,
                  data: (value) {
                    name = value;
                  },
                  textController: textNameController,
                ),
                SizedBox(
                  height: 10.0,
                ),
                EntryField(
                  hintext: 'Mobile No.(10 Digts)',
                  typeofentry: TextInputType.number,
                  data: (value) {
                    mob = value;
                  },
                  textController: textNumberController,
                ),
                SizedBox(
                  height: 10.0,
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
                  height: 10.0,
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
                  height: 30.0,
                ),
                OfficialButton(
                  btnText: 'SignUp',
                  colours: Colors.grey.shade700,
                  textColor: Colors.white,
                  btnAction: () async {
                    if (name == null &&
                        mob == null &&
                        email == null &&
                        password == null) {
                      Toast.show('Fill all entries', context,
                          duration: Toast.LENGTH_SHORT,
                          gravity: Toast.BOTTOM,
                          textColor: Colors.white,
                          backgroundColor: Colors.grey);
                    } else {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        final registerUser =
                            await _authsignUp.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (registerUser != null) {

                          textNumberController.clear();
                          textNameController.clear();
                          textEmailController.clear();
                          textPasswordController.clear();
                          Navigator.pop(context);
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        print(e.message);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
