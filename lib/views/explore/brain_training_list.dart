import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/controllers/brain_training_temp.dart';
import 'package:psychotherapy_chatbot/models/brain_training.dart';

class BrainTrainingList extends StatelessWidget {
  BrainTrainingList({Key? key}) : super(key: key);

  List<MaterialColor> cardColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.lime,
    Colors.cyan,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Excercises",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.1,
            image: AssetImage("assets/images/brain_cards/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
            itemCount: brainTrainingData!.length,
            itemBuilder: (context, index) {
              return BrainCard(
                brainExcercise: brainTrainingData![index],
              );
            }),
      ),
    );
  }
}

class BrainCard extends StatelessWidget {
  BrainCard({Key? key, this.brainExcercise}) : super(key: key);

  BrainTraining? brainExcercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(brainExcercise!.category),
                    ),
                  ),
                  Container(
                    child: Text(
                      brainExcercise!.title!,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 22),
                    ),
                  ),
                  Container(
                    child: Text(
                      brainExcercise!.description!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 13),
                    ),
                  )
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.topRight,
              child: Image.asset(
                brainExcercise!.image!,
                width: 125,
                height: 125,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
