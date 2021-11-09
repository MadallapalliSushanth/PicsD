import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picsd/log_in/components/heading_text.dart';
import 'package:picsd/log_in/components/info.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.black26,
            Colors.white10,
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadText(),
                Credentials(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
