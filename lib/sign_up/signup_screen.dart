import 'package:flutter/material.dart';

import 'components/heading_text.dart';
import 'components/info.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
          ]
        )
      ),
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
