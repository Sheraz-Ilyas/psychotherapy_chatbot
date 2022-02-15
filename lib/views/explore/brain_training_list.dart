import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/controllers/brain_training_temp.dart';
import 'package:psychotherapy_chatbot/models/brain_training.dart';

class BrainTrainingList extends StatelessWidget {
  BrainTrainingList({Key? key}) : super(key: key);

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

  void showSteps(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 25, bottom: 10),
                  child: Text(brainExcercise!.title!,
                      style: Theme.of(context).textTheme.headline1),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: brainExcercise!.steps!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundColor: blue,
                            child: Text(
                              "${index + 1}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white),
                            )),
                        title: Container(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            brainExcercise!.steps![index],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: InkWell(
        onTap: () {
          showSteps(context);
        },
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
      ),
    );
  }
}
