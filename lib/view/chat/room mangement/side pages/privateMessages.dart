// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/chat/room managment/roomSettingsController.dart';
import '../../../widgets/all_app_bar.dart';

class PrivateMessages extends StatelessWidget {
  const PrivateMessages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarBuilder("الرسائل الخاصة", true),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<RoomSettingController>(builder: (controller) {
          return Column(
            children: [
              RadioListTile(
                title: Text(
                  "الجميع",
                  style: TextStyle(color: Colors.black),
                ),
                value: "all",
                groupValue: controller.privateMessageStatus,
                onChanged: (value) {
                  controller.changePrivateMessagesRadio(value as String);
                },
              ),
              RadioListTile(
                title: Text(
                  "الأعضاء والمشرفين فقط",
                  style: TextStyle(color: Colors.black),
                ),
                value: "membersAndAdmins",
                groupValue: controller.privateMessageStatus,
                onChanged: (value) {
                  controller.changePrivateMessagesRadio(value as String);
                  // setState(() {});
                },
              ),
              RadioListTile(
                title: Text(
                  "المشرفين فقط",
                  style: TextStyle(color: Colors.black),
                ),
                value: "adminsOnly",
                groupValue: controller.privateMessageStatus,
                onChanged: (value) {
                  controller.changePrivateMessagesRadio(value as String);
                  // setState(() {});
                },
              ),
              RadioListTile(
                title: Text(
                  "لا أحد",
                  style: TextStyle(color: Colors.black),
                ),
                value: "nobody",
                groupValue: controller.privateMessageStatus,
                onChanged: (value) {
                  // setState(() {});
                  controller.changePrivateMessagesRadio(value as String);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
