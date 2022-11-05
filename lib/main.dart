import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
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
  firebase_auth.FirebaseAuth firebaseAuth =firebase_auth.FirebaseAuth.instance;

  @override
  Widget build (BuildContext context){
    return MaterialApp(
      home: SignInPage(),
    );
  }
}

