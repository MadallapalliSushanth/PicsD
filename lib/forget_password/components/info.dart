import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:picsd/home_screen.dart';
import 'package:picsd/log_in/login_screen.dart';
import 'package:picsd/sign_up/signup_screen.dart';
import 'package:picsd/widgets/account_check.dart';
import 'package:picsd/widgets/rectangular_button.dart';
import 'package:picsd/widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController _emailTextController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Center(
            child: Image.asset(
              "assets/forget.png",
              width: 200.0,
            ),
          )),
          SizedBox(
            height: 10,
          ),
          RectangularInputField(
            hintText: 'Enter Email',
            icon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController,
          ),
          SizedBox(
            height: 30.0 / 2,
          ),
          RectangularButton(
            text: 'Send Link',
            colors1: Colors.black,
            colors2: Colors.black,
            press: () async {
              try {
                await _auth.sendPasswordResetEmail(
                  email: _emailTextController.text,
                );
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              } catch (error) {
                Fluttertoast.showToast(msg: error.toString());
              }
            },
          ),
          AccountCheck(
            login: false,
            press: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
