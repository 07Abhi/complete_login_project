import 'package:flutter/material.dart';

class OfficialButton extends StatelessWidget {
  String btnText;
  Color colours;
  Color textColor;
  Function btnAction;

  OfficialButton(
      {this.btnText,
      this.colours,
      this.textColor = Colors.grey,
      this.btnAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: colours,
        onPressed: btnAction,
        elevation: 5.0,
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Ubuntu',
            color: textColor,
          ),
        ),
      ),
    );
  }
}
