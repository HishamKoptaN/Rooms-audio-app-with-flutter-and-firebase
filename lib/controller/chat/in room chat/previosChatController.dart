import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../userData/userCredentials.dart';
import '../../userData/variables.dart';

class PreviosChatController extends GetxController {
  StreamController streamController = StreamController();

  @override
  void onInit() {
    print("object");
    print(Get.arguments);
    super.onInit();
  }

  getChats() async {
    try {
      var url = Uri.parse(inRoomListOfChat);
      var response = await http.post(
        url,
        body: {"senderUserRoom": userName, "roomId": Get.arguments["roomId"]},
      );
      final dataBody = json.decode(response.body);

      update();
      streamController.sink.add(dataBody);
      print(dataBody);
    } catch (e) {}
  }
}
