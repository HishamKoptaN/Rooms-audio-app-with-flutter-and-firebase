import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/home_page_chat_model.dart';
import '../../navigate_bar_screen.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  var homeModel = HomePageChatModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeModel.one),
        actions: [
          IconButton(
              onPressed: () {
                if (user != null) {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginUser(),
                        ),
                        (route) => false);
                    Fluttertoast.showToast(msg: "LogOut Successful");
                  });
                } else {
                  Fluttertoast.showToast(msg: "Already LogOut");
                }
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Text("${FirebaseAuth.instance.currentUser?.uid}"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "${FirebaseAuth.instance.currentUser?.photoURL}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Email - ${FirebaseAuth.instance.currentUser?.email}"),
                  ),
                  Text(
                      "Number - ${FirebaseAuth.instance.currentUser?.phoneNumber} "),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
