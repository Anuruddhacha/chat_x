

import 'package:flutter/cupertino.dart';

enum Typing{start,stop}

extension TypingParser on Typing{
  String value() {
    return this.toString().split('.').last;

  }
  static Typing fromString(String event){
    return Typing.values.firstWhere(
      (element) => element.value() == event);


  }
}


class TypingEvent{
  String get id => _id;
  final String from;
  final String to;
  final Typing event;
 late String _id;

  TypingEvent({
   required this.from,
    required this.to,
     required this.event});


     
    toJson() => {
      'from':this.from,
      'to':this.to,
      'event':event.value(),
    };

    factory TypingEvent.fromJson(Map<String,dynamic> json){
      var event = TypingEvent(
        from: json['from'],
         to: json['to'],
          event: TypingParser.fromString(json['event']));


          event._id = json['id'];
      return event;     
    }

  
}