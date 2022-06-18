import 'package:flutter/material.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/controllers/auth_controller.dart';
import 'package:psychotherapy_chatbot/controllers/journal_controller.dart';
import 'package:psychotherapy_chatbot/models/journal.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:psychotherapy_chatbot/services/database.dart';
import 'package:fl_chart/fl_chart.dart';

class TrackView extends StatefulWidget {
  const TrackView({Key? key}) : super(key: key);

  @override
  State<TrackView> createState() => _TrackViewState();
}

class _TrackViewState extends State<TrackView> {
  JournalController journalController = Get.put(JournalController());
  DatabaseMethods databaseMethods = DatabaseMethods();
  AuthController authController = Get.put(AuthController());

  bool isLoading = true;

  @override
  void initState() {
    databaseMethods.createJournal(authController.firebaseUser!.uid);
    _loadJournalData();
    // if (journalController.journalData.isEmpty) {
    //   setState(() {
    //     journalController.doneForToday.value = false;
    //   });
    // } else {
    //   DateTime? lastJournalDate = journalController.journalData.last.date;
    //   if (DateFormat('MMMM d, yyyy').format(lastJournalDate!) ==
    //       DateFormat('MMMM d, yyyy').format(DateTime.now())) {
    //     setState(() {
    //       journalController.doneForToday.value = true;
    //     });
    //   } else {
    //     setState(() {
    //       journalController.doneForToday.value = false;
    //     });
    //   }
    // }
    super.initState();
  }

  BarChart(
    BarChartData(
        // read about it in the BarChartData section
        ),
  ) {
    // TODO: implement BarChart
    throw UnimplementedError();
  }

  void _loadJournalData() async {
    await databaseMethods
        .getJournalList(authController.firebaseUser!.uid)
        .then((value) {
      setState(() {
        journalController.journalData = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(blue),
          ))
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Your Journal",
                style: Theme.of(context).textTheme.headline1,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child:
                      // Obx(
                      //   () =>
                      // journalController.doneForToday.value
                      //     ? InkWell(
                      //         onTap: () {
                      //           Get.snackbar(
                      //             '',
                      //             '',
                      //             messageText: Text(
                      //               'You have already done your journal for today!',
                      //               style: Theme.of(context).textTheme.bodyText1,
                      //             ),
                      //             snackPosition: SnackPosition.TOP,
                      //             backgroundColor: Colors.white,
                      //             duration: const Duration(seconds: 2),
                      //           );
                      //         },
                      //         child: const Icon(Icons.check_outlined, size: 30))
                      //     :
                      IconButton(
                    icon: const Icon(Icons.add, size: 30),
                    onPressed: () {
                      navigationController.navigateWithArg(
                          addJournal, {'editJournal': null}).then((value) {
                        setState(() {
                          isLoading = true;
                          Future.delayed(const Duration(seconds: 2))
                              .then((value) {
                            _loadJournalData();
                          });
                        });
                      });
                    },
                  ),
                  // ),
                ),
              ],
            ),
            body: journalController.journalData.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/empty_journal.jpg',
                          width: 200,
                          height: 200,
                        ),
                        Text(
                          "Start Writing Your Journal",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ListView.builder(
                        itemCount: journalController.journalData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              navigationController.navigateWithArg(addJournal, {
                                "editJournal":
                                    journalController.journalData[index]
                              }).then((value) {
                                setState(() {
                                  isLoading = true;
                                  Future.delayed(const Duration(seconds: 2))
                                      .then((value) {
                                    _loadJournalData();
                                  });
                                });
                              });
                            },
                            child: JournalCard(
                              journal: journalController.journalData[index],
                            ),
                          );
                        }),
                  ),
          );
  }
}

// ignore: must_be_immutable
class JournalCard extends StatefulWidget {
  JournalCard({
    Key? key,
    @required this.journal,
  }) : super(key: key);

  Journal? journal;

  @override
  State<JournalCard> createState() => _JournalCardState();
}

class _JournalCardState extends State<JournalCard> {
  Map<Mood, String> moodImages = {
    Mood.HAPPY: 'assets/images/moods/happy.png',
    Mood.SAD: 'assets/images/moods/sad.png',
    Mood.ANGRY: 'assets/images/moods/angry.png',
    Mood.SURPRISED: 'assets/images/moods/surprise.png',
    Mood.SCARED: 'assets/images/moods/scared.png',
    Mood.NEUTRAL: 'assets/images/moods/neutral.png',
    Mood.CONFUSED: 'assets/images/moods/confused.png',
    Mood.CRYING: 'assets/images/moods/crying.png',
    Mood.UNKNOWN: 'assets/images/moods/unknown.png',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        color: widget.journal!.color?.withOpacity(0.9) ?? blue,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.journal!.title == ''
                        ? "Today's Journal"
                        : widget.journal!.title!,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 22, color: Colors.white),
                  ),
                  Text(
                    DateFormat('MMMM d, yyyy').format(widget.journal!.date!),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 13, color: Colors.white),
                  )
                ],
              ),
              FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.topRight,
                  child: Image.asset(
                      moodImages[widget.journal!.mood] ??
                          'assets/images/moods/unknown.png',
                      width: 50,
                      height: 50,
                      color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
