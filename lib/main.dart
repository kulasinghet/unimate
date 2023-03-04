import 'package:flutter/material.dart';

import 'package:unimate/login.dart';
import 'package:unimate/student/dashboard.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  bool isLoggedIn = false;

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  runApp(MaterialApp(
    title: 'Unimate',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: isLoggedIn ? '/dashboard' : '/login',
    routes: {
      '/': (context) => MyApp(),
      '/dashboard': (context) => Text('Second Route'),
      '/login': (context) => Login(),
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
