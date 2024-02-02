
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../else/chat_four/constants.dart';
import '../chat/chat_service.dart';
import '../components/my_text_field.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receverUserId;

  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              // يمكنك استخدام صورة المستخدم هنا أو تركها فارغة
              // أو تستخدم أي مكون آخر حسب احتياجاتك
              backgroundColor: Colors.grey,
              radius: 25,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiverUserEmail,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // يمكنك إضافة حالة الاتصال هنا (على سبيل المثال، أخر ظهور)
              ],
            ),
          ],
        ),
        // actions: [
        //   // أي أيقونات إضافية يمكنك إضافتها هنا (مثل زر الاتصال)
        //   IconButton(
        //     icon: const Icon(Icons.phone),
        //     onPressed: () {
        //       // رمز الإجراء عند النقر على أيقونة الهاتف
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessage(
            widget.receverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading....');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildLastMessage() {
    return StreamBuilder(
        stream: _chatService.getLastMessage(
            widget.receverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading....');
          }
          return Column(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var isCurrentUser = (data['senderId'] == _firebaseAuth.currentUser!.uid);
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.green : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                data['message'],
                style: TextStyle(
                    color: isCurrentUser ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w200,
                    fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            // Text(
            //   data['senderEmail'],
            //   style: const TextStyle(fontSize: 12, color: Colors.grey),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.sentiment_satisfied_alt_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {
              // إضافة مزايا إضافية للرموز الضاحكة أو الوجوه التعبيرية
            },
          ),
          const SizedBox(width: kDefaultPadding / 4),
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Enter message",
              obscureText: false,
            ),
          ),
          const SizedBox(width: kDefaultPadding / 4),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 30,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: kDefaultPadding / 4),
          IconButton(
            icon: const Icon(
              Icons.attach_file,
              color: kPrimaryColor,
            ),
            onPressed: () {
              // إضافة إمكانية إرفاق ملف
            },
          ),
          const SizedBox(width: kDefaultPadding / 4),
          IconButton(
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {
              // إضافة إمكانية التقاط صورة
            },
          ),
        ],
      ),
    );
  }

  Future<DocumentSnapshot?> getLastMessage(
      String userId, String otherUserId) async {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("message")
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching last message: $e');
      return null;
    }
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']!) {
      return FutureBuilder<DocumentSnapshot?>(
        future: getLastMessage(_auth.currentUser!.uid, data['uid']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            String lastMessage = snapshot.data?['message'] ?? 'No messages yet';
            DateTime timestamp =
                snapshot.data?['timestamp']?.toDate() ?? DateTime.now();
            String formattedTime = DateFormat('HH:mm').format(timestamp);

            return ListTile(
              leading: const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(''),
              ),
              title: Text(data['name']!),
              subtitle: Text(lastMessage),
              trailing: Text(formattedTime),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiverUserEmail: data['email']!,
                      receverUserId: data['uid']!,
                    ),
                  ),
                );
              },
            );
          }
        },
      );
    } else {
      return Container();
    }
  }
}
