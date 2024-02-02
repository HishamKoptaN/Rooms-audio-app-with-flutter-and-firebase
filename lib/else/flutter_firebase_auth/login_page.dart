import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../whisber/pages/home_page.dart';
import 'register_page.dart';
import 'send_otp.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? currentUser;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // validate() {
  //   if (emailController.text.isNotEmpty) {
  //     Fluttertoast.showToast(msg: 'Please enter email');
  //   } else if (!emailController.text.contains('@gmail.com')) {
  //     Fluttertoast.showToast(msg: 'Invalid Email');
  //   }
  //   else if (passwordController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: 'Please enter password');
  //   }
  //   else if (passwordController.text.length == 8) {
  //     Fluttertoast.showToast(msg: 'Enter minimum 8 digit password');
  //   } else {
  //     userLogin();
  //   }
  // }

  userLogin() async {
    var signInAuth = FirebaseAuth.instance;
    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        await signInAuth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        Fluttertoast.showToast(
            msg: "Login Successful ", textColor: Colors.yellowAccent);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Fluttertoast.showToast(msg: "please fill email and password");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid email and password");
    }
  }

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((event) {
      setState(() {
        currentUser = event;
      });
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
                  "Login",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),

                SizedBox(
                  height: 50,
                ),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your email",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your password",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("If you haven't an account"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserRegister(),
                              ));
                        },
                        child: Text("Register here...")),
                  ],
                ),

                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () => userLogin(),
                    child: Text('Login')),

                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //  InkWell(
                //    onTap: (){
                //      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserRegister(),));
                //    },
                //
                //    child: Padding(
                //      padding: const EdgeInsets.all(8.0),
                //      child: Image.network("https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png", scale: 20,),
                //    ),),
                //
                //    InkWell(child: Padding(
                //      padding: const EdgeInsets.all(8.0),
                //      child: Image.network("https://e7.pngegg.com/pngimages/759/922/png-clipart-telephone-logo-iphone-telephone-call-smartphone-phone-electronics-text-thumbnail.png",scale: 7,),
                //    )),
                //   ],
                // )

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 40, top: 25),
                          child: Container(
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Image(
                                    image: NetworkImage(
                                        'https://cdn-icons-png.flaticon.com/512/2111/2111393.png')),
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: currentUser != null
                            ? _userInfo()
                            : _googleSignInButton(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 25),
                        child: Container(
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SendOtpPage(),
                                    ));
                              },
                              child: Image(
                                  image: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/128/3437/3437364.png')),
                              style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _googleSignInButton() {
    return Container(
      child: SizedBox(
        height: 60,
        width: 60,
        child: ElevatedButton(
          onPressed: () {
            _handleGoogleSignIn();
          },
          child: Image(
              image: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/281/281764.png')),
          style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
        ),
      ),
    );
  }

  Widget _userInfo() {
    return SizedBox(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(currentUser!.photoURL!))),
          ),
          Text(currentUser!.displayName!),
          Text(currentUser!.email!),
          ElevatedButton(
              onPressed: () {
                auth.signOut();
              },
              child: Text("logout"))
        ],
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      auth.signInWithProvider(googleAuthProvider);
    } catch (error) {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
