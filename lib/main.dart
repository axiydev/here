import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:here/pages/detail_page.dart';
import 'package:here/pages/home_page.dart';
import 'package:here/pages/signin_page.dart';
import 'package:here/pages/signup_page.dart';
import 'package:here/service/prefs_service.dart';
import 'package:here/theme.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {

  StreamBuilder _startPage(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          Prefs.saveUserId(snapshot.data.uid);
          return HomePage();
        }else{
          Prefs.removeUserId();
          return SignIn();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: basicTheme(context),
      home: _startPage(),
      routes:{
        HomePage.id:(context)=>HomePage(),
        SignIn.id:(context)=>SignIn(),
        SignUp.id:(context)=>SignUp(),
        DetailPage.id:(context)=>DetailPage(),
      },
    );
  }
}

