import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/models/community_post.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';

class GroupView extends StatefulWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  List<CommunityPost> postsList = [
    CommunityPost(
      title: "How to use the app?",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      date: DateTime.now(),
    ),
  ];

  bool isLiked = false;
  bool isRead = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Community', style: Theme.of(context).textTheme.headline1),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: postsList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Image.asset("assets/images/robot.png"),
                      ),
                      title: Text(
                        "Ahmed Nawaz",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 16),
                      ),
                      subtitle: Text(
                        postsList[index].date.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Text(
                        postsList[index].title!,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Text(
                        postsList[index].description!,
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
                              setState(() {
                                isLiked = !isLiked;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 25,
                                  color: isLiked
                                      ? Colors.red[600]
                                      : Colors.grey[300],
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Like",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isRead = !isRead;
                              });
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Read",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 16,
                                          color: Colors.grey[600]),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.chrome_reader_mode,
                                  size: 25,
                                  color: isRead
                                      ? Colors.green[300]
                                      : Colors.grey[300],
                                ),
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
          })),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FloatingActionButton.extended(
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
