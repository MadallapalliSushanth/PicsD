import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:picsd/about.dart';
import 'package:picsd/log_in/login_screen.dart';
import 'package:picsd/owner_details.dart';
import 'package:picsd/privacypolicy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String changeTitle = "More Details";
  bool checkView = false;

  File? imageFile;
  String? imageUrl;
  String? myImage;
  String? myName;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    read_userInfo();
  }

  void _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
  }

  void _cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  void read_userInfo() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        myImage = snapshot.get('userImage');
        myName = snapshot.get('name');
      });
    });
  }

  void _upload_image() async {
    if (imageFile == null) {
      Fluttertoast.showToast(msg: "Please select an Image");
      return;
    }
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(DateTime.now().toString() + "jpg");
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('wallpaper')
          .doc(DateTime.now().toString())
          .set({
        'id': _auth.currentUser!.uid,
        'userImage': myImage,
        'name': myName,
        'email': _auth.currentUser!.email,
        "Image": imageUrl,
        'downloads': 0,
        'createdAt': DateTime.now(),
      });
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      imageFile = null;
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please choose an option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _getFromCamera();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget listViewWidget(String docId, String img, String userImg, String name,
      DateTime date, String userId, int downloads) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        color: Colors.red,
        elevation: 16.0,
        shadowColor: Colors.white10,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => OwnerDetails(
                                img: img,
                                userImg: userImg,
                                name: name,
                                date: date,
                                docId: docId,
                                userId: userId,
                                downloads: downloads,
                              )));
                },
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        userImg,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          DateFormat("dd MMMM, yyyy - hh:mm a")
                              .format(date)
                              .toString(),
                          style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget gridViewWidget(String docId, String img, String userImg, String name,
      DateTime date, String userId, int downloads) {
    return GridView.count(
      primary: false,
      padding: EdgeInsets.all(6),
      crossAxisSpacing: 1,
      crossAxisCount: 1,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OwnerDetails(
                            img: img,
                            userImg: userImg,
                            name: name,
                            date: date,
                            docId: docId,
                            userId: userId,
                            downloads: downloads,
                          )));
            },
            child: Center(
              child: Image.network(
                img,
                fit: BoxFit.fill,
              ),
            ),
          ),
          color: Colors.white10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: GestureDetector(
          onTap: () {
            setState(() {
              changeTitle = "PicsD";
              checkView = true;
            });
          },
          onDoubleTap: () {
            setState(() {
              changeTitle = "Collection";
              checkView = false;
            });
          },
          child: Text(changeTitle),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (imageFile != null) {
                  _upload_image();
                }
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      drawer: new Drawer(
        child: Container(
          padding: EdgeInsets.fromLTRB(30.0, 150.0, 20.0, 4.0),
          color: Colors.amber,
          child: new ListView(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => HomeScreen()));
                },
                child: ListTile(
                  title: Text('Home Screen'),
                  leading: Icon(Icons.home, color: Colors.black),
                ),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => About()));
                },
                child: ListTile(
                  title: Text('About Us'),
                  leading: Icon(
                    Icons.help,
                    color: Colors.black,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => Privacy()));
                },
                child: ListTile(
                  title: Text('Privacy Policy'),
                  leading: Icon(Icons.privacy_tip, color: Colors.red),
                ),
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: ListTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.logout, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          _showImageDialog();
        },
        child: Icon(Icons.camera_enhance),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wallpaper')
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              if (checkView == true) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listViewWidget(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['Image'],
                        snapshot.data!.docs[index]['userImage'],
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['createdAt'].toDate(),
                        snapshot.data!.docs[index]['id'],
                        snapshot.data!.docs[index]['downloads'],
                      );
                    });
              } else {
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return gridViewWidget(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['Image'],
                        snapshot.data!.docs[index]['userImage'],
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['createdAt'].toDate(),
                        snapshot.data!.docs[index]['id'],
                        snapshot.data!.docs[index]['downloads'],
                      );
                    });
              }
            } else {
              return Center(
                child: Text("There is no tasks"),
              );
            }
          }
          return Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          );
        },
      ),
    );
  }
}
