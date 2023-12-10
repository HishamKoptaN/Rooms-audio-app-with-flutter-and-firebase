import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/chathomePageController.dart';
import '../../controller/userData/userCredentials.dart';
import '../../controller/userData/variables.dart';

//  VIP && Regular
Widget roomBuilder(
    {dynamic data, ChatHomeController? controller, isVIP = true}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: GestureDetector(
      onTap: () {
        if (isGuest || isRole) {
          showAlert(
            Get.context!,
            roomId: data["room_id"],
            roomName: data["room_name"],
            roomOwner: data["owner_username"],
            welcomeText: data["hello_msg"],
          );
        } else {
          controller!
              .checkIfBanned(roomId: data["room_id"], username: userName);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Container(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            image: !isVIP
                ? const DecorationImage(
                    image: NetworkImage(
                        "https://lametnachat.com/test/roomBackgroundImage.jpg"),
                    fit: BoxFit.fill,
                  )
                : null,
            boxShadow: const [
              BoxShadow(
                color: Color(0x29000000),
                blurRadius: 3,
                offset: Offset(0, 3),
                spreadRadius: 0,
              )
            ],
            color: isVIP
                ? Color(int.parse(data["background_color"].substring(1, 7),
                        radix: 16) +
                    0xFF000000)
                : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 90.w,
                height: 90.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        roomImagesURL + data["room_img"],
                        fit: BoxFit.cover,
                        width: 80.w,
                        height: 80.h,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.network(
                          "https://media.istockphoto.com/id/1295072146/vector/mini-heart-korean-love-hand-finger-symbol-on-pink-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=eihpG3p1GoSvMjlSAQjCft50iff2I1AweF2a1MLI1SQ=",
                          fit: BoxFit.cover,
                          width: 80.w,
                          height: 80.h,
                        ),
                      ),
                    ),
                    isVIP
                        ? const SizedBox()
                        : Image.network(
                            'https://lametnachat.com/test/roomBanner.png',
                            fit: BoxFit.cover,
                            width: 90.w,
                            height: 90.h),
                    data["roomLock"] == "true"
                        ? Icon(
                            Icons.lock,
                            color: Colors.black54,
                            size: 45.sp,
                          )
                        : const SizedBox(),
                    if (data["roomLock"] == "بوابة دخول")
                      Image.asset('assets/icons/roomDoor.png',
                          fit: BoxFit.cover, width: 40.w, height: 40.h)
                    else if (data["roomLock"] == "الاعضاء والمشرفين فقط")
                      Image.asset('assets/icons/roomLock.png',
                          fit: BoxFit.cover, width: 40.w, height: 40.h)
                    else
                      const SizedBox(),
                  ],
                ),
              ),
              SizedBox(width: 7.w),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 285.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data["room_name"],
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          GetBuilder<ChatHomeController>(
                            builder: (controller) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  controller.addOrRemoveToFavourite(
                                    data["room_id"],
                                  );
                                },
                                icon: Icon(
                                    controller.favoriteRooms.contains(
                                      data["room_id"],
                                    )
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 20.sp,
                                    color: controller.favoriteRooms.contains(
                                      data["room_id"],
                                    )
                                        ? Colors.red
                                        : null),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              // اسم الدوله للروم
                              Text(
                                data["country_name"],
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),

                              SizedBox(
                                width: 170.w,
                              ),
                              Transform.rotate(
                                angle: -30 * (3.141592653589793 / 180),
                                child: Image.asset(
                                  'assets/images/message.png',
                                  fit: BoxFit.cover,
                                  width: 80.w,
                                  height: 50.h,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              // صورةالدوله للروم

                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(198, 255, 255, 255),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                height: 30,
                                child: Center(
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/flags/palestine.png',
                                          fit: BoxFit.contain,
                                          width: 40.w,
                                          height: double.infinity,
                                        ),
                                      ),
                                      const Text(
                                        "Id:1213",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.shade500,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                width: 60,
                                height: 30,
                                child: const Center(child: Text('Palstein')),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade400,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                width: 50,
                                height: 30,
                                child: const Center(
                                  child: Text(
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      'صوتيه'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 230.w,
                            child: Text(
                              data["description"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 17.sp,
                            height: 17.sp,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/icons/waves.gif"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            " 300 ",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void showAlert(
  BuildContext context, {
  String? roomId,
  String? roomName,
  String? roomOwner,
  String? welcomeText,
}) {
  Get.dialog(
    GetBuilder<ChatHomeController>(
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.changeAlertIndex(0);
                  },
                  child: Container(
                    width: 90.w,
                    height: 40.h,
                    decoration: controller.alertIndex != 1
                        ? BoxDecoration(
                            color: const Color(0xFFEFA11B),
                            borderRadius: BorderRadius.circular(10.r),
                          )
                        : BoxDecoration(
                            // color: Color(0xFFEFA11B),
                            border: Border.all(
                                color: const Color(0xFFFABB64), width: 1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                    child: Center(
                      child: Text(
                        "زائر",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: controller.alertIndex == 1
                              ? const Color(0xFFEFA11B)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.changeAlertIndex(1);
                  },
                  child: Container(
                    width: 90.w,
                    height: 40.h,
                    decoration: controller.alertIndex == 1
                        ? BoxDecoration(
                            color: const Color(0xFFEFA11B),
                            borderRadius: BorderRadius.circular(10.r),
                          )
                        : BoxDecoration(
                            // color: Color(0xFFEFA11B),
                            border: Border.all(
                                color: const Color(0xFFFABB64), width: 1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                    child: Center(
                      child: Text("عضو",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: controller.alertIndex != 1
                                  ? const Color(0xFFEFA11B)
                                  : Colors.white,
                              fontFamily: "Portada")),
                    ),
                  ),
                )
              ],
            ),
            content: SizedBox(
              height: controller.alertIndex != 1 ? 135.h : 215.h,
              width: 366.w,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: controller.alertIndex != 1 ? 50.h : 155.h,
                      child: PageView(
                        controller: controller.alertPageController,
                        children: <Widget>[
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: TextFormField(
                                controller: controller.guestController,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.person,
                                    size: 20.sp,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 7.h),
                                  filled: true,
                                  hintText: "اسم المستتخدم",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.sp,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: TextFormField(
                                    controller:
                                        controller.roleUsernameController,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person,
                                        size: 20.sp,
                                        color: Colors.grey,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 7.h),
                                      filled: true,
                                      hintText: "اسم المستتخدم",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.sp,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: TextFormField(
                                    controller:
                                        controller.rolePasswordController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 7.h),
                                      filled: true,
                                      hintText: "كلمة المرور",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.sp,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (controller.alertIndex == 0) {
                          Get.back();
                          controller.checkIfBanned(
                              roomId: roomId!,
                              username: controller.guestController.text);
                          FocusScope.of(context).unfocus();
                        } else {
                          // print("object");contro
                          Get.back();

                          FocusScope.of(context).unfocus();
                          controller.checkIfBanned(
                              roomId: roomId!,
                              username: controller.roleUsernameController.text);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFA11B),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              "دخول",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  ).then(
    (value) {
      Get.put(
        ChatHomeController(),
      ).changeAlertIndex(0);
    },
  );
}
