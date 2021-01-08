import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:here/pages/signin_page.dart';
import 'package:here/service/auth_service.dart';
import 'package:here/service/prefs_service.dart';
import 'package:here/service/utils_service.dart';
import 'package:here/pages/home_page.dart';

class SignUp extends StatefulWidget {
  static final String id='signup_page';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var isLoading=false;
  var nameController=new TextEditingController();
  var emailController=new TextEditingController();
  var passController=new TextEditingController();
  _doSignUp(){
    String name=nameController.text.toString().trim();
    String email=emailController.text.toString().trim();
    String pass=passController.text.toString().trim();
    if(name.isEmpty|| email.isEmpty||pass.isEmpty) return
      setState((){isLoading=true;});
    AuthService.signUpUser(context, name, email, pass).then((firebaseUser)=>{_getFirebaseUser(firebaseUser),});
  }

  _getFirebaseUser(FirebaseUser firebaseUser)async{
    setState(() {
      isLoading=false;
    });
    if(firebaseUser!=null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
      Utils.fireToast('successfully sign up!');
    }else{
      Utils.fireToast('check your informations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Stack(
          children:[
            Container(
              padding:EdgeInsets.all(20),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  //#full name
                  TextField(
                    controller: nameController,
                    decoration:InputDecoration(
                      hintText:'Full Name',
                    ),
                  ),
                  SizedBox(height: 15,),
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
                        return _doSignUp();
                      },
                      color:Theme.of(context).buttonColor,
                      child:Text('Sign Up',style:Theme.of(context).textTheme.button.copyWith(fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Already have an account? ',style: Theme.of(context).textTheme.bodyText1,),
                      GestureDetector(
                        child: Text('SignIn',style: Theme.of(context).textTheme.bodyText1,),
                        onTap: (){
                          Navigator.pushNamed(context,SignIn.id);
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
