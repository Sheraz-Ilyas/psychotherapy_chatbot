import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:psychotherapy_chatbot/constants/uri.dart';
import 'package:psychotherapy_chatbot/controllers/conntection_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ConnectionController _connectionController =
      Get.put(ConnectionController());
  List<types.Message> _messages = [];
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
  final _bot = const types.User(id: 'bot');

  // get client
  http.Client get client => http.Client();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    super.dispose();
    client.close();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  Future<String?> getResponse(String message) async {
    // check status code

    try {
      http.Response response = await client.post(
        Uri.parse(CHATBOT_URL),
        body: {"query": message},
      );
      return response.body;
      // Map<String, dynamic> jsonResponse = await jsonDecode(response.body);
      // var result = jsonResponse["response"];
      // if (result.isEmpty) {
      //   return "Sorry I couldn't understand your question";
      // }
      // return result.toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);

    String? response = await getResponse(message.text);
    print(response);
    final botMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: response ?? "No response",
    );
    _addMessage(botMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
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
                    _connectionController.isConnected.value
                        ? "Online"
                        : "Offline",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: _connectionController.isConnected.value
                            ? Colors.green
                            : Colors.grey,
                        fontSize: 14),
                  ),
                ],
              ),
              Expanded(
                child: Chat(
                  messages: _messages,
                  onPreviewDataFetched: _handlePreviewDataFetched,
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
            onPressed: () {},
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
