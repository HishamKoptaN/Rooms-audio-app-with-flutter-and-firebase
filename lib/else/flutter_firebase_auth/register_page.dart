import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../whisber/pages/home_page.dart';
import 'login_page.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  validate() {
    if (nameController.text.length <= 3) {
      Fluttertoast.showToast(msg: 'Invalid Name');
    } else if (!emailController.text.contains('@gmail.com')) {
      Fluttertoast.showToast(msg: 'Invalid Email');
    } else if (passwordController.text.length == 8) {
      Fluttertoast.showToast(msg: 'Enter minimum 8 digit password');
    } else {
      firebaseAuth();
    }
  }

  firebaseAuth() async {
    var signUpAuth = FirebaseAuth.instance;
    await signUpAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      Fluttertoast.showToast(msg: "Register Successful");
      userData();
    });
  }

  //
  userData() {
    var authFirebase = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore.instance.collection("users").doc(authFirebase).set({
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    }).then((value) => {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        //Assign controller
                        controller: nameController,
                        //Use this function to validate user name input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //Assign controller
                        controller: emailController,
                        //Use this function to validate user email input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //Assign controller
                        controller: passwordController,
                        obscureText: true,
                        //Use this function to validate user password input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If you have already account"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginUser(),
                              ));
                        },
                        child: Text("Login here...")),
                  ],
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () => validate(),
                    // handleSubmit(),
                    child: Text('Register'))
              ],
            ),
          )
        ],
      ),
    );
  }

// handleSubmit() async {
//   //Validate user inputs using formkey
//   if (!_formKey.currentState!.validate()) return;
//   final email = emailController.value.text;
//   final password = passwordController.value.text;
//   // setState(()=> _loading = true);
// //     if(_isLogin){
// //       await Auth().signInWithEmailAndPassword(email, password);
// //     }
// //     else{
// //    await Auth().registerWithEmailAndPassword(email, password);
// // }
// // setState(()=> _loading = false);
//
// }
}
