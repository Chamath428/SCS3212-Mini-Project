import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:mini_project/Services/authServer.dart';
import 'package:mini_project/pages/Signup.dart';

import 'Home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth =firebase_auth.FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buttonItem(
                  "assets/google.svg",
                  "Sign in with google",
                  25,
                      () async {
                    await authClass.googleSignIn(context);
                  }),
              SizedBox(
                height: 20,
              ),
              buttonItem(
                  "assets/phone.svg",
                  "Sign in with phone",
                  25,
                  (){}),
              SizedBox(
                height: 20,
              ),
              Text(
                "OR",
                style: TextStyle(color: Colors.white,fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              textFields("Enter your email",emailController,false),
              SizedBox(
                height: 20,
              ),
              textFields("Enter your password",passwordController,true),
              SizedBox(
                height: 20,
              ),
              submitButton(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignUpPage()), (route) => false);
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonItem (String path,String name,double size,Function onTap){
    return InkWell(
      onTap: (){onTap();},
      child: (
          Container(
            width: MediaQuery.of(context).size.width-60,
            height: 60,
            child:Card(
              color: Colors.black,
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      width: 1,
                      color: Colors.grey
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    path,
                    height: size,
                    width: size,
                  ),
                  SizedBox(width: 25,),
                  Text(name,style: TextStyle(color: Colors.white,fontSize: 17),),
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget textFields (String lableWord,TextEditingController controller,bool obs){
    return Container(
      width: MediaQuery.of(context).size.width-60,
      height: 60,
      child: TextFormField(
        obscureText: obs,
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        decoration: InputDecoration(
            labelText: lableWord,
            labelStyle: TextStyle(
                fontSize: 17,
                color: Colors.white
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey
                )
            )
        ),
      ),
    );
  }

  Widget submitButton(){
    return InkWell(
      onTap: ()async{
        setState(() {
          circular=true;
        });
        try{
          firebase_auth.UserCredential userCred =
          await firebaseAuth.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text);
          setState(() {
            circular=false;
          });
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (builder)=>HomePage()),
                  (route) => false);
        }catch(e){
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            circular=false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width-90,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.greenAccent
        ),
        child: Center(
          child:circular?
          CircularProgressIndicator():
          Text(
            "Sign in",
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}


