import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/userData/userCredentials.dart';

Widget homeDrawer() => Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFABD63),
              Color(0xFFF792F0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 45.h),
              child: Image.asset(
                'assets/icons/logo.png',
                height: 160.h,
              ),
            ),
            isGuest == false && isRole == false
                ? drawerItem(
                    'الملف الشخصي',
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                    () {
                      Get.toNamed("/profile");
                    },
                  )
                : const SizedBox(),
            isGuest == false && isRole == false
                ? drawerItem(
                    'لوحة التحكم',
                    Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                    () {
                      Get.toNamed('/mainControllerPanel');
                    },
                  )
                : const SizedBox(),
            drawerItem(
              'المتجر',
              Image.asset(
                'assets/icons/bag.png',
                color: Colors.white,
                width: 25.w,
                height: 25.h,
              ),
              () {
                Get.toNamed("/store");
              },
            ),
            drawerItem(
              'الدعم الفني',
              Icon(
                Icons.send,
                color: Colors.white,
                size: 27.sp,
              ),
              () {
                Get.toNamed('/customerService');
              },
            ),
            drawerItem(
              'خروج',
              RotatedBox(
                quarterTurns: 2,
                child: Image.asset(
                  "assets/icons/login.png",
                  color: Colors.white,
                  width: 28.w,
                  height: 28.h,
                ),
              ),
              () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.remove('username');
                prefs.remove('password');
                Get.offAllNamed('/choosingPage');
                isGuest = true;
              },
            ),
          ],
        ),
      ),
    );

Widget drawerItem(String title, Widget icon, Function? onTap) => Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        dense: true,
        horizontalTitleGap: 0,
        onTap: onTap as void Function()?,
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Portada',
            fontSize: 16.sp,
          ),
        ),
      ),
    );
