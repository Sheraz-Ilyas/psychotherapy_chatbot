import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/controllers/journal_temp.dart';
import 'package:psychotherapy_chatbot/models/journal.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';

class TrackView extends StatelessWidget {
  TrackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Your Journal",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ListView.builder(
            itemCount: journalData.length,
            itemBuilder: (context, index) {
              return JournalCard(
                journal: journalData[index],
              );
            }),
      ),
    );
  }
}

class JournalCard extends StatelessWidget {
  JournalCard({
    Key? key,
    @required this.journal,
  }) : super(key: key);

  Journal? journal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationController.navigateTo(addJournal);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Card(
          color: journal!.color.withOpacity(0.9),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        journal!.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 22, color: Colors.white),
                      ),
                    ),
                    Container(
                      child: Text(
                        journal!.date.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 13, color: Colors.white),
                      ),
                    )
                  ],
                ),
                FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.topRight,
                    child: Image.asset('assets/images/moods/smile.png',
                        width: 50, height: 50, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
