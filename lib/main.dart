import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:mini_project/Services/authServer.dart';
import 'package:mini_project/pages/Home.dart';
import 'package:mini_project/pages/Signin.dart';
import 'package:mini_project/pages/Signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() =>  _MyAppState();
}

class _MyAppState extends State<MyApp>{

  Widget currentPage = SignInPage();
  AuthClass  authClass = AuthClass();

  @override
  void initState(){
    super.initState();
    checkLogin();
  }

  void checkLogin()async{
    String? token = await authClass.getToken();
    if(token!=null){
      setState(() {
        currentPage=HomePage();
      });
    }
  }

  @override
  Widget build (BuildContext context){
    return MaterialApp(
      home: currentPage,
    );
  }
}

