import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/login.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  addToFireBase() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    String uid = user!.uid;
    var time = DateTime.now();
    String formattedDate = DateFormat.MMMMd().add_jm().format(time).toString();
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('myTasks')
        .doc(time.toString())
        .set({
      'title': title,
      'description': description,
      'time': time.toString(),
      'format': formattedDate
    });
  }

  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.grey[900],
          ), //change your color here
          backgroundColor: Colors.white,
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
                        }));;
              },
              icon: Icon(Icons.logout, color: Colors.grey[900]),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(35, 20, 35, 0),
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.
              // cro,

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90,
                ),
                Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  'A new Task.',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(height: 40),
                Column(children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffF3C583),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter Title',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffF5A962)),
                              borderRadius: BorderRadius.circular(8))),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 00, vertical: 20),
                    decoration: BoxDecoration(
                        color: Color(0xffDDDDDD),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter Description',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffF5A962)),
                              borderRadius: BorderRadius.circular(8))),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                  ),
                ]),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff39A2DB),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        addToFireBase();
                        Navigator.pushNamed(context, '\home');
                      },
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

//     body: Column(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     TextFormField(
//       decoration: InputDecoration(
//         labelText: 'Title',
//         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//         hintText: 'Add a Title',
//       ),
//       onChanged: (value) {
//         setState(() {
//           title = value;
//         });
//       },
//     ),
//     TextFormField(
//       decoration: InputDecoration(
//         labelText: 'Description',
//         labelStyle: TextStyle(fontWeight: FontWeight.bold),
//         hintText: 'Add a Description',
//       ),
//       onChanged: (value) {
//         setState(() {
//           description = value;
//         });
//       },
//     ),
//     ElevatedButton(
//         onPressed: () {
//           addToFireBase();
//           Navigator.pushNamed(context, '\home');
//         },
//         child: Text('Add Data'))
//   ],
// ));
