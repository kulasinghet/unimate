import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unimate/login.dart';

import 'firebase_options.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Flutter Demo'),
          ),
          body: child,
        );
      },
      home: Text('First Route'),
    );
  }
}
