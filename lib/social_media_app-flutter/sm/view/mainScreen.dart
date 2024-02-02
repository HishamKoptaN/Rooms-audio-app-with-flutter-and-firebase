import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../services/notificationService.dart';
import '../utils/utils.dart';
import 'activity/notiScreen.dart';
import 'home/feedScreen.dart';
import 'post/addPostScreen.dart';
import 'profile/profileScreen.dart';
import 'search/searchScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List _mainPages = [
    FeedScreen(),
    SearchScreen(),
    FeedScreen(),
    const NotiScreen(),
    ProfileScreen(userId: currentUserId),
  ];

  NotificationsService notificationsService = NotificationsService();

  @override
  void initState() {
    notificationsService.getToken();
    notificationsService.requestPermission();
    notificationsService.firebaseNotification(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainPages[_currentIndex],
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(vertical: 9),
      //   decoration: BoxDecoration(
      //     //color: Colors.grey.shade100
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       IconButton(onPressed: (){}, icon: Icon(IconlyBold.home),padding: EdgeInsets.all(1),)
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.grey,
      //   type: BottomNavigationBarType.fixed,
      //   elevation: 0,
      //   showSelectedLabels: false ,
      //   showUnselectedLabels: false,
      //   currentIndex: _currentIndex,
      //   onTap: (index) async {
      //     if(index == 2){
      //       setState(() {
      //         _currentIndex = 0;
      //         navigatorPush(context, PostScreen());
      //       });
      //     }else{
      //       setState(() {
      //       _currentIndex = index;
      //     });
      //     }
      //   },
      //   items: [
      //     /// Home
      //     BottomNavigationBarItem(
      //       label: "",
      //       icon: Icon(_currentIndex == 0 ? IconlyBold.home : IconlyLight.home),
      //     ),

      //     /// Search
      //     BottomNavigationBarItem(label: "",
      //       icon: Icon(IconlyLight.search),
      //     ),

      //     /// Search
      //     BottomNavigationBarItem(label: "",
      //       icon: Icon(_currentIndex == 2
      //           ? IconlyBold.editSquare
      //           : IconlyLight.edit_square),
      //     ),

      //     /// Likes
      //     BottomNavigationBarItem(label: "",
      //       icon: Icon(
      //           _currentIndex == 3 ? IconlyBold.heart : IconlyLight.heart),
      //     ),

      //     /// Profile
      //     BottomNavigationBarItem(label: "",
      //       icon: Icon(
      //           _currentIndex == 4 ? IconlyBold.profile : IconlyLight.profile),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: DotNavigationBar(
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        selectedItemColor: Colors.white,
        marginR: const EdgeInsets.only(left: 40, right: 40, bottom: 11, top: 5),
        paddingR: const EdgeInsets.symmetric(vertical: 4),
        currentIndex: _currentIndex,
        onTap: (index) async {
          if (index == 2) {
            setState(() {
              _currentIndex = 0;
              navigatorPush(context, const PostScreen());
            });
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        dotIndicatorColor: Colors.transparent,
        items: [
          /// Home
          DotNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? IconlyBold.home : IconlyLight.home),
          ),

          /// Search
          DotNavigationBarItem(
            icon: const Icon(IconlyLight.search),
          ),

          /// Search
          DotNavigationBarItem(
            icon: Icon(_currentIndex == 2
                ? IconlyBold.editSquare
                : IconlyLight.edit_square),
          ),

          /// Likes
          DotNavigationBarItem(
            icon:
                Icon(_currentIndex == 3 ? IconlyBold.heart : IconlyLight.heart),
          ),

          /// Profile
          DotNavigationBarItem(
            icon: Icon(
                _currentIndex == 4 ? IconlyBold.profile : IconlyLight.profile),
          ),
        ],
      ),
    );
  }
}
