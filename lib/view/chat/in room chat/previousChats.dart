import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/chat/in room chat/previosChatController.dart';
import '../../../controller/userData/userCredentials.dart';
import '../../../controller/userData/variables.dart';

class PreviosChat extends StatelessWidget {
  const PreviosChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72.h),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF792F0),
                Color(0xFFFABD63),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            leadingWidth: 200.w,
            title: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Text(
                  "الدردشات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Portada",
                  ),
                ),
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  SizedBox(width: 10.w),
                  Image.asset('assets/icons/group.png', width: 30.sp),
                  Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                    size: 25.sp,
                  ),
                  Text(
                    "العودة إلى الدردشة العامة",
                    style: TextStyle(
                      fontFamily: 'Portada',
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: GetBuilder<PreviosChatController>(
        init: PreviosChatController(),
        builder: (controller) => FutureBuilder(
          future: controller.getChats(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<dynamic>? chatData = snapshot.data as List<dynamic>?;

            if (chatData == null || chatData.isEmpty) {
              return const Center(
                child: Text("No chat data available"),
              );
            }

            return StreamBuilder(
              stream: controller.streamController.stream,
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: chatData.length,
                  itemBuilder: (context, index) {
                    String username = "";
                    String roomImage = "";

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          print("object");
                          Get.toNamed(
                            "/privateMessageRoom",
                            arguments: {
                              "username": username,
                              "room_id": Get.arguments!['roomId'],
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: const Color(0xFF43D0CA),
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    username,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  Text(
                                    chatData[index]["message"].toString(),
                                    style: TextStyle(
                                      color: const Color(0xff5C5E5E),
                                      fontFamily: 'Segoe UI',
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10.w),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(360.r),
                                  border: Border.all(
                                    color: const Color(0xFF707070),
                                    width: 1.w,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(360.r),
                                  child: Image.network(
                                    imageURL + roomImage,
                                    fit: BoxFit.cover,
                                    width: 50.w,
                                    height: 55.h,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.network(
                                      'https://lametnachat.com/upload/imageUser/anonymous.jpg',
                                      width: 50.w,
                                      height: 55.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
