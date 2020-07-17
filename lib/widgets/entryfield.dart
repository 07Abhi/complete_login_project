import 'package:flutter/material.dart';
import '../constant/constants.dart';
class EntryField extends StatelessWidget {
  String hintext;
  TextInputType typeofentry;
  bool hidden;
  Function data;
  final textController;

  EntryField({this.hintext, this.typeofentry,this.hidden=false,this.data,this.textController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: KtextFieldInput.copyWith(
        hintText: hintext,
      ),
      controller: textController,
      obscureText: hidden,
      keyboardType: typeofentry,
      onChanged: data,
    );
  }
}
