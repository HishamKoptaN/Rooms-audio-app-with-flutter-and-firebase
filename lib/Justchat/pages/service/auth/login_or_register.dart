import 'package:flutter/material.dart';

import '../../login_page.dart';
import '../../register_page.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!showLoginPage) {
      return Layout(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
