import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  String email = '';
  String password = '';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('UniMate'),
              // center the title
              centerTitle: true,
              // change the color of the app bar
              backgroundColor: Colors.amber,
              // change the color of the text in the app bar
              foregroundColor: Colors.grey[900],
              // remove the back button
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Form(
                // add automatic form validation
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    SizedBox(height: 40),
                    SvgPicture.asset(
                      'assets/svgs/undraw_login_re_4vu2.svg',
                      height: 200,
                    ),
                    Padding(
                      // add padding to the text field not to bottom
                      padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                        },
                        onChanged: (value) {
                          widget.email = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 40.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                        onChanged: (value) {
                          widget.password = value;
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      onPressed: () async {
                        int userLoggedIn =
                            await login(widget.email, widget.password);

                        if (userLoggedIn == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Welcome back!'),
                            backgroundColor: Colors.green[500],
                            // add text color
                          ));
                          // wait for 1 second
                          await Future.delayed(Duration(seconds: 1));
                          Navigator.pushNamed(context, '/student/dashboard');
                        } else if (userLoggedIn == 4) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Welcome back!'),
                            backgroundColor: Colors.green[500],
                            // add text color
                          ));
                          // wait for 1 second
                          await Future.delayed(Duration(seconds: 1));
                          Navigator.pushNamed(context, '/lecturer/dashboard');
                        } else if (userLoggedIn == 1) {
                          print('No user found for that email.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("No user found for that email."),
                            backgroundColor: Colors.red[500],
                          ));
                        } else if (userLoggedIn == 2) {
                          print('Wrong password provided for that user.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Email or password is incorrect."),
                            backgroundColor: Colors.red[500],
                          ));
                        } else {
                          print(userLoggedIn);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Something went wrong."),
                            backgroundColor: Colors.red[500],
                            // add text color
                          ));
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      child: Text('Create an account as a student'),
                      style: TextButton.styleFrom(
                        primary: Colors.amber[900],
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/student/signup');
                      },
                    ),
                    TextButton(
                      child: Text('Create an account as a lecturer'),
                      style: TextButton.styleFrom(
                        primary: Colors.amber[900],
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/lecturer/signup');
                      },
                    ),
                  ],
                ),
              ),
            )));
  }

  Future<int> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Reference to the Firestore collection

      var db = FirebaseFirestore.instance;
      //
      // // Get the user role
      var userRoleData = await db
          .collection('user-roles')
          .where('email', isEqualTo: email)
          .get()
          .then((value) => value.docs[0].data()['userRole'] as String);

      // log userRoleData
      print(userRoleData);

      if (userRoleData == 'student') {
        return 0;
      } else if (userRoleData == 'lecturer') {
        return 4;
      } else {
        return 5;
      }
      // Handle the successful login

      return 0;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return 1;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 2;
      }
    }
    return 3;
  }
}
