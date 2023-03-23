import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'messages.dart';

part 'chat_completions_body.g.dart';

@JsonSerializable()
class ChatCompletionsBody {
    final String model;
    final List<Message> messages;


    const ChatCompletionsBody({
      required this.model,
      required this.messages
    });
  
    factory ChatCompletionsBody.fromJson(Map<String, dynamic> json) => _$ChatCompletionsBodyFromJson(json);

    Map<String, dynamic> toJson() => _$ChatCompletionsBodyToJson(this);
}


  