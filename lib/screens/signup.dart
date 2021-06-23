import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String userName = '';
  String email = '';
  String password = '';
  String uid = '';

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Hey,',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  'Welcome To the TODO app.',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('Already Registered ? '),
                    RichText(
                      text: TextSpan(
                        text: 'Click Here',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
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
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
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
                          labelText: 'User Name',
                          hintText: 'Enter User Name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffF5A962)),
                              borderRadius: BorderRadius.circular(8))),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          userName = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffF3C583),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffF5A962)),
                              borderRadius: BorderRadius.circular(8))),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
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
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffF5A962)),
                              borderRadius: BorderRadius.circular(8))),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          password = value;
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
                      onPressed: () async {
                        await _auth
                            .createUserWithEmailAndPassword(
                                email: email, password: password)
                            .then((value) => _firestore
                                .collection('users')
                                .add({'email': email, 'username': userName}));

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
                          return HomePage();
                        }));;
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
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

      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     TextFormField(
      //       decoration: InputDecoration(
      //           labelText: 'User Name', hintText: 'Enter User Name'),
      //       style: TextStyle(fontWeight: FontWeight.bold),
      //       onChanged: (value) {
      //         setState(() {
      //           userName = value;
      //         });
      //       },
      //     ),
      //     TextFormField(
      //       decoration:
      //           InputDecoration(labelText: 'Email', hintText: 'Enter Email'),
      //       style: TextStyle(fontWeight: FontWeight.bold),
      //       onChanged: (value) {
      //         setState(() {
      //           email = value;
      //         });
      //       },
      //     ),
      //     TextFormField(
      //       obscureText: true,
      //       decoration: InputDecoration(
      //           labelText: 'Password', hintText: 'Enter Password'),
      //       style: TextStyle(fontWeight: FontWeight.bold),
      //       onChanged: (value) {
      //         setState(() {
      //           password = value;
      //         });
      //       },
      //     ),
      //     ElevatedButton(
      //       onPressed: () async {
      //         await _auth
      //             .createUserWithEmailAndPassword(
      //                 email: email, password: password)
      //             .then((value) => _firestore
      //                 .collection('users')
      //                 .add({'email': email, 'username': userName}));

      //         Navigator.pushNamed(context, '\home');
      //       },
      //       child: Text(
      //         'Sign Up',
      //         style:
      //             TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //       ),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.pushNamed(context, '\login');
      //       },
      //       child: Text(
      //         'Login',
      //         style:
      //             TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //       ),
      //     )
      //   ],
      // ),