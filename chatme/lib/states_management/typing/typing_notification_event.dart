part of 'typing_notification_bloc.dart';



abstract class TypingNotificationEvent extends Equatable{
  TypingNotificationEvent();
  factory TypingNotificationEvent.onSubscribed(User user, {required List<String> usersWithChat})=>
   Subscribed(user, usersWithChats: usersWithChat);

  factory TypingNotificationEvent.onTypingEventSent(TypingEvent typingEvent)
   => TypingNotificationSent(typingEvent);


  @override  
List<Object> get props => [];

}


class Subscribed extends TypingNotificationEvent{

final User user;
final List<String> usersWithChats;
 Subscribed(this.user,{required this.usersWithChats});

@override
  List<Object> get props => [user,usersWithChats];

}

class NotSubscribed extends TypingNotificationEvent{}

class TypingNotificationSent extends TypingNotificationEvent{
final TypingEvent typingEvent;


TypingNotificationSent(this.typingEvent);

@override
  List<Object> get props => [typingEvent];

}



class _TypingNotificationReceive extends TypingNotificationEvent{

 _TypingNotificationReceive(this.typingEvent);
final TypingEvent typingEvent;

@override
  List<Object> get props => [typingEvent];

}
