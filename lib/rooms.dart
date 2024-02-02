import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'all_app_bar.dart';
import 'constants.dart';
import 'live_page.dart';

class RoomListScreenn extends StatelessWidget {
  RoomListScreenn({super.key});
  final layoutValueNotifier =
      ValueNotifier<LayoutMode>(LayoutMode.defaultLayout);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(27.r),
              bottomRight: Radius.circular(27.r),
            ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 99, 169, 250),
                Color.fromARGB(255, 170, 146, 247),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const HomeAppBar(),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Rooms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // استخراج البيانات من الوثائق
          final roomDocuments = snapshot.data?.docs;

          // بناء قائمة الغرف باستخدام ListView
          return RoomsShow(roomDocuments!);
        },
      ),
    );
  }

  ListView RoomsShow(List<QueryDocumentSnapshot<Object?>> roomDocuments) {
    return ListView.builder(
      itemCount: roomDocuments.length,
      itemBuilder: (context, index) {
        final roomData = roomDocuments[index].data() as Map<String, dynamic>;

        // استخراج قيمة حقلي RoomCaption و RoomName
        final roomCaption = roomData['RoomCaption'] ?? '';
        final roomPicture = roomData['RoomPicture'] ?? '';
        final roomName = roomData['RoomName'] ?? '';
        final ownerId = roomData['OwnerId'] ?? '';
        final roomId = roomData['OwnerId'] ?? '';
        final roomFavorites = roomData['OwnerId'] ?? '';
        // بناء عنصر القائمة
        final layoutValueNotifier =
            ValueNotifier<LayoutMode>(LayoutMode.defaultLayout);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: GestureDetector(
            onTap: () => jumpToLivePage(
              context,
              roomID: roomId.toString(),
              // roomIDTextCtrl.text.trim(),
              isHost: true, roomName: roomName.toString(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(197, 183, 163, 205),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 1, 16, 41),
                      image: DecorationImage(
                        image: NetworkImage(roomPicture),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          blurRadius: 3,
                          offset: Offset(0, 3),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      roomName,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(197, 155, 132, 182),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        height: 30,
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/flags/palestine.png',
                                fit: BoxFit.contain,
                                width: 40.w,
                                height: double.infinity,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'iD' + roomId,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Transform.rotate(
                        angle: -30 * (3.141592653589793 / 180),
                        child: Image.asset(
                          'assets/images/message.png',
                          fit: BoxFit.cover,
                          width: 60.w,
                          height: 35.h,
                        ),
                      ),
                      Transform.rotate(
                        angle: -30 * (3.141592653589793 / 180),
                        child: Image.asset(
                          'assets/images/Mic.png',
                          fit: BoxFit.cover,
                          width: 30.w,
                          height: 10.h,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      const Icon(Icons.favorite),
                      const SizedBox(height: 10),
                      Container(
                        width: 17.sp,
                        height: 17.sp,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/waves.gif"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Text(roomCaption)
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> jumpToLivePage(BuildContext context,
      {required String roomID,
      required String roomName,
      required bool isHost}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          roomID: roomID,
          isHost: isHost,
          layoutMode: layoutValueNotifier.value,
        ),
      ),
    );
  }
}
