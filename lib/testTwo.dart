import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/chat/changePassword.dart';
import 'controller/chat/roomsPageController.dart';
import 'view/chat/In Room Widgets/appBar.dart';
import 'view/chat/roomPage.dart';
import 'view/store/storeDetails.dart';

Widget appBarr() {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),

    child: GetBuilder<RoomsPageController>(
      // init: RoomsPageController(),
      builder: (controller) {
        const Text("room_id");
        return const Text("room_id");
      },
    ),

    // appBar: AppBar(
    //   toolbarHeight: 72.35.h,
    //   leadingWidth: 105.w,
    //   elevation: 0,
    //   centerTitle: true,
    //   backgroundColor: Colors.transparent,
    // title: GetBuilder<RoomsPageController>(builder: () ,)

    // actions: [
    //   IconButton(
    //     icon: Icon(Icons.settings),
    //     onPressed: () {
    //       // إضافة مزيد من اللوجيك هنا
    //     },
    //   ),
    //   IconButton(
    //     icon: Icon(Icons.volume_up),
    //     onPressed: () {
    //       // إضافة مزيد من اللوجيك هنا
    //     },
    //   ),
    // ],
    // ),
    // body: Column(
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         CircleAvatar(
    //           backgroundImage:
    //               AssetImage('assets/image1.jpg'), // تحديد الصورة الأولى
    //           radius: 30,
    //         ),
    //         SizedBox(width: 10),
    //         CircleAvatar(
    //           backgroundImage:
    //               AssetImage('assets/image2.jpg'), // تحديد الصورة الثانية
    //           radius: 30,
    //         ),
    //       ],
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    // IconButton(
    //   icon: Icon(Icons.lock),
    //   onPressed: () {
    //     // إضافة مزيد من اللوجيك هنا
    //   },
    // ),
    //         IconButton(
    //           icon: Icon(Icons.lock),
    //           onPressed: () {
    //             // إضافة مزيد من اللوجيك هنا
    //           },
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.lock),
    //           onPressed: () {
    //             // إضافة مزيد من اللوجيك هنا
    //           },
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.lock),
    //           onPressed: () {
    //             // إضافة مزيد من اللوجيك هنا
    //           },
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.lock),
    //           onPressed: () {
    //             // إضافة مزيد من اللوجيك هنا
    //           },
    //         ),
    //       ],
    //     ),
    // يمكنك إضافة المزيد من العناصر حسب الحاجة
    // ],
  );
}
