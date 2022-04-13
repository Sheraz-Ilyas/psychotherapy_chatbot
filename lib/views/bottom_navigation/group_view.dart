import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/controllers/community_controller.dart';
import 'package:psychotherapy_chatbot/models/community_post.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';
import 'package:psychotherapy_chatbot/services/database.dart';

class GroupView extends StatefulWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  CommunityController communityController = Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: communityController.communityPosts.isEmpty
            ? Colors.white
            : Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:
              Text('Community', style: Theme.of(context).textTheme.headline1),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: blue,
            labelColor: blue,
            unselectedLabelColor: Colors.grey[500],
            labelStyle:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
            tabs: const [
              Tab(
                text: 'Discover',
              ),
              Tab(
                text: 'Your Posts',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => communityController.communityPosts.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      Image.asset(
                        'assets/images/community.jpg',
                        width: 300,
                        height: 300,
                      ),
                      Text(
                        "You will read other people stories here!",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: communityController.communityPosts.length,
                    itemBuilder: ((context, index) {
                      return PostWidget(
                        post: communityController.communityPosts[index],
                      );
                    }))),
            Obx(() => communityController.communityPosts.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12),
                      Image.asset(
                        'assets/images/community_post.jpg',
                        width: 275,
                        height: 275,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Text(
                        "Share your first story!",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: communityController.communityPosts.length,
                    itemBuilder: ((context, index) {
                      return PostWidget(
                        post: communityController.communityPosts[index],
                      );
                    }))),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigationController.navigateTo(newPost);
          },
          label: Text(
            "New Post",
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: blue,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PostWidget extends StatefulWidget {
  PostWidget({Key? key, this.post}) : super(key: key);
  CommunityPost? post;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  CommunityController communityController = Get.find<CommunityController>();
  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Image.asset("assets/images/robot.png"),
              ),
              title: Text(
                widget.post!.author!,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14),
              ),
              subtitle: Text(
                widget.post!.date.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 12, color: Colors.black54),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                widget.post!.title!,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                widget.post!.description!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (communityController.helpfulPosts
                          .contains(widget.post!.id)) {
                        communityController.helpfulPosts
                            .remove(widget.post!.id);
                      } else {
                        communityController.helpfulPosts.add(widget.post!.id!);
                      }
                    },
                    child: Row(
                      children: [
                        Obx(
                          () => Icon(
                            Icons.favorite,
                            size: 20,
                            color: communityController.helpfulPosts
                                    .contains(widget.post!.id)
                                ? Colors.red[600]
                                : Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Helpful",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (communityController.readPosts
                          .contains(widget.post!.id)) {
                        communityController.readPosts.remove(widget.post!.id);
                      } else {
                        communityController.readPosts.add(widget.post!.id!);
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          "Read",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 14, color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 5),
                        Obx(
                          () => Icon(
                            Icons.chrome_reader_mode,
                            size: 20,
                            color: communityController.readPosts
                                    .contains(widget.post!.id)
                                ? Colors.green[300]
                                : Colors.grey[300],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
