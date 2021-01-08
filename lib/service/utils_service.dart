import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static void fireToast(String text){
    Fluttertoast.showToast(
      msg:text,
      toastLength: Toast.LENGTH_SHORT,
      gravity:ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
      fontSize: 16,
    );

  }
}