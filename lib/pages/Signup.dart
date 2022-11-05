import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                "Sign up",
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
                  "Signup with google",
                  25),
              SizedBox(
                height: 20,
              ),
              buttonItem(
                  "assets/phone.svg",
                  "Signup with phone",
                  25),
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
              textFields("Enter your email"),
              SizedBox(
                height: 20,
              ),
              textFields("Enter your password"),
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
                    "Already a user? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonItem (String path,String name,double size){
    return(
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
    );
  }

  Widget textFields (String lableWord){
    return Container(
      width: MediaQuery.of(context).size.width-60,
      height: 60,
      child: TextFormField(
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
    return Container(
      width: MediaQuery.of(context).size.width-90,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.greenAccent
      ),
      child: Center(
        child: Text(
          "Sign up",
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}


