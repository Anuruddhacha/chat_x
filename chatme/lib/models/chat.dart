


import 'package:chatme/models/local_message.dart';

class Chat{
String id;
int unread = 0;
List<LocalMessage>? messages = [];
LocalMessage? mostRecent;//appear in home screen

Chat(this.id,{ this.messages, this.mostRecent});


toMap() =>{'id': id};

factory Chat.fromMap(Map<String,dynamic> json) =>
Chat(json['id']);



}