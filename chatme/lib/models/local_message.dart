

import 'package:chat/chat.dart';


class LocalMessage{

String? chatId;
String get id => _id;
late String _id;
Message message;
ReceiptStatus receipt;

LocalMessage(this.chatId,this.message,this.receipt);


Map<String,dynamic> toMap()=>
{ 'chat_id':chatId,
  'receipt': receipt,
   'message': message,
   'id':message.id,
   ...message.toJson()

};


factory LocalMessage.fromMap(Map<String, dynamic> json){

final message = Message(
  contents: json['contents'],
  from: json['from'],
  to: json['to'],
  timestamp: json['timestamp']);


  final LocalMessage localMesage = 

  LocalMessage(json['chat_id'], message, EnumParsing.fromString(json['receipt']));

  localMesage._id = json['id'];

 return localMesage;
}



}