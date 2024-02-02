import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/signup.dart';
import 'service/auth.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyAppCp());
// }

class MyAppCp extends StatelessWidget {
  const MyAppCp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: AuthMethods().getcurrentUser(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return const SignUp();
            } else {
              return const SignUp();
            }
          }),
    );
  }
}
