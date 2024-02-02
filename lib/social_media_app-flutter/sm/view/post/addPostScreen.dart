import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import '../../generated/locale_keys.g.dart';
import '../../utils/consts.dart';
import '../../controllers/postController.dart';
import '../../controllers/userController.dart';
import '../../models/userModel.dart';
import '../../utils/utils.dart';
import '../../view/mainScreen.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({
    super.key,
  });

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  bool isUpdate = false;

  @override
  void initState() {
    // if (widget.post != null) {
    //   isUpdate = true;
    //   postTextController.text = widget.post!.postDescription.toString();
    //   feeling = widget.post!.feeling!;
    //   setState(() {});
    // }
    super.initState();
  }

  TextEditingController postTextController = TextEditingController();
  String feeling = "";
  Uint8List? _postImage;

  _pickPostImage(bool isCamera) async {
    _postImage = await pickImage(isCamera);
    setState(() {});
  }

  //share post
  post() async {
    if (postTextController == "" && _postImage == null) {
      showMessageSnackBar(
          message: "Both image and post can't be empty!", context: context);
    } else {
      //to add a new post

      ref.watch(postControllerProvider.notifier).addNewPost(
          context: context,
          postDescription: postTextController.text,
          postImage: _postImage,
          feeling: feeling);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = ref.watch(currentUserProvider.notifier).state!;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            //top app bar
            _topAppBar(context),

            ref.watch(postControllerProvider)
                ? LinearProgressIndicator()
                : Container(),

            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 9),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.profileImg),
                  ),
                  SizedBox(width: 10),
                  Text("${user.name}"),
                  SizedBox(width: 10),
                  feeling != ""
                      ? Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _showFellingpickerDialog(context);
                                },
                                child: Text("- ${feeling}")),
                            SizedBox(width: 10),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    feeling = "";
                                  });
                                },
                                icon: Icon(IconlyBold.delete, size: 18))
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                autofocus: true,
                controller: postTextController,
                decoration: InputDecoration(
                    hintText: "${tr(LocaleKeys.lblwhatsonyourmind)}",
                    hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none),
              ),
            ),

            _postImage == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    width: double.infinity,
                    height: 270,
                    child: Stack(children: [
                      Container(
                          height: 270,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: Image.memory(_postImage!, fit: BoxFit.cover)),
                      Positioned(
                          right: 10,
                          child: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _postImage = null;
                                });
                              }))
                    ]),
                  ),

            // SizedBox(
            //     height: _postImage == null && widget.post == null
            //         ? MediaQuery.of(context).size.height / 2
            //         : 180),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {
                    _pickPostImage(false);
                  },
                  leading: Icon(Icons.photo),
                  title: Text(tr(LocaleKeys.lblPhoto)),
                ),

                //
                ListTile(
                  onTap: () {
                    _pickPostImage(true);
                  },
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text(tr(LocaleKeys.lblCamera)),
                ),

                ListTile(
                  onTap: () {
                    _showFellingpickerDialog(context);
                  },
                  leading: Icon(Icons.emoji_emotions_outlined),
                  title: Text(tr(LocaleKeys.lblFeelings)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row _topAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              navigatorPushReplacement(context, MainScreen());
            },
            icon: Icon(Icons.clear)),
        SizedBox(width: 15),
        Text(tr(LocaleKeys.lblNewPost), style: TextStyle(fontSize: 18)),
        Spacer(),
        TextButton(
            onPressed: () {
              //share a post
              post();
            },
            child: Text("${tr(LocaleKeys.lblPost)}"))
      ],
    );
  }

  //show felling picker dialog
  Future<dynamic> _showFellingpickerDialog(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              ListTile(
                title: Text("${feeling}"),
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        feeling = "";
                      });
                    },
                    icon: Icon(Icons.clear)),
              ),
              Divider(),
              Expanded(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
                    separatorBuilder: (c, index) {
                      return SizedBox(height: 25);
                    },
                    shrinkWrap: true,
                    itemCount: Constants.feelings.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            feeling = Constants.feelings[index];
                          });
                          Navigator.pop(context);
                        },
                        child: Text("${Constants.feelings[index]}",
                            style: TextStyle(fontSize: 17)),
                      );
                    }),
              )
            ],
          );
        });
  }
}
