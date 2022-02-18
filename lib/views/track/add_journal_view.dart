import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/models/journal.dart';

class AddJournalView extends StatefulWidget {
  const AddJournalView({Key? key}) : super(key: key);

  @override
  _AddJournalViewState createState() => _AddJournalViewState();
}

class _AddJournalViewState extends State<AddJournalView> {
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
  var _selectedColor;
  var _selectedMood;
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
          child: Column(
            children: [
              TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                maxLines: 10,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Journal',
                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                  border: InputBorder.none,
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
