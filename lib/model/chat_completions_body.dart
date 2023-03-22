import 'messages.dart';

class ChatCompletionsBody {
    final String model;
    final Messages messages;


    const ChatCompletionsBody({
      required this.model,
      required this.messages
    });
  
    factory ChatCompletionsBody.fromJson(Map<String, dynamic> json) {
      return ChatCompletionsBody (
        model: json['model'] as String,
        messages: json['messages'] as Messages
      );
    }

    Map<String, dynamic> toJson() => {
        'model': model,
        'messages': messages.toJson() ,
      };
}


  