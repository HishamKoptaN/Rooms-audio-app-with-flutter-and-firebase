import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../userData/userCredentials.dart';
import '../userData/variables.dart';

class ChangeBackgroundController extends GetxController {
  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  getData() async {
    var uri = Uri.parse(getBackgrounds);
    var res = await http.post(uri);

    var dataBody = json.decode(res.body);
    print(dataBody);
    return dataBody;
  }

  changeUserBackground(String background) async {
    var uri = Uri.parse(updateBackground);
    var res = await http.post(uri, body: {
      "selectedBG": background,
      "username": userName,
    });

    var dataBody = json.decode(res.body);
    print(dataBody);
    // return dataBody;
    if (res.statusCode == 200) {
      Get.snackbar(
        "تم تغيير الخلفية",
        "تم تغيير خلفية الاسم بنجاح",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
