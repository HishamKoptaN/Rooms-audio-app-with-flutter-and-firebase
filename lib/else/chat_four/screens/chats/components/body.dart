import '../../../components/filled_outline_button.dart';
import '../../../constants.dart';
import '../../../models/Chat.dart';
import '../../../screens/messages/message_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chat_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding * 0.75),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: 'Recent Message'),
              const SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: 'Active',
                isFilled: false,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: ((context, index) => ChatCard(
                  chat: chatsData[index],
                  press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessagesScreen())),
                )),
          ),
        )
      ],
    );
  }
}
