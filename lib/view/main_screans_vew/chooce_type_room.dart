import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/bottomNavitionBar.dart';
import '../../controller/chathomePageController.dart';
import '../side pages/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/VIPRoombuildder.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class ChoiceTypeRooms extends StatelessWidget {
  const ChoiceTypeRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: const Drawer(),
      endDrawer: homeDrawer(),
      onEndDrawerChanged: (isOpened) {
        if (isOpened) {
          Get.put(BottomNavigationBarController()).changeShow();
        } else {
          Get.put(BottomNavigationBarController()).changeShow();
        }
      },
      endDrawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140.h),
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
            leadingWidth: 110.w,
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
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
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
                                width: Get.width,
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
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 8.h),
          GetBuilder<ChatHomeController>(
            init: ChatHomeController(),
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCategoryButton(
                    title: 'الغرف العادية',
                    onPressed: () {
                      controller.changeIndex(1);
                    },
                    isSelected: controller.selectedIndex == 1,
                  ),
                  SizedBox(width: 15.w),
                  _buildCategoryButton(
                    title: 'الغرف المميزة',
                    onPressed: () {
                      controller.changeIndex(0);
                    },
                    isSelected: controller.selectedIndex != 1,
                  ),
                ],
              );
            },
          ),
          GetBuilder<ChatHomeController>(
            builder: (controller) {
              return controller.vipRooms.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 150.h),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _buildRoomList(
                      rooms: controller.selectedIndex != 1
                          ? controller.vipRooms
                          : controller.regularRooms,
                      controller: controller,
                    );
            },
          ),
          Container(
            color: const Color(0xFFF1F1F1),
            height: 35.h,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // _buildRoomInfo('مستخدم',
                //     Get.find<ChatHomeController>().numberOfConnections),
                // _buildRoomInfo(
                //     'غرفة', Get.find<ChatHomeController>().roomNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton({
    required String title,
    required VoidCallback onPressed,
    required bool isSelected,
  }) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFABD63),
                  Color(0xFFF792F0),
                ],
              )
            : null,
        border: !isSelected
            ? Border.all(
                color: const Color(0xFFDADADC),
              )
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: isSelected
              ? TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                )
              : TextStyle(
                  color: const Color(0xFFDADADC),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
        ),
      ),
    );
  }

  Widget _buildRoomList({
    required List<dynamic> rooms,
    required ChatHomeController controller,
  }) {
    return ListView.builder(
      cacheExtent: 20,
      itemCount: rooms.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return roomBuilder(
          data: rooms[index],
          controller: controller,
          isVIP: controller.selectedIndex != 1,
        );
      },
    );
  }

  Widget _buildRoomInfo(String label, int value) {
    return Row(
      children: [
        GetBuilder<ChatHomeController>(
          builder: (controller) => Text(
            "$value $label ",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: const Color(0xFFA2ACAC),
              fontFamily: 'Portada',
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Icon(Icons.person, color: const Color(0xFFA2ACAC), size: 22.sp),
        SizedBox(width: 30.w),
      ],
    );
  }
}
