import 'package:flutter/material.dart';
import 'package:pi/chat_message.dart';
import 'package:http/http.dart' as http;
import 'package:pi/model/chat_completions_body.dart';

import 'model/messages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, how can I help you today?", messageType: "bot")
  ];

  void _sendMessage(String text) {
    messages.add(ChatMessage(messageContent: text, messageType: "user"));
    _textEditingController.clear();
    _sentPostRequest("api.openai.com", "/v1/chat/completions", text);
    setState(() {});
  }

  void _sentPostRequest(String host, String path, String msg) async {
    Uri url = Uri.https(host,  path);
    Map<String, String> headers = {"Content-type": "application/json",
    "Authorization": "Bearer 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"};
    http.post(url, headers: headers, body: ChatCompletionsBody(
      model: "gpt-3.5-turbo",
      messages: Messages(
        role: "user",
        content: msg)
    ).toJson()).then((http.Response response) {
        print(response.body);
    });
  }

  final TextEditingController _textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Bot"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                    alignment: messages[index].messageType == 'bot'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: messages[index].messageType == 'bot'
                            ? Colors.grey[400]
                            : Colors.blue[200],
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        messages[index].messageContent,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                FloatingActionButton(
                  onPressed: () {
                    _sendMessage(_textEditingController.text);
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

