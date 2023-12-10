import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../userData/variables.dart';

class MessagesController extends GetxController {
  var data = [];
  TextEditingController searchController = TextEditingController();
  Future search() async {
    var url = Uri.parse(userSearch);
    var response = await http.post(url, body: {
      "search": searchController.text.trim().toString(),
    });
    final dataBody = json.decode(response.body);
    if (dataBody['status'] == "success") {
      print(dataBody);

      for (var i = 0; i < dataBody["data"].length; i++) {
        print(dataBody["data"][i]["username"]);
      }
      // return dataBody;
      data = dataBody["data"];
      print(dataBody);
      update();

      print("success");
    } else {
      print("error");
    }
  }

  getData() {}
}
