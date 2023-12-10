import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../userData/userCredentials.dart';
import '../userData/variables.dart';

class PrivateMessagesController extends GetxController {
  TextEditingController messageController = TextEditingController();
  StreamController streamController = StreamController();
  late Timer _timer;

  @override
  Future<void> onInit() async {
    super.onInit();
    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        // return getData();
      },
    );
  }

  Future<void> getData() async {
    try {
      var url = Uri.parse(getPrivateMessages);
      var response = await http.post(
        url,
        body: {
          "sender": userId,
          "reciever": Get.arguments[2],
        },
      );
      final dataBody = json.decode(response.body);

      update();
      streamController.sink.add(dataBody);
    } catch (e) {}
  }

  Future sendMsg() async {
    var url = Uri.parse(sendPrivateMessage);

    if (messageController.text.trim() != "") {
      var response = await http.post(
        url,
        body: {
          "sender": userId,
          "reciever": Get.arguments[2],
          "text": messageController.text.trim(),
        },
      );
      final dataBody = json.decode(response.body);
      if (dataBody['status'] == "success") {
        messageController.text = "";
        if (kDebugMode) {
          print("success");
        }
      } else {
        if (kDebugMode) {
          print("error");
        }
      }
    }
  }
}
