import 'package:flutter/material.dart';
import 'package:picsd/home_screen.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAbout Us"),
          backgroundColor: Colors.amber,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => HomeScreen()));
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 27),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage("assets/about.png")),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 280,
                width: 360,
                child: Wrap(
                  children: [
                    Text(
                      "When it comes to a great idea, you know it when you see it.PicsD is an image sharing and social media service designed to enable saving and discovering of information on the internet using images,and on a smaller scale,in the form of pinboards",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
