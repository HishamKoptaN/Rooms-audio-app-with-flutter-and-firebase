import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      leadingWidth: 120.w,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              Get.toNamed('/favourite');
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      title: Text(
        "Lametna",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed('/search');
          },
          child: Icon(Icons.search, size: 30.sp),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed('/trophy');
          },
          child: Image.asset(
            "assets/images/trophy.png",
            width: 55.w,
            height: 30.h,
          ),
        ),
        GestureDetector(
          onTap: () {
            var scaffoldKey;
            scaffoldKey.currentState!.openEndDrawer();
          },
          child: Icon(Icons.menu, size: 30.sp),
        ),
        SizedBox(width: 10.w)
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.h),
        child: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: (130 / 2).h,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: [1, 2, 3, 4, 5].map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.asset(
                          "assets/images/banner.png",
                          // width: 100.w,
                          width: Get.width,
                          height: 50.h,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      leadingWidth: 130.w,
      leading: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      title: Text(
        "Lametna",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Image.network(
          "assets/images/trophy.png",
          width: 55.w,
          height: 30.h,
        ),
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
            _scaffoldKey.currentState!.openEndDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ],
    );
  }
}

PreferredSize appbarBuilder(String title, bool isCentered,
    {String color = ""}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: Container(
      decoration: BoxDecoration(
        // LinearGradient
        gradient: color == ""
            ? const LinearGradient(
                colors: [
                  Color(0xFFF792F0),
                  Color(0xFFFABD63),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: color == ""
            ? null
            : Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
      ),
      child: AppBar(
        centerTitle: isCentered,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white, //Color(0xff9A8B8B),
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
            size: 25.sp,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
  );
}

Widget MainAppBar(GlobalKey scaffordKey) {
  return PreferredSize(
    preferredSize: Size.fromHeight(300.h),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(27.r),
          bottomRight: Radius.circular(27.r),
        ),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFABD63),
            Color(0xFFF792F0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 130.w,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
          ],
        ),
        title: Text(
          "Lametna",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            "assets/images/trophy.png",
            width: 55.w,
            height: 30.h,
          ),
          IconButton(
              onPressed: () {
                print("object");
                // Scaffold.of(context).openDrawer();
                // _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: const Icon(Icons.menu)),
          Image.asset(
            "assets/images/trophy.png",
            width: 55.w,
            height: 30.h,
          ),
          IconButton(
            onPressed: () {
              // Scaffold.of(contex).openDrawer();
              // _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.h),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 45.h),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 150.h,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      "assets/images/banner.png",
                      // width: 100.w,
                      // height: 100.h,
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    ),
  );
}
