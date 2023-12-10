// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, use_full_hex_values_for_flutter_colors, use_key_in_widget_constructors
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/moments/postMomentController.dart';
import '../../controller/userData/userCredentials.dart';
import '../../controller/userData/variables.dart';
import 'viewComments.dart';

class Moments extends StatefulWidget {
  const Moments({super.key});
  @override
  _MomentsState createState() => _MomentsState();
}

class _MomentsState extends State<Moments> {
  final ScrollController _scrollController = ScrollController();
  final List<int> _dataList = List.generate(20, (index) => index + 1);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reach the end of the list, load more data
      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    if (!_isLoading) {
      setState(
        () {
          _isLoading = true;
        },
      );

      // Simulate fetching data from an API or another source
      await Future.delayed(const Duration(seconds: 3));

      // Add more data to the list
      List<int> newData =
          List.generate(10, (index) => _dataList.length + index + 1);
      _dataList.addAll(newData);

      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 15.h,
          ),
          GetBuilder<PostMomentController>(
            init: PostMomentController(),
            builder: (controller) {
              return FutureBuilder(
                future: controller.getAllStories(),
                builder: (context, snapshot) {
                  return StreamBuilder(
                    stream: controller.streamController.stream,
                    builder: (context, snapshot) => snapshot.data == null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: ListView.builder(
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/viewComments",
                                        arguments: snapshot.data[index]);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 6.h),
                                    child: Container(
                                      width: 366.w,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF00000029)
                                                .withOpacity(0.2),
                                            spreadRadius: 0.5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            dense: true,
                                            horizontalTitleGap: 5.w,
                                            leading: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.r),
                                              ),
                                              child: SizedBox(
                                                width: 47.w,
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    360.r),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xff2CCFB6),
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    360.r),
                                                        child: Image.network(
                                                          "$imageURL${snapshot.data[index]["username"]}.jpeg",
                                                          height: 39.sp,
                                                          width: 39.sp,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.network(
                                                            "https://lametnachat.com/upload/imageUser/anonymous.jpg",
                                                            fit: BoxFit.cover,
                                                            height: 39.sp,
                                                            width: 39.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 0,
                                                      bottom: 0,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            size: 25.sp,
                                                            color: Colors.white,
                                                          ),
                                                          Icon(
                                                            Icons.verified,
                                                            size: 22.sp,
                                                            color: Colors.blue,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            title: SizedBox(
                                              height: 3.h,
                                              child: Text(
                                                snapshot.data[index]["username"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Portada",
                                                    color: const Color(
                                                        0xff000000)),
                                              ),
                                            ),
                                            // تاريخ النشر
                                            subtitle: SizedBox(
                                              height: 20.h,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    convertTime(
                                                            snapshot.data[index]
                                                                ["timeafter"])
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xff000000)),
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Icon(
                                                    CommunityMaterialIcons
                                                        .earth,
                                                    size: 17.sp,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: GestureDetector(
                                              onTap: () {
                                                // controller.deleteStories();
                                                DetialsPostDialg(
                                                    context,
                                                    snapshot,
                                                    index,
                                                    controller);
                                              },
                                              child: const Icon(
                                                Icons.more_vert,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          // محتوي البوست
                                          Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: snapshot.data[index]
                                                                    ["text"]
                                                                .toString() ==
                                                            ""
                                                        ? SizedBox()
                                                        : Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        29.w,
                                                                    vertical:
                                                                        5.h),
                                                            child: Text(
                                                              snapshot
                                                                  .data[index]
                                                                      ["text"]
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                // fontFamily: "Montserrat",
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(5),
                                                    child: snapshot.data[index]
                                                                    ["image"]
                                                                .toString() ==
                                                            ""
                                                        ? const SizedBox()
                                                        : GestureDetector(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                "/viewImage",
                                                                arguments: {
                                                                  "imageLink": storiesImage +
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                              [
                                                                              "image"]
                                                                          .toString(),
                                                                },
                                                              );
                                                            },
                                                            child:
                                                                Image.network(
                                                              storiesImage +
                                                                  snapshot.data[
                                                                          index]
                                                                          [
                                                                          "image"]
                                                                      .toString(),
                                                              height: 400.h,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${snapshot.data[index]["likeCount"]} اعجاب ",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color:
                                                      const Color(0xFFA2ACAC),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                "${snapshot.data[index]["commentCount"]} تعليقا ",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color:
                                                      const Color(0xFFA2ACAC),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 23.w,
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller.likeStory(snapshot
                                                      .data[index]["id"]
                                                      .toString());
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      snapshot.data[index]
                                                              ["liked"]
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color:
                                                          snapshot.data[index]
                                                                  ["liked"]
                                                              ? Colors.red
                                                              : Colors.black,
                                                      size: 25.r,
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                      "اعجبني",
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "Montserrat",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/viewComments",
                                                      arguments:
                                                          snapshot.data[index]);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CommunityMaterialIcons
                                                          .comment_text_outline,
                                                      color: Colors.black,
                                                      size: 25.r,
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                      'تعليق',
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "Montserrat",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: isGuest == false && isRole == false
          ? FloatingActionButton(
              onPressed: () {
                Get.toNamed('/postMoment');
              },
              backgroundColor: Color.fromARGB(255, 9, 12, 65),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}

// class Moments extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbarBuilder("اللحظات", false),
//       backgroundColor: Colors.white.withOpacity(0.95),
//       body: ListView(
//         children: [
//           SizedBox(
//             height: 15.h,
//           ),
//           GetBuilder<PostMomentController>(
//             init: PostMomentController(),
//             builder: (controller) {
//               return FutureBuilder(
//                 future: controller.getAllStories(),
//                 builder: (context, snapshot) {
//                   return StreamBuilder(
//                     stream: controller.streamController.stream,
//                     builder: (context, snapshot) => snapshot.data == null
//                         ? Center(child: CircularProgressIndicator())
//                         : ListView.builder(
//                             reverse: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: snapshot.data.length,
//                             itemBuilder: (context, index) => Directionality(
//                               textDirection: TextDirection.rtl,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Get.toNamed("/viewComments",
//                                       arguments: snapshot.data[index]);
//                                 },
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 10.w, vertical: 6.h),
//                                   child: Container(
//                                     width: 366.w,
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 15.h),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(20.r),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Color(0xFF00000029)
//                                               .withOpacity(0.2),
//                                           spreadRadius: 0.5,
//                                           blurRadius: 7,
//                                           offset: Offset(0, 3),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         ListTile(
//                                           dense: true,
//                                           horizontalTitleGap: 5.w,
//                                           leading: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(100.r),
//                                             ),
//                                             child: SizedBox(
//                                               width: 47.w,
//                                               child: Stack(
//                                                 children: [
//                                                   Container(
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               360.r),
//                                                       border: Border.all(
//                                                         color:
//                                                             Color(0xff2CCFB6),
//                                                         // color: Colors.black,
//                                                         width: 1.w,
//                                                       ),
//                                                     ),
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               360.r),
//                                                       child: Image.network(
//                                                         imageURL +
//                                                             snapshot.data[index]
//                                                                     ["username"]
//                                                                 .toString() +
//                                                             ".jpeg",
//                                                         height: 39.sp,
//                                                         width: 39.sp,
//                                                         fit: BoxFit.cover,
//                                                         errorBuilder: (context,
//                                                                 error,
//                                                                 stackTrace) =>
//                                                             Image.network(
//                                                           "https://lametnachat.com/upload/imageUser/anonymous.jpg",
//                                                           fit: BoxFit.cover,
//                                                           height: 39.sp,
//                                                           width: 39.sp,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Positioned(
//                                                     left: 0,
//                                                     bottom: 0,
//                                                     child: Stack(
//                                                       alignment:
//                                                           Alignment.center,
//                                                       children: [
//                                                         Icon(
//                                                           Icons.circle,
//                                                           size: 25.sp,
//                                                           color: Colors.white,
//                                                         ),
//                                                         Icon(
//                                                           Icons.verified,
//                                                           size: 22.sp,
//                                                           color: Colors.blue,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           title: SizedBox(
//                                             height: 25.h,
//                                             child: Text(
//                                               snapshot.data[index]["username"]
//                                                   .toString(),
//                                               style: TextStyle(
//                                                   fontSize: 18.sp,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: "Portada",
//                                                   color: Color(0xff000000)),
//                                             ),
//                                           ),
//                                           subtitle: SizedBox(
//                                             height: 20.h,
//                                             child: Row(
//                                               children: [
//                                                 Text(
//                                                   convertTime(
//                                                           snapshot.data[index]
//                                                               ["timeafter"])
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 13.sp,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Color(0xff000000)),
//                                                 ),
//                                                 SizedBox(width: 5.w),
//                                                 Icon(
//                                                   CommunityMaterialIcons.earth,
//                                                   size: 17.sp,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           trailing: GestureDetector(
//                                             onTap: () {
//                                               // controller.deleteStories();
//                                               postShowDialg(context, snapshot,
//                                                   index, controller);
//                                             },
//                                             child: Icon(
//                                               Icons.more_vert,
//                                               size: 20,
//                                             ),
//                                           ),
//                                         ),
//                                         snapshot.data[index]["text"]
//                                                     .toString() ==
//                                                 ""
//                                             ? SizedBox()
//                                             : Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 29.w,
//                                                     vertical: 5.h),
//                                                 child: Text(
//                                                   snapshot.data[index]["text"]
//                                                       .toString(),
//                                                   textAlign: TextAlign.right,
//                                                   style: TextStyle(
//                                                     fontSize: 15.sp,
//                                                     fontWeight: FontWeight.w400,
//                                                     fontFamily: "Montserrat",
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                         snapshot.data[index]["image"]
//                                                     .toString() ==
//                                                 ""
//                                             ? SizedBox()
//                                             : GestureDetector(
//                                                 onTap: () {
//                                                   Get.toNamed(
//                                                     "/viewImage",
//                                                     arguments: {
//                                                       "imageLink":
//                                                           storiesImage +
//                                                               snapshot
//                                                                   .data[index]
//                                                                       ["image"]
//                                                                   .toString(),
//                                                     },
//                                                   );
//                                                 },
//                                                 child: Image.network(
//                                                   storiesImage +
//                                                       snapshot.data[index]
//                                                               ["image"]
//                                                           .toString(),
//                                                   height: 400.h,
//                                                   width: double.infinity,
//                                                 ),
//                                               ),
//                                         SizedBox(
//                                           height: 23.h,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               snapshot.data[index]["likeCount"]
//                                                       .toString() +
//                                                   " اعجاب ",
//                                               style: TextStyle(
//                                                 fontSize: 13.sp,
//                                                 color: Color(0xFFA2ACAC),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 5.w,
//                                             ),
//                                             Text(
//                                               snapshot.data[index]
//                                                           ["commentCount"]
//                                                       .toString() +
//                                                   " تعليقا ",
//                                               style: TextStyle(
//                                                 fontSize: 13.sp,
//                                                 color: Color(0xFFA2ACAC),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 23.w,
//                                             ),
//                                           ],
//                                         ),
//                                         Divider(),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 controller.likeStory(snapshot
//                                                     .data[index]["id"]
//                                                     .toString());
//                                               },
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     snapshot.data[index]
//                                                             ["liked"]
//                                                         ? Icons.favorite
//                                                         : Icons.favorite_border,
//                                                     color: snapshot.data[index]
//                                                             ["liked"]
//                                                         ? Colors.red
//                                                         : Colors.black,
//                                                     size: 25.r,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 7.w,
//                                                   ),
//                                                   Text(
//                                                     "اعجبني",
//                                                     style: TextStyle(
//                                                       fontSize: 13.sp,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       fontFamily: "Montserrat",
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 Get.toNamed("/viewComments",
//                                                     arguments:
//                                                         snapshot.data[index]);
//                                               },
//                                               child: Row(
//                                                 children: [
//                                                   Icon(
//                                                     CommunityMaterialIcons
//                                                         .comment_text_outline,
//                                                     color: Colors.black,
//                                                     size: 25.r,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 7.w,
//                                                   ),
//                                                   Text(
//                                                     'تعليق',
//                                                     style: TextStyle(
//                                                       fontSize: 15.sp,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       fontFamily: "Montserrat",
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: isGuest == false && isRole == false
//           ? FloatingActionButton(
//               onPressed: () {
//                 Get.toNamed('/postMoment');
//               },
//               backgroundColor: Color(0xffFFC700),
//               child: Icon(Icons.edit),
//             )
//           : null,
//     );
//   }

Future<dynamic> DetialsPostDialg(
    BuildContext context,
    AsyncSnapshot<dynamic> snapshot,
    int index,
    PostMomentController controller) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        content: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListBody(
              children: <Widget>[
                snapshot.data[index]["username"] == userName
                    ? ListTile(
                        onTap: () {
                          if (snapshot.data[index]["username"].toString() ==
                              userName) {
                            controller.deleteStory(
                                snapshot.data[index]["id"].toString());
                          }
                        },
                        leading: Icon(Icons.delete, color: Colors.black),
                        horizontalTitleGap: 0.w,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "مسح",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 10,
                      ),
                ListTile(
                  leading: Icon(Icons.report, color: Colors.red),
                  horizontalTitleGap: 0.w,
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "تبليغ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Approve',
              style: TextStyle(fontSize: 12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Widget momentsBuilder(String name, String message, String image,
//     String likeCount, bool isLiked) {
//   return
// }

Widget buildMyNavBar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: SizedBox(
      height: 46.h,
      width: 366.w,
      child: SizedBox(
        width: 366.w,
        height: 46.h,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            cursorColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontFamily: "Portada",
            ),
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              hintText: 'اكتب شيئا',

              hintStyle: TextStyle(
                  fontSize: 11.sp,
                  fontFamily: "Portada",
                  color: Color(0xffA2ACAC)),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffFABD63),
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffFABD63),
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffFABD63),
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              filled: true,
              fillColor: Colors.white, // Color(0xff00000029),
            ),
          ),
        ),
      ),
    ),
  );
}
