// import 'package:flutter/material.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// import 'test.dart';
// import 'view/LoginPage.dart';
// import 'view/home_page.dart';
// import 'view/profile/changeBackground.dart';
// import 'view/profile/editPerson.dart';
// import 'view/profile/editPersonalProfile.dart';
// import 'view/profile/editProfile.dart';
// import 'view/profile/profile.dart';
// import 'view/store/storeDetails.dart';

// class NavigateBarScreen extends StatefulWidget {
//   @override
//   State<NavigateBarScreen> createState() => _HomePageState();
// }

// class _HomePageState extends State<NavigateBarScreen> {
//   final List<Widget> _pages = [
//     Profile(),
//     Profile(),
//     Profile(),
//   ];
//   int _currentIndex = 1;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Center(
//         child: Scaffold(
//           body: SizedBox(child: _pages[_currentIndex]),
//           bottomNavigationBar: SalomonBottomBar(
//             currentIndex: _currentIndex,
//             backgroundColor: Colors.white30,
//             onTap: (int index) {
//               setState(
//                 () {
//                   _currentIndex = index;
//                 },
//               );
//             },
//             items: [
//               SalomonBottomBarItem(
//                 selectedColor: Colors.red,
//                 unselectedColor: Colors.grey,
//                 icon: const Icon(Icons.person, size: 35),
//                 title: const Text("Profile"),
//               ),
//               SalomonBottomBarItem(
//                 selectedColor: Colors.red,
//                 unselectedColor: Colors.grey,
//                 icon: const Icon(Icons.home, size: 35),
//                 title: const Text("Home"),
//               ),
//               SalomonBottomBarItem(
//                 selectedColor: Colors.red,
//                 unselectedColor: Colors.grey,
//                 icon: const Icon(Icons.shopping_cart_outlined, size: 35),
//                 title: const Text("Cart"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
