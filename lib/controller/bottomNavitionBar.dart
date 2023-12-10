import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../testTwo.dart';
import '../test_three.dart';
import '../view/chat/in room chat/previousChats.dart';
import '../view/main_screans_vew/home_page.dart';
import '../view/messages/messages.dart';
import '../view/moments/moments.dart';
import 'userData/userCredentials.dart';
import '../view/store/store.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  bool isShow = true;
  int currentIndex = 0;
  int selectedIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  void changeShow() {
    isShow = !isShow;
    update();
  }

  List<Widget> pages = <Widget>[
    const HomePage(),
    const Moments(),
    if (isGuest == false && isRole == false) Messages() else Container(),
    TestThree(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }
}
