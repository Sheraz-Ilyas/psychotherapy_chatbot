import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  NewPost({Key? key}) : super(key: key);

  final _keyForm = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
                onPressed: () {},
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
