import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
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
  // get client
  http.Client get client => http.Client();

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
  }

  @override
  void dispose() {
    super.dispose();
    client.close();
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
      var result = jsonResponse["response"];
      if (result.isEmpty) {
        return "Sorry I couldn't understand your question";
      }
      return result.toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: Get.find<AuthController>().firebaseUser!.uid,
      text: message.text,
    );

    _addMessage(textMessage, message.text);

    String? response = await getResponse(message.text);

    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: response ?? "No response",
    );

    _addMessage(botMessage, response ?? "No response");
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
    List<dynamic> messagesObject =
        // await databaseMethods.getConversationMessages(Get.find<AuthController>()
        //         .localUser
        //         .value
        //         .name!
        //         .replaceAll(' ', '-')
        //         .toLowerCase() +
        //     '_bot');
        await databaseMethods.getConversationMessages(
            userName!.replaceAll(' ', '-').toLowerCase() + '_chatbot');
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

    return Scaffold(
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    child: CircleAvatar(
                      child: Image.asset("assets/images/robot.png"),
                    ),
                  ),
                  Text(
                    "Thinking...",
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
