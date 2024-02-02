import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/helper_time.dart';
import 'comment_button.dart';
import 'comments.dart';
import 'like.dart';

class WhisperPost extends StatefulWidget {
  const WhisperPost(
      {super.key,
      required this.message,
      required this.user,
      required this.postId,
      required this.likes,
      required this.time,
      required this.commentCount});
  final String time;
  final String message;
  final String user;
  final String postId;
  final List<String> commentCount;
  final List<String> likes;

  @override
  State<WhisperPost> createState() => _WhisperPostState();
}

class _WhisperPostState extends State<WhisperPost> {
  //User
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final commentTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  //toggle like and unlike
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //Store the state of like in firebase
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('User posts').doc(widget.postId);

    if (isLiked) {
      //if liked, record like
      docRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //if unliked, remove like
      docRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  //Add comments
  void addComment(String commentText) {
    //write comment to fireStore, into the comments collection
    FirebaseFirestore.instance
        .collection("User posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommenterID": currentUser.email,
      "CommentTime": Timestamp.now(),
    });

    //Store the state of comment in firebase
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('User posts').doc(widget.postId);

    if (isLiked) {
      //if liked, record like
      docRef.update({
        'Comments': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //if unliked, remove like
      docRef.update({
        'Comments': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  //Show comment dialog for adding it

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a comment"),
        content: TextField(
          controller: commentTextController,
          decoration: const InputDecoration(
            hintText: "Join this discussion",
          ),
        ),
        actions: [
          //Cancel comment button
          TextButton(
            onPressed: () {
              //Pop dialog
              Navigator.pop(context);

              //Clear controller
              commentTextController.clear();
            },
            child: const Text(
              "C A N C E L",
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
          ),
          //submit comment button
          TextButton(
            onPressed: () {
              //ad comment
              addComment(commentTextController.text);

              //Clear controller
              commentTextController.clear();

              //Pop dialog
              Navigator.pop(context);
            },
            child: const Text(
              "S U B M I T",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  //final String time;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            border: Border.all(width: 1),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360.r),
                    border: Border.all(
                      width: 1.w,
                    ),
                  ),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green.shade200,
                        child: const Icon(
                          Icons.person_2_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 25.sp,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.verified,
                              size: 22.sp,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      " • ${widget.time}",
                      style: const TextStyle(
                        color: Color(0xff000000),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      CommunityMaterialIcons.earth,
                      size: 17.sp,
                    ),
                  ],
                ),
                title: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        widget.user,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff000000),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                trailing: GestureDetector(
                  onTap: () {
                    // controller.deleteStories();
                    showDialog<void>(
                      context: context,
                      // barrierDismissible:
                      //     false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          content: SingleChildScrollView(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: ListBody(
                                children: <Widget>[
                                  // snapshot.data[index]
                                  //             [
                                  //             "username"] ==
                                  //         userName ?
                                  ListTile(
                                    onTap: () {
                                      // if (snapshot.data[index]["username"].toString() ==
                                      //     userName) {
                                      //   controller.deleteStory(snapshot.data[index]["id"].toString());
                                      // }
                                    },
                                    leading: const Icon(Icons.delete,
                                        color: Colors.black),
                                    horizontalTitleGap: 0.w,
                                    title: Text(
                                      "مسح",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // :
                                  const SizedBox(),
                                  ListTile(
                                    leading: const Icon(Icons.report,
                                        color: Colors.red),
                                    horizontalTitleGap: 0.w,
                                    title: Text(
                                      "تبليغ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Approve'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.more_vert),
                ),
              ),
              Container(
                width: 280,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    widget.message,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      // fontFamily: "Montserrat",
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    " ${widget.likes.length}  اعجاب ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFFA2ACAC),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    " ${widget.commentCount.length}  تعليقا ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFFA2ACAC),
                    ),
                  ),
                ],
              ),

              const Divider(height: 1),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 30),
                  Text(
                    "اعجبني",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFFA2ACAC),
                    ),
                  ),
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(width: 30),
                  Text(
                    "تعليق",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFFA2ACAC),
                    ),
                  ),
                  CommentButton(
                    onTap: showCommentDialog,
                  ),
                ],
              ),
              //Display comments
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("User posts")
                    .doc(widget.postId)
                    .collection("Comments")
                    .orderBy("CommentTime", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  //Loading..
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  //return comments
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map(
                      (doc) {
                        //get comments
                        final commentData = doc.data() as Map<String, dynamic>;

                        //return comments
                        return Comment(
                          user: commentData['CommenterID'],
                          text: commentData['CommentText'],
                          time: formatTime(commentData['CommentTime']),
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
