import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {

  final ImagePicker _picker = ImagePicker();
  XFile? image=null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: getImage(),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  submitButton(),
                  IconButton(
                      onPressed: () async{
                        image = await _picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          image=image;
                        });
                      },
                      icon: Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.teal,
                        size: 30,
                      ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider getImage(){
    if(image!=null){
      return FileImage(File(image!.path));
    }
    return AssetImage("assets/profile.jpg");
  }

  Widget submitButton(){
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width/2,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.greenAccent
        ),
        child: Center(
          child: Text(
            "Add Picture",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15
            ),
          ),
        ),
      ),
    );
  }
}
