// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/chat/changePassword.dart';
import '../../../controller/chat/roomsPageController.dart';
import '../../../controller/userData/userCredentials.dart';
import '../roomPage.dart';

Widget appbar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: GetBuilder<RoomsPageController>(
      init: RoomsPageController(),
      builder: (controller) {
        return AppBar(
          leadingWidth: 105.w,
          toolbarHeight: 72.35.h,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: GetBuilder<RoomsPageController>(
            builder: (controller) {
              return Column(
                children: [
                  // Text(
                  //   controller.memberInCall == null
                  //       ? "--:--"
                  //       : controller.memberInCall.length == 0
                  //           ? "--:--"
                  //           : controller.memberInCall.length > 1
                  //               ? "--:--"
                  //               : DateTime.now()
                  //                   .difference(
                  //                     DateTime.parse(controller.memberInCall[0]
                  //                             ["time"])
                  //                         .add(
                  //                       Duration(
                  //                         hours: DateTime.now()
                  //                             .timeZoneOffset
                  //                             .inHours,
                  //                       ),
                  //                     ),
                  //                   )
                  //                   .toString()
                  //                   .substring(3, 8),
                  //   style: TextStyle(
                  //     fontSize: 18.sp,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              );
            },
          ),
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.volume_up, color: Colors.white),
              GetBuilder<RoomsPageController>(
                builder: (controller) {
                  return PopupMenuButton<int>(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    constraints: BoxConstraints(
                      minWidth: 135,
                      maxWidth: 135,
                    ),
                    offset: Offset(-70.w, 50.h),
                    itemBuilder: (context) => [
                      statusBuilder(
                        "الحالة",
                        value: 0,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "الاعدادات",
                        value: 1,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "مسح النص",
                        value: 2,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "ادارة الغرفة",
                        value: 3,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "تعديل الملف الشخصي",
                        value: 4,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "تغير كلمة السر",
                        value: 5,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "الابلاغ",
                        value: 6,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "المتجر",
                        value: 7,
                      ),
                      statusBuilder(
                        "مشاركة",
                        value: 8,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "الخروج",
                        value: 9,
                        color: Colors.red,
                      ),
                      PopupMenuDivider(
                        height: 2,
                      ),
                      statusBuilder(
                        "عن البرنامج",
                        value: 10,
                      ),
                    ],
                    onSelected: (v) {
                      // if (v == 0) {
                      //   print("object");
                      //   showStatus();
                      // } else if (v == 1) {
                      //   Get.toNamed("/roomSettingsPage");
                      // } else if (v == 2) {
                      // } else if (v == 3) {
                      //   Get.toNamed('/roomMangement', arguments: {
                      //     "room_id": controller.roomId,
                      //     "room_name": controller.roomName,
                      //     "color": controller.themeColor,
                      //     // "roomOwner": controller.roomOwner,
                      //   });
                      // } else if (v == 4) {
                      // } else if (v == 5) {
                      //   Get.to(() => ChangePassword(), arguments: {
                      //     "color": controller.themeColor,
                      //   });
                      // } else if (v == 9) {
                      //   closeAlert();
                      // }
                    },
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
          // actions: <Widget>[
          //   if (userName == controller.roomOwner)
          //     GestureDetector(
          //       onTap: () {
          //         controller.toggleWaitingList();
          //       },
          //       child: Container(
          //         color: controller.waitingListStatus
          //             ? Colors.white
          //             : Colors.transparent,
          //         padding: EdgeInsets.symmetric(horizontal: 10.w),
          //         height: 100,
          //         child: StreamBuilder(
          //           stream: controller.roomLockController.stream,
          //           builder: (context, snapshot) => controller.isRoomLock
          //               ? Image.asset(
          //                   snapshot.data.length != 0
          //                       ? 'assets/icons/waitingListActive.png'
          //                       : 'assets/icons/waitingList.png',
          //                   width: 35.w,
          //                   height: 40.h,
          //                   errorBuilder: (context, error, stackTrace) =>
          //                       Image.asset(
          //                     'assets/icons/waitingList.png',
          //                     width: 35.w,
          //                     height: 40.h,
          //                   ),
          //                 )
          //               : SizedBox(),
          //         ),
          //       ),
          //     )
          //   else
          //     SizedBox(),
          //   SizedBox(
          //     width: 16.w,
          //   ),
          //   GetBuilder<RoomsPageController>(
          //     builder: (controller) {
          //       return GestureDetector(
          //         onTap: () {
          //           print(controller.privateMessages);
          //           if (controller.privateMessages == "all") {
          //             Get.toNamed('/previousChat', arguments: {
          //               "roomId": Get.arguments['room_id'],
          //             });
          //           } else if (controller.privateMessages ==
          //                       "membersAndAdmins" &&
          //                   !isGuest &&
          //                   isRole ||
          //               !isGuest && !isRole) {
          //             Get.toNamed('/previousChat', arguments: {
          //               "roomId": Get.arguments['room_id'],
          //             });
          //           } else if (controller.privateMessages == "adminsOnly" &&
          //               isRole) {
          //             Get.toNamed('/previousChat', arguments: {
          //               "roomId": Get.arguments['room_id'],
          //             });
          //           } else if (controller.privateMessages == "nobody") {
          //             Get.toNamed('/previousChat', arguments: {
          //               "roomId": Get.arguments['room_id'],
          //             });
          //           } else {
          //             Get.snackbar("message", "لا يمكنك ");
          //           }
          //         },
          //         child: ImageIcon(
          //           AssetImage('assets/icons/chat.png'),
          //           size: 23.sp,
          //         ),
          //       );
          //     },
          //   ),
          //   Builder(builder: (context) {
          //     return GestureDetector(
          //       onTap: () {
          //         FocusScope.of(context).unfocus();
          //         Scaffold.of(context).openEndDrawer();
          //       },
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 15.w),
          //         child: Image.asset(
          //           'assets/icons/group.png',
          //           width: 30.sp,
          //         ),
          //       ),
          //     );
          //   })
          // ],
        );
      },
    ),
  );
}

PopupMenuItem<int> statusBuilder(String title,
    {Widget? icon, Function? onTap, int? value, Color color = Colors.black}) {
  return PopupMenuItem<int>(
    height: 40.h,
    padding: EdgeInsets.only(right: 10.w),
    onTap: () {},
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: color, fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    ),
    value: value,
  );
}

menuBuilder() {
  showMenu(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    context: Get.context!,
    position: RelativeRect.fromLTRB(0.w, 90.h, Get.width, 0.h),
    items: [
      statusBuilder(
        "الحالة",
        value: 0,
        // onTap: showStatus(),
      ),
      statusBuilder("الحالة", value: 1, onTap: () {
        Get.back();
        Get.toNamed("/roomSettingsPage");
      }),
    ],
  );
}

// showStatus() {
//   showMenu(
//     context: Get.context!,
//     position: RelativeRect.fromLTRB(50, 50, 50, 50),
//     items: [
//       // usersPopUpMenu("dog"),
//       statusBuilder("متاح", icon: SizedBox()),
//       statusBuilder(
//         "بالخارج",
//         icon: Icon(
//           Icons.timer,
//           color: Colors.green,
//           size: 20.sp,
//         ),
//       ),
//       statusBuilder(
//         "مشغول",
//         icon: Icon(
//           Icons.stop_circle,
//           color: Colors.red,
//           size: 20.sp,
//         ),
//       ),
//       statusBuilder(
//         "هاتف",
//         icon: Icon(
//           Icons.phone,
//           color: Color(0xFF43D0CA),
//           size: 20.sp,
//         ),
//       ),
//       statusBuilder(
//         "طعام",
//         icon: Icon(
//           Icons.food_bank,
//           color: Colors.grey,
//           size: 20.sp,
//         ),
//       ),
//       statusBuilder(
//         "نائم",
//         icon: Icon(
//           Icons.nightlight,
//           color: Colors.purple,
//           size: 20.sp,
//         ),
//       ),
//       statusBuilder(
//         "سيارة",
//         icon: Icon(
//           Icons.airport_shuttle,
//           color: Colors.black,
//           size: 20.sp,
//         ),
//       ),
//     ],
//     elevation: 8.0,
//   );
// }
showStatus() {
  showMenu(
    context: Get.context!,
    position: RelativeRect.fromLTRB(50, 50, 50, 50),
    items: [
      statusBuilder("متاح", icon: SizedBox()),
      statusBuilder(
        "بالخارج",
        icon: Icon(
          Icons.timer,
          color: Colors.green,
          size: 20.sp,
        ),
      ),
      // ... المزيد من الحالات
    ],
    elevation: 8.0,
  ).then((value) {
    // قم بإغلاق القائمة بعد انتهاء الاختيار
    Get.back();
  });
}
