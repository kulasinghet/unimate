import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unimate/login.dart';
import 'package:unimate/student/dashboard.dart';
import 'package:unimate/student_signup.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? '';
  String userRole = prefs.getString('userRole') ?? '';
  String userId = prefs.getString('userId') ?? '';

  String initialRoute = token == '' ? '/login' : '/dashboard';

  if (token != '' && userRole == 'student') {
    initialRoute = '/student/dashboard';
  } else if (token != '' && userRole == 'lecturer') {
    initialRoute = '/lecturer/dashboard';
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: 'Unimate',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: initialRoute,
    routes: {
      '/': (context) => MyApp(),
      '/dashboard': (context) => Text('Second Route'),
      '/login': (context) => Login(),
      '/student/signup': (context) => RegisterStudent(),
      '/student/dashboard': (context) => StudentDashboard(),
      '/lecturer/signup': (context) => Text('Lecturer Signup'),
      '/lecturer/dashboard': (context) => Text('Lecturer Dashboard'),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const StudentDashboard(),
    );
  }
}
