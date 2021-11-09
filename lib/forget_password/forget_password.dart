import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picsd/forget_password/components/heading_text.dart';
import 'package:picsd/forget_password/components/info.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.redAccent,
            Colors.red,
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
