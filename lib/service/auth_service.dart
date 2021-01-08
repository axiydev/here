import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:here/pages/signin_page.dart';
import 'package:here/service/prefs_service.dart';

class AuthService{
  static final _auth=FirebaseAuth.instance;
  static Future<FirebaseUser> signInUser(BuildContext context,email,password)async{
    try{
      _auth.signInWithEmailAndPassword(email:email, password:password);
      final FirebaseUser user=await _auth.currentUser();
      print(user.toString());
      return user;
    }catch(e){
      print(e);
    }
    return null;
  }

  static Future<FirebaseUser> signUpUser(BuildContext context,name,email,password)async{
    try{
      var authUser=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=authUser.user;
      print(user.toString());
      return user;
    }catch(e){
      print(e);
    }
    return null;
  }
  static void signOutUser(BuildContext context){
    _auth.signOut();
    Prefs.removeUserId().then((value){
      Navigator.pushReplacementNamed(context, SignIn.id);
    });
  }
}