import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddResip extends StatefulWidget {
  const AddResip({Key? key}) : super(key: key);

  @override
  State<AddResip> createState() => _AddResipState();
}

class _AddResipState extends State<AddResip> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String type = "";
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 28,
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "New Todo",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    lable("Task Title"),
                    SizedBox(
                      height: 15,
                    ),
                    textField(55,titleController),
                    SizedBox(
                      height: 15,
                    ),
                    lable("Task  Type"),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        selectTab("Important",0xff526eeb,true),
                        SizedBox(
                          width: 10,
                        ),
                        selectTab("Planned",0xff526eeb,true),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    lable("Description"),
                    SizedBox(
                      height: 15,
                    ),
                    textField(120,descriptionController),
                    SizedBox(
                      height: 15,
                    ),
                    lable("Category"),
                    SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      children: [
                        selectTab("Food",0xff526eeb,false),
                        SizedBox(
                          width: 20,
                        ),
                        selectTab("Work out",0xff526eeb,false),
                        SizedBox(
                          width: 20,
                        ),
                        selectTab("Work",0xff526eeb,false),
                        SizedBox(
                          width: 20,
                        ),
                        selectTab("Design",0xff526eeb,false),
                        SizedBox(
                          width: 20,
                        ),
                        selectTab("Run",0xff526eeb,false),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    submitButton(),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget lable(String lable){
    return(
      Text(
        lable,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2,
        ),
      )
    );
  }

  Widget textField(double height,TextEditingController controller){
    return Container(
        height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(158, 192, 247, 0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17
        ),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          )
        ),
      ),
      );
  }

  Widget selectTab (String lable,int color,bool isType){
    return InkWell(
      onTap: (){
        if(isType){
          setState(() {
            type=lable;
          });
        }else{
          setState(() {
            category=lable;
          });
        }
      },
      child: Chip(
        backgroundColor: (type==lable||category==lable)?Colors.red: Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          lable,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget submitButton(){
    return InkWell(
      onTap: (){
        FirebaseFirestore.instance.collection("todo").add({
          "title":titleController.text,"type":type,"description":descriptionController.text,"category":category
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.greenAccent
        ),
        child: Center(
          child: Text(
            "+ Add Todo",
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
