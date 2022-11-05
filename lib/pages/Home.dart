import 'package:flutter/material.dart';
import 'package:mini_project/Services/authServer.dart';
import 'package:mini_project/pages/Signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            authClass.signOut();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (builder)=>SignUpPage()),
                    (route) => false);
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
