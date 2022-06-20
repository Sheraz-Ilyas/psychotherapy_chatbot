import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/constants/colors.dart';
import 'package:psychotherapy_chatbot/constants/controllers.dart';
import 'package:psychotherapy_chatbot/constants/uri.dart';
import 'package:psychotherapy_chatbot/controllers/auth_controller.dart';
import 'package:psychotherapy_chatbot/router/route_generator.dart';
import 'package:psychotherapy_chatbot/services/database.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final AuthController _authController = Get.put(AuthController());

  List<types.Message> _messages = [];

  // ignore: prefer_typing_uninitialized_variables
  late final _user;
  // ignore: prefer_typing_uninitialized_variables
  late final _bot;
  late String? userName;

  DatabaseMethods databaseMethods = DatabaseMethods();
  bool isLoading = true;
  bool isThinking = false;
  bool emergencyState = false;
  // get client
  http.Client get client => http.Client();

  List<dynamic>? _intents;

  int _currentIndex = 0;
  List<String> cbtQuestions = [
    "How are you feeling today?",
    "I assume you are feeling <TAG>. Tell me what made you feel like this?",
    "How is your sleep nowadays?",
    "What is your eating pattern?",
    "How is your relationship with your family?",
    "What is your greatest fear?",
    "Think of what will be different for you in the future when things are going better. Does it make you feel any better?",
    "Think of a time when you were not having the problem that is bothering you. How do you feel when you think about it?",
    "What are your expectations from the therapy sessions like these? How do you feel after each session?"
  ];

  List<Emoji> emojis = [
    Emoji('insomnia', '😴💤'),
    Emoji('know', '📚'),
    Emoji('journal', '📝'),
    Emoji('community', '👨‍👨‍👧‍👧'),
    Emoji('hello', '🙋🏻‍♂️'),
    Emoji('bye', '👋🏻'),
    Emoji('meditation', '🤗'),
    Emoji('emergency', '🛑')
  ];

  @override
  void initState() {
    super.initState();
    userName = _authController.localUser.value.name;

    createChat();
    _loadMessages();

    _user = types.User(
      id: _authController.firebaseUser!.uid,
      firstName: userName,
    );
    _bot = const types.User(id: 'chatbot', firstName: 'chatbot');
    _loadIntents();
  }

  @override
  void dispose() {
    super.dispose();
    client.close();
  }

  // loop through _intents
  String getQuestion(String tag) {
    for (var i = 0; i < _intents!.length; i++) {
      if (_intents![i]['tag'] == tag) {
        // returns a random response from the list of responses
        return _intents![i]['responses']
            [Random().nextInt(_intents![i]['responses'].length)];
      }
    }
    return "";
  }

  Future<void> _loadIntents() async {
    final String jsonString =
        await rootBundle.loadString('assets/intents.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _intents = jsonMap['intents'];
  }

  void _addMessage(types.Message message, String text) {
    setState(() {
      _messages.insert(0, message);
      Map<String, dynamic> messageMap = {
        "sentBy": message.author.firstName!,
        "createdAt": message.createdAt,
        "id": message.id,
        "text": text
      };
      databaseMethods.addConversationMessages(
          userName!.replaceAll(' ', '-').toLowerCase() + '_chatbot',
          messageMap);
    });
  }

  Future<String?> getResponse(String message) async {
    // check status code
    try {
      http.Response response = await client.post(
        Uri.parse(LOCAL_HOST),
        body: {"query": message},
      );
      Map<String, dynamic> jsonResponse = await jsonDecode(response.body);
      var result = jsonResponse["response"].toString();
      return result;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  void _handleSendPressed(types.PartialText message) async {
    setState(() {
      isThinking = true;
    });
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: Get.find<AuthController>().firebaseUser!.uid,
      text: message.text,
    );
    _addMessage(textMessage, message.text);

    if (emergencyState) {
      if (message.text.contains('yes') ||
          message.text.contains('kill') ||
          message.text.contains('die') ||
          message.text.contains('y')) {
        String emergencyText =
            "I'm sorry you're going through this, I strongly recommend that you reach out to a friendly, caring human who can support you and help you. Stay safe during this time.";
        final botEmergency = types.TextMessage(
          author: _bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: emergencyText,
        );
        _addMessage(botEmergency, emergencyText);
      }
      String emergencyText2 =
          "If you can't find another human to help you out at the moment, Please consider pressing the S.O.S ${emojis[7].code} button.";
      final botEmergency2 = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: emergencyText2,
      );
      _addMessage(botEmergency2, emergencyText2);
      emergencyState = false;
      return;
    }

    String? response = await getResponse(message.text).then((value) {
      setState(() {
        isThinking = false;
      });
      return value;
    });
    if (response == 'I don\'t understand') {
      String r = 'Hmmmm...!';
      final bot = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: r,
      );
      _addMessage(bot, r);

      String localQuestion = cbtQuestions[_currentIndex];
      final botNext = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: localQuestion,
      );
      _addMessage(botNext, localQuestion);
      _currentIndex++;
      return;
    }

    String question = getQuestion(response!);
    if (question.contains('<NAME>')) {
      question =
          question.replaceAll('<NAME>', _authController.localUser.value.name!);
    }
    if (question.contains('Do you know? ')) {
      question =
          question.replaceAll('Do you know?', 'Do you know? ${emojis[1].code}');
    }
    if (response == 'goodbye') {
      // put an emjoi at the last of the question string
      question = question + " " + emojis[5].code;
    }
    if (response == 'greeting') {
      // put an emjoi at the last of the question string
      question = question + " " + emojis[4].code;
    }
    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: question,
    );
    _addMessage(botMessage, question);
    if (question.contains('?')) {
      if (response == 'emergency') {
        emergencyState = true;
      }
      return;
    }
    String help = '';
    if (response == 'insomnia') {
      help =
          "If you can't sleep at night. You can head towrds the explore section and use the 'Sleep Sounds' ${emojis[0].code} feature to help you sleep better.";
    } else if (response == 'isolated' ||
        response == 'depressed' ||
        response == 'fear') {
      help =
          "If you are feeling lonely, depressed or afraid you can share your thoughts with other people in the 'Community' ${emojis[3].code} section. You can also read their experiences/recoveries to help you feel better.";
    } else if (response == 'confused' ||
        response == 'mind reading' ||
        response == 'emotional reasoning' ||
        response == 'catastrophizing') {
      help =
          "Why don't you write a journal entry? You can use the 'Journal' ${emojis[2].code} feature to write down your thoughts and feelings.";
    } else if (response == 'sad' ||
        response == 'frustrated' ||
        response == 'emergency') {
      help =
          "In my opinion, you should take a break from and relax your mind. You can perform a mindfulness exercise to help you feel better. Head to the explore section and use the 'Meditation' ${emojis[5].code} feature to help you relax you mind.";
    }
    if (!(help == '')) {
      setState(() {
        isThinking = false;
      });
      final botMessage2 = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: help,
      );
      _addMessage(botMessage2, help);
    }
    String localQuestion = cbtQuestions[_currentIndex];
    if (_currentIndex == 1) {
      // replace the tag with the response
      if (response == 'mind reading' ||
          response == 'emotional reasoning' ||
          response == 'catastrophizing' ||
          response == 'depressed' ||
          response == 'fear') {
        localQuestion = "Why are you feeling this way? Tell me about it.";
      } else {
        localQuestion = localQuestion.replaceAll("<TAG>", response);
      }
    }
    final botMessage3 = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: localQuestion,
    );
    _addMessage(botMessage3, localQuestion);
    _currentIndex++;
  }

  void createChat() {
    List<String> users = [userName!, 'chatbot'];
    String conversationId =
        userName!.replaceAll(' ', '-').toLowerCase() + '_chatbot';
    Map<String, dynamic> conversationMap = {
      "users": users,
      "conversationId": conversationId.toString()
    };
    databaseMethods.createChat(conversationId, conversationMap);
  }

  void _loadMessages() async {
    List<dynamic> messagesObject = await databaseMethods
        .getConversationMessages(
            userName!.replaceAll(' ', '-').toLowerCase() + '_chatbot')
        .then((value) {
      setState(() {
        isLoading = false;
      });
      return value;
    });
    List<types.TextMessage> messages = messagesObject.map((e) {
      return types.TextMessage(
        createdAt: e['createdAt'],
        id: e['id'],
        author: e['sentBy'] != 'chatbot' ? _user : _bot,
        text: e['text'],
      );
    }).toList();
    messages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    setState(() {
      _messages = messages.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(blue),
          ))
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              bottom: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        child: CircleAvatar(
                          child: Image.asset("assets/images/robot.png"),
                        ),
                      ),
                      Text(
                        isThinking ? "Thinking..." : 'Ask me Anything',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Chat(
                      messages: _messages,
                      onSendPressed: _handleSendPressed,
                      user: _user,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FloatingActionButton.extended(
                onPressed: () {
                  navigationController.navigateTo(sos);
                },
                label: Text(
                  "S.O.S",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                ),
                icon: const Icon(
                  Icons.local_hospital_outlined,
                  color: Colors.red,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop);
  }
}
