import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:picsd/home_screen.dart';
import 'package:picsd/log_in/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.amber,
              body: Center(
                child: Text(
                  ' Welcome,\n to\nPicsD......',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: Center(
              child: Text('An occur occured, please wait....'),
            )),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PicsD',
          theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF1CEC05),
              primarySwatch: Colors.blue),
          home: FirebaseAuth.instance.currentUser == null
              ? LoginScreen()
              : HomeScreen(),
        );
      },
    );
  }
}
