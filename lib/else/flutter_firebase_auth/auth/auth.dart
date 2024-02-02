// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class Auth {
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> registerWithEmailAndPassword(String email, String password) async {
//
//     try{
//       await _auth.createUserWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch(e){
//       if(e.code == 'week-password'){
//         Fluttertoast.showToast(msg: "The password provided is too weak.");
//       }
//       else if(e.code == 'email-already-in-use'){
//         Fluttertoast.showToast(msg: "The email address is already exists account.");
//       }
//     }
//     catch(e){
//       print(e);
//     }
//   }
//
//
//   Future<void> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
// }
