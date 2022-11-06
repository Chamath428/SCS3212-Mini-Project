import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Services/authServer.dart';
import 'package:mini_project/pages/Profile.dart';
import 'package:mini_project/pages/Resip.dart';
import 'package:mini_project/pages/ResipCard.dart';
import 'package:mini_project/pages/Signup.dart';
import 'package:mini_project/pages/ViewResip.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("todo").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text(
                "Monday 21",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder)=>AddResip()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent
                ),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
              label: "add",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>ViewProfile()));
              },
              child: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
            ),
              label: "settings",
          ),
        ],
      ),

      body: StreamBuilder(
        stream: _stream,
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
            itemBuilder: (context,index){
                Map<String,dynamic>  documnet = (snapshot.data! as QuerySnapshot).docs[index].data() as Map<String,dynamic>;
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>ViewResip(document: documnet,id:(snapshot.data! as QuerySnapshot).docs[index].id)));
                  },
                  child: ResipCard(
                    title: (documnet['title']==null)?"No title set":documnet['title'],
                    check: false,
                    time: "12.00 PM",
                  ),
                );
            },
          );
        },
      ),

    );
  }
}
