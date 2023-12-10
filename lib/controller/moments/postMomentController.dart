// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../userData/userCredentials.dart';
import '../userData/variables.dart';

class PostMomentController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  StreamController streamController = StreamController();
  var pickedFile;
  var imagePath;
  bool withImage = false;
  getImageFromGallery() async {
    // pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   imagePath = File(pickedFile.path);
    //   withImage = true;
    //   update();
    //   return File(pickedFile.path);
    // }
  }

  deleteImage() {
    pickedFile = null;
    imagePath = null;
    withImage = false;

    update();
  }

  storyWithTextOnly() async {
    if (textEditingController.text != "") {
      await http.post(
        Uri.parse(addStory),
        body: {
          "username": userName,
          "text": textEditingController.text,
        },
      );
    }
  }

  void storyWithImage() async {
    // await pickImage();
    await getImageFromGallery();
    var request = http.MultipartRequest('POST', Uri.parse(addStoryWithImage));

    request.fields['username'] = userName;
    request.fields['text'] = textEditingController.text;
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imagePath.path,
        filename: "$userName.jpeg".toString(),
      ),
    );
    var response = await request.send();
    print("object");

    // Process the response
    if (response.statusCode == 200) {
      // Image successfully uploaded
      print('Image uploaded!');
      // Get.put(ProfileController()).getData();
      //  getData();
    } else {
      // Error occurred
      print('Error uploading image. Status code: ${response.statusCode}');
    }
  }

  getAllStories() async {
    var res = await http.post(
        Uri.parse('https://lametnachat.com/stories/viewstories.php'),
        body: {
          "username": userName,
        });
    var dataBody = json.decode(res.body);
    streamController.sink.add(dataBody["data"]);
    update();
    // print(dataBody);
    // return dataBody["data"];
  }

  Future<void> postStory() async {
    if (withImage) {
      // لا تحتاج إلى استخدام القيمة المرجعة، لذا يمكن استخدام await بدون تخزين القيمة
      // await storyWithImage();
    } else {
      await storyWithTextOnly();
    }
    textEditingController.clear();
    Get.back();
  }

  deleteStory(String storyId) async {
    var res = await http.post(Uri.parse(deleteStoryUrl), body: {
      // "username": userName,
      "storyId": storyId,
    });
    var dataBody = json.decode(res.body);
    if (res.statusCode == 200) {
      Get.snackbar("تم", "تم حذف القصة بنجاح",
          snackPosition: SnackPosition.BOTTOM);
      // print(dataBody);
    }
    // getAllStories();
    print("deleted");

    // return dataBody["data"];
  }

  likeStory(String storyId) async {
    if (isGuest == false && isRole == false) {
      var res = await http.post(Uri.parse(likeStoryUrl), body: {
        "username": userName,
        "storyId": storyId,
      });
      var dataBody = json.decode(res.body);
      if (res.statusCode == 200) {
        Get.snackbar("تم", dataBody["message"],
            snackPosition: SnackPosition.BOTTOM);
        // print(dataBody);
      }
    } else {
      Get.defaultDialog(
        barrierDismissible: false,
        title: "تنبيه",
        titleStyle: TextStyle(
          fontSize: 22.sp,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        content: Text(
          "الاعجاب متاح للمستخدمين فقط",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        confirm: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF792F0),
                  Color(0xFFFABD63),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text(
              "حسنا",
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    // getAllStories();
    // print("liked");

    // return dataBody["data"];
  }
}
