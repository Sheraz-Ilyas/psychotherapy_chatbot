import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/controllers/auth_controller.dart';
import 'package:psychotherapy_chatbot/controllers/community_controller.dart';
import 'package:psychotherapy_chatbot/models/community_post.dart';
import 'package:psychotherapy_chatbot/models/user.dart';
import 'package:psychotherapy_chatbot/services/database.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class NewPost extends StatefulWidget {
  NewPost({Key? key, this.post}) : super(key: key);

  CommunityPost? post;

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final AuthController _authController = Get.put(AuthController());
  CommunityController communityController = Get.find<CommunityController>();
  DatabaseMethods databaseMethods = DatabaseMethods();

  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  getUsername() async {
    UserLocal user = await databaseMethods
        .getUser(_authController.firebaseUser!.uid)
        .then((value) => value);
    _authController.localUser.value = user;
  }

  void _saveForm() {
    getUsername();
    var uuid = const Uuid();
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      if (widget.post == null) {
        CommunityPost post = CommunityPost(
            id: uuid.v1().toString(),
            title: _titleController.text,
            description: _descriptionController.text,
            date: DateTime.now(),
            author: _authController.localUser.value.name!.split(' ').first);
        databaseMethods.uploadPost(post, _authController.firebaseUser!.uid);
        Get.snackbar(
          '',
          '',
          titleText: Text(
            'Saved',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
          ),
          messageText: Text(
            'Post Added Successfully',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } else {
        communityController.communityPosts.indexWhere((element) {
          if (element.id == widget.post!.id) {
            element.title = _titleController.text;
            element.description = _descriptionController.text;
            element.date = DateTime.now();
          }

          return element.id == widget.post!.id;
        });
        Get.snackbar(
          '',
          '',
          titleText: Text(
            'Saved',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
          ),
          messageText: Text(
            'Post Updated Successfully',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
      navigationController.goBack();
    }
  }

  @override
  void initState() {
    if (widget.post != null) {
      _titleController.text = widget.post!.title!;
      _descriptionController.text = widget.post!.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  _saveForm();
                },
                child: Text(
                  'Save',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            child: Column(children: [
              Form(
                key: _keyForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 22,
                                  color: Colors.grey,
                                ),
                        border: InputBorder.none,
                      ),
                      validator: (value) => null,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 10,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: 'Share your thoughts',
                        hintStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                        border: InputBorder.none,
                      ),
                      validator: (value) => null,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
