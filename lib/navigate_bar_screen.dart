import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'Justchat/pages/chat_page.dart';
import 'Justchat/pages/service/auth_gate.dart';
import 'else/chat_four/screens/chats/chats_screen.dart';
import 'else/flutter_firebase_auth/main.dart';
import 'model/home_page_chat_model.dart';
import 'social_media_app-flutter/main.dart';
import 'view.dart/moments/moments.dart';
import 'whisber/authentication/authenticate.dart';

class NavigateBarScreen extends StatefulWidget {
  const NavigateBarScreen({super.key});

  @override
  State<NavigateBarScreen> createState() => _HomePageState();
}

class _HomePageState extends State<NavigateBarScreen> {
  final List<Widget> _pages = [
    const ChatsScreen(),
    Moments(),
    const Authenticate(),
    const MyAppFire(),
  ];
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: SizedBox(child: _pages[_currentIndex]),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.white30,
            onTap: (int index) {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
            items: [
              SalomonBottomBarItem(
                selectedColor: Colors.red,
                unselectedColor: Colors.grey,
                icon: const Icon(Icons.shopping_cart_outlined, size: 35),
                title: const Text("Shop"),
              ),
              SalomonBottomBarItem(
                selectedColor: Colors.red,
                unselectedColor: Colors.grey,
                icon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey,
                        Colors.grey,
                      ],
                    ).createShader(bounds);
                  },
                  child: Image.asset(
                    'assets/icons/chat.png',
                    color: Colors.white
                    //  Color(0xFFA2ACAC),
                    ,
                    width: 24.w,
                    // height: 30.h,
                  ),
                ),
                title: const Text("Chats"),
              ),
              SalomonBottomBarItem(
                selectedColor: Colors.red,
                unselectedColor: Colors.grey,
                icon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey,
                        Colors.grey,
                      ],
                    ).createShader(bounds);
                  },
                  child: Image.asset(
                    'assets/icons/planet.png',
                    color: Colors.white,
                    width: 40,
                    // height: 30.h,
                  ),
                ),
                title: const Text("Moments"),
              ),
              SalomonBottomBarItem(
                selectedColor: Colors.red,
                unselectedColor: Colors.grey,
                icon: const Icon(Icons.home, size: 35),
                title: const Text("Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
