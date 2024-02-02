import 'package:flutter/material.dart';

import '../model/home_page_chat_model.dart';

class HomePageChatView extends StatelessWidget {
  HomePageChatView({super.key});

  var homeModel = HomePageChatModel();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Text(homeModel.one),
      ),
    );
  }
}
