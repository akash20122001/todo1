import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:todo/screens/login.dart';

class ShowDescription extends StatefulWidget {
  final String title;
  final String description;
  const ShowDescription({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _ShowDescriptionState createState() => _ShowDescriptionState();
}

class _ShowDescriptionState extends State<ShowDescription> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[900],
        ),
        elevation: 0,
        backgroundColor: Colors.grey[200],
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              print('logged out');
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      transitionsBuilder:
                          (context, animation, animationTime, child) {
                        return ScaleTransition(
                          scale: animation,
                          alignment: Alignment.center,
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, animationTime) {
                        return Login();
                      }));
            },
            icon: Icon(Icons.logout, color: Colors.grey[900]),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text('Your Task',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                letterSpacing: 2,
                // fontWeight: FontWeight.bold
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(30),
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: Color(0xffA2DBFA),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'Title',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffF5A962),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      widget.title,
                      style: TextStyle(color: Colors.grey[900], fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: Color(0xffF5A962),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('Description',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffA2DBFA),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      widget.description,
                      style: TextStyle(color: Colors.grey[900], fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
