part of 'message_bloc.dart';




abstract class MessageState extends Equatable{

const MessageState();
factory MessageState.initial() => MessageInitial();
factory MessageState.sent(Message message) => MessageSentSuccessState(message);
factory MessageState.received(Message message)=>MessageReceivedSuccessState(message);



@override  
List<Object> get props => [];
}


class MessageInitial extends MessageState{}

class MessageSentSuccessState extends MessageState{


final Message message;

const MessageSentSuccessState(this.message);

@override
  List<Object> get props => [message];

}

class MessageReceivedSuccessState extends MessageState{


final Message message;

const MessageReceivedSuccessState(this.message);

@override
  List<Object> get props => [message];

}