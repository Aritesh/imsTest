import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

AppBar appBarWidget({haddingText}) {
  return AppBar(
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 1,
    title: Text(
      haddingText.toString(),
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black54,
        fontWeight: FontWeight.w800,
        //  fontFamily: pCommonRegularFont,
      ),
    ),
    backgroundColor: Colors.white,
  );
}

void showToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black54);
}
