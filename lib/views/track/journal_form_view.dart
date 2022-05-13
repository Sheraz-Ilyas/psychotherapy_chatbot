import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/controllers/auth_controller.dart';
import 'package:psychotherapy_chatbot/controllers/journal_controller.dart';
import 'package:psychotherapy_chatbot/models/journal.dart';
import 'package:psychotherapy_chatbot/services/database.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class JournalFormView extends StatefulWidget {
  JournalFormView({Key? key, this.journal}) : super(key: key);
  Journal? journal;

  @override
  _JournalFormViewState createState() => _JournalFormViewState();
}

class _JournalFormViewState extends State<JournalFormView> {
  final _keyForm = GlobalKey<FormState>();
  JournalController journalController = Get.find<JournalController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();
  AuthController authController = Get.find<AuthController>();

  var parser = EmojiParser();
  List<Emoji> emojis = [
    Emoji('happy', '😀'),
    Emoji('sad', '😢'),
    Emoji('angry', '😡'),
    Emoji('surprised', '😮'),
    Emoji('scared', '😱'),
    Emoji('neutral', '😐'),
    Emoji('confused', '😕'),
    Emoji('crying', '😭'),
    Emoji('unknown', '😶')
  ];
  // ignore: prefer_typing_uninitialized_variables
  var _selectedColor;
  // ignore: prefer_typing_uninitialized_variables
  var _selectedMood;

  void _saveForm() {
    var uuid = const Uuid();
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      if (widget.journal == null) {
        Journal journal = Journal(
          id: uuid.v1().toString(),
          title: _titleController.text,
          description: _descriptionController.text,
          color: _selectedColor,
          mood: _selectedMood,
          date: DateTime.now(),
        );
        databaseMethods.uploadJournal(
            journal, authController.firebaseUser!.uid);
        Get.snackbar(
          '',
          '',
          titleText: Text(
            'Saved',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
          ),
          messageText: Text(
            'Journal Added Successfully',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        // journalController.doneForToday.value = true;
      } else {
        Journal journal = Journal(
          id: widget.journal!.id,
          title: _titleController.text,
          description: _descriptionController.text,
          color: _selectedColor,
          mood: _selectedMood,
          date: DateTime.now(),
        );
        databaseMethods.updateJournal(
            journal, authController.firebaseUser!.uid);
        Get.snackbar(
          '',
          '',
          titleText: Text(
            'Saved',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
          ),
          messageText: Text(
            'Journal Updated Successfully',
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
    if (widget.journal != null) {
      _titleController.text = widget.journal!.title!;
      _descriptionController.text = widget.journal!.description!;
      _selectedColor = widget.journal!.color;
      _selectedMood = widget.journal!.mood;
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
          widget.journal != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Journal',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 20)),
                              content: Text(
                                'Are you sure you want to delete this journal?',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  style: TextButton.styleFrom(
                                    primary: Colors.red,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onPressed: () async {
                                    await databaseMethods.deleteJournal(
                                      authController.firebaseUser!.uid,
                                      widget.journal!.id!,
                                    );
                                    journalController.journalData
                                        .removeWhere((element) {
                                      return element.id == widget.journal!.id;
                                    });
                                    // if (journalController.journalData.isEmpty) {
                                    //   journalController.doneForToday.value =
                                    //       false;
                                    // } else {
                                    //   DateTime? lastJournalDate =
                                    //       journalController
                                    //           .journalData.last.date;
                                    //   if (DateFormat('MMMM d, yyyy')
                                    //           .format(lastJournalDate!) ==
                                    //       DateFormat('MMMM d, yyyy')
                                    //           .format(DateTime.now())) {
                                    //     journalController.doneForToday.value =
                                    //         true;
                                    //   } else {
                                    //     journalController.doneForToday.value =
                                    //         false;
                                    //   }
                                    // }
                                    Get.back();
                                    navigationController.goBack();
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Text(
                      'Delete',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.red, fontSize: 14),
                    ),
                  ),
                )
              : Container(),
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
          child: Column(
            children: [
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
                        hintText: 'Journal',
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  children: [
                    for (int i = 0; i < emojis.length; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedMood = Mood.values[i];
                          });
                        },
                        child: MoodPill(
                            emoji: emojis[i],
                            mood: Mood.values[i].toString().split('.').last,
                            selected:
                                _selectedMood == Mood.values[i] ? true : false),
                      ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: journalColors.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedColor = journalColors[index];
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: _selectedColor == journalColors[index]
                                  ? Stack(children: [
                                      Center(
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: journalColors[index],
                                        ),
                                      ),
                                      Center(
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor:
                                              Colors.black.withOpacity(0.2),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Center(
                                          child: Icon(Icons.check,
                                              color: Colors.white, size: 30),
                                        ),
                                      ),
                                    ])
                                  : CircleAvatar(
                                      radius: 25,
                                      backgroundColor: journalColors[index],
                                    ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MoodPill extends StatelessWidget {
  MoodPill({Key? key, required this.emoji, required this.mood, this.selected})
      : super(key: key);

  final Emoji emoji;
  final String mood;
  bool? selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        color: selected ?? false ? blue : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(
            color: selected ?? false ? Colors.black54 : Colors.grey,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: IntrinsicWidth(
            child: Row(
              children: [
                Text(emoji.code),
                const SizedBox(width: 5),
                Text(mood,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color:
                              selected ?? false ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
