import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/models/article.dart';

class BrainTrainingList extends StatelessWidget {
  BrainTrainingList({Key? key}) : super(key: key);

  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
          title: Text(
            "Brain Traing Excercises",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.black),
          ),
        ),
        body: Container());
  }
}
