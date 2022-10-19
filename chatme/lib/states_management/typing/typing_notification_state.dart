part of 'typing_notification_bloc.dart';




abstract class TypingNotificationState extends Equatable{

const TypingNotificationState();
factory TypingNotificationState.initial() => TypingNotificationInitial();
factory TypingNotificationState.sent() => TypingNotificationSentSuccess();
factory TypingNotificationState.received(TypingEvent typingEvent)
=>TypingNotificationReceivedSuccesss(typingEvent);



@override  
List<Object> get props => [];
}


class TypingNotificationInitial extends TypingNotificationState{}

class TypingNotificationSentSuccess extends TypingNotificationState{}

class TypingNotificationReceivedSuccesss extends TypingNotificationState{


final TypingEvent typingEvent;

const TypingNotificationReceivedSuccesss(this.typingEvent);

@override
  List<Object> get props => [typingEvent];

}