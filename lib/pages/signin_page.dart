import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:here/pages/home_page.dart';
import 'package:here/pages/signup_page.dart';
import 'package:here/service/auth_service.dart';
import 'package:here/service/prefs_service.dart';
import 'package:here/service/utils_service.dart';
class SignIn extends StatefulWidget {
  static final String id='signin_page';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var isLoading=false;
  var emailController=new TextEditingController();
  var passController=new TextEditingController();
  _doSignIn()async{
    String email=emailController.text.toString().trim();
    String pass=passController.text.toString().trim();
    if(email.isEmpty||pass.isEmpty) return
      setState((){ isLoading=true;});
    AuthService.signInUser(context, email, pass).then((firebaseUser)=>{_getFirebaseUser(firebaseUser),});
  }

  _getFirebaseUser(FirebaseUser firebaseUser)async{
    setState(() {
      isLoading=false;
    });
    if(firebaseUser!=null) {
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
      Utils.fireToast('successfully signing in ');
    }else{
      Utils.fireToast('check your email or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Stack(
          children: [
            Container(
              padding:EdgeInsets.all(20),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  //#email
                  TextField(
                    controller: emailController,
                    decoration:InputDecoration(
                      hintText:'Email',
                    ),
                  ),
                  SizedBox(height: 15,),
                  //#password
                  TextField(
                    controller: passController,
                    obscureText: true,
                    decoration:InputDecoration(
                      hintText:'Password',
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 45,
                    width: double.infinity,
                    child:FlatButton(
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: (){
                        return _doSignIn();
                      },
                      color:Theme.of(context).buttonColor,
                      child:Text('Sign In',style:Theme.of(context).textTheme.button.copyWith(fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Don\'t have an account? ',style: Theme.of(context).textTheme.bodyText1,),
                      GestureDetector(
                        child: Text('SignUp',style: Theme.of(context).textTheme.bodyText1),
                        onTap: (){
                          Navigator.pushNamed(context, SignUp.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if(isLoading)Center(
              child:CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
