import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterStudent extends StatefulWidget {
  String regNo = '';
  String name = '';
  String email = '';
  String password = '';

  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
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
                      'Student Signup',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    SizedBox(height: 40),
                    // SvgPicture.asset(
                    //   'assets/svgs/undraw_create_re_57a3.svg',
                    //   height: 200,
                    // ),
                    Padding(
                      // add padding to the text field not to bottom
                      padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Registration Number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your registration number';
                          } else if (!value.contains('/')) {
                            return 'Please enter a valid registration number';
                          }
                        },
                        onChanged: (value) {
                          widget.regNo = value;
                        },
                      ),
                    ),
                    Padding(
                      // add padding to the text field not to bottom
                      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                        },
                        onChanged: (value) {
                          widget.name = value;
                        },
                      ),
                    ),
                    Padding(
                      // add padding to the text field not to bottom
                      padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
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
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 8) {
                            return 'Please enter a password with at least 8 characters';
                          } else if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Please enter a password with at least one uppercase letter';
                          } else if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Please enter a password with at least one number';
                          } else if (!value
                              .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                            return 'Please enter a password with at least one special character';
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
                        int registerStatus = await registerStudent(widget.regNo,
                            widget.name, widget.email, widget.password);

                        if (registerStatus == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Registration successful!'),
                            backgroundColor: Colors.green[500],
                            // add text color
                          ));
                          // wait for 1 second
                          await Future.delayed(Duration(seconds: 1));
                          Navigator.pushNamed(context, '/login');
                        } else if (registerStatus == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Password is too weak.'),
                            backgroundColor: Colors.red[500],
                            // add text color
                          ));
                          // wait for 1 second
                        } else if (registerStatus == 2) {
                          print('No user found for that email.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Email is already registered."),
                            backgroundColor: Colors.red[500],
                          ));
                        } else if (registerStatus == 3) {
                          print('Wrong password provided for that user.');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Something went wrong."),
                            backgroundColor: Colors.red[500],
                          ));
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      child: Text('Already have an account? Login'),
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
                  ],
                ),
              ),
            )));
  }

  Future<int> registerStudent(
      String regNo, String name, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {
        // add user to firestore
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'userId': userCredential.user?.uid,
          'profilePic': '',
          'name': name,
          'email': email,
          'regNo': regNo,
          'role': 'student',
        });
        return 0;
      } else {
        return 3;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 1;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 2;
      }
    } catch (e) {
      print(e);
      return 3;
    }
    return 3;
  }
}
