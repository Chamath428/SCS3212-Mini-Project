import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mini_project/pages/Home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final storage = new FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async{
    try{
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount!=null) {
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        try {
          UserCredential userCredential = await auth.signInWithCredential(
              credential);
          storeTokenAndData(userCredential);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (builder)=>HomePage()),
                  (route) => false);
        } catch (e) {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      else{
        final snackBar = SnackBar(content: Text("Something went wrong while siging!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    }catch(e){
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void storeTokenAndData(UserCredential userCredential) async {
    print("storing token and data");
    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await storage.write(
        key: "usercredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    } catch (e) {
      // final snackBar = SnackBar(content: Text(e.toString()));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}