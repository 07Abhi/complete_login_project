import 'package:flutter/material.dart';
const KredTextStyle = TextStyle(
  color: Color(0xffd4140f),
  fontWeight: FontWeight.bold,
  fontSize: 30.0,
  fontFamily: 'Ubuntu',
);
const KtextFieldInput = InputDecoration(
  hintText: 'Entry Field',
  hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Ubuntu'),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);