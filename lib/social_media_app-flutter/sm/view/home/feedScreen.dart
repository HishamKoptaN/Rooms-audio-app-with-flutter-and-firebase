import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/postController.dart';
import '../../controllers/storyController.dart';
import '../../controllers/userController.dart';
import '../../utils/utils.dart';
import '../../view/commonWidgets/postWidget.dart';
import '../../view/home/story/createStoryScreen.dart';
import '../../view/home/story/storyScreen.dart';

class FeedScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            ///app bar of feed screen
            _feedScreenAppBar(context, ref),

            ///show all posts
            SliverToBoxAdapter(
              child: ref.watch(getFeedPostsControllerProvider).when(
                data: (data) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 5),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return PostWidget(postId: data[index].postId);
                      },
                    ),
                  );
                },
                error: (error, s) {
                  print(s);
                  return Text("${s}");
                },
                loading: () {
                  return Container(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loadingWidget(color: Colors.black, size: 50),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///feed scrreen app bar
  SliverAppBar _feedScreenAppBar(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      pinned: false,
      floating: true,
      expandedHeight: 171,
      title: Image.asset("assets/images/vine-text-type-logo.png", height: 60),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notification_add))
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _storyRowWidget(ref),
          ],
        ),
      ),
    );
  }

  Widget _storyRowWidget(WidgetRef ref) {
    //getting current user data
    return ref.watch(getUserByIdController(currentUserId)).when(
        data: (currentUser) {
      return Container(
          margin: EdgeInsets.only(top: 60),
          height: 100,
          child: ref
              .watch(getUsersWhoSharedStoriesControllerProvider(
                  currentUser.followings))
              .when(
                  data: (users) {
                    print("user length : ${users.length}");
                    return ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 13),
                        scrollDirection: Axis.horizontal,
                        itemCount: users.length + 1,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 18);
                        },
                        itemBuilder: (context, index) {
                          return index == 0
                              ? InkWell(
                                  onTap: () {
                                    navigatorPush(context,
                                        CreateStoryScreen(user: currentUser));
                                  },
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 67,
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        currentUser.profileImg),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Positioned(
                                              right: -1,
                                              bottom: -1,
                                              child: InkWell(
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () {},
                                                  child: Icon(Icons.add_circle,
                                                      color: Colors.black87)))
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Text("Your Story")
                                    ],
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    navigatorPush(
                                        context,
                                        StoryScreen(
                                            userId: users[index - 1].uid));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 67,
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      users[index - 1]
                                                          .profileImg),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text("${users[index - 1].name}")
                                    ],
                                  ),
                                );
                        });
                  },
                  error: (error, s) {
                    return Text("${error}");
                  },
                  loading: loadingWidget));
    }, error: (error, s) {
      return Text(error.toString());
    }, loading: () {
      return loadingWidget();
    });
  }
}
