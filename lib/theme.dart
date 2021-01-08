import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ThemeData basicTheme(BuildContext context)=>ThemeData(
  primarySwatch: Colors.deepOrange,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme:AppBarTheme(
    color:Color.fromRGBO(244, 68, 54, 1),
  ),
  textTheme:TextTheme(
    headline6: TextStyle(
      color:Colors.white,
    ),
    headline5: TextStyle(

    ),
    headline3: TextStyle(
      color: Colors.grey[900],
    ),
    headline2: TextStyle(
      color:Colors.grey[900],
    ),
    headline1: TextStyle(
      color: Colors.grey[900],
    ),
    bodyText1: TextStyle(
      color:Colors.black,
    ),
    bodyText2:TextStyle(

    ),
    button:TextStyle(
      color:Colors.white,
    ),
  ),
  buttonColor:Color.fromRGBO(244, 68, 54, 1),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(244, 68, 54, 1),
      foregroundColor: Colors.white,
      elevation: 5.0
  ),
);