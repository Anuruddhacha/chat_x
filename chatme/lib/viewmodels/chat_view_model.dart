

import 'package:chatme/data/datasource/localdatasource_contract.dart';
import 'package:chatme/models/local_message.dart';
import 'package:chatme/viewmodels/base_view_model.dart';
import 'package:chat/chat.dart';

class ChatViewModel extends BaseViewModel{

  IDataSource? _dataSource;
  String _chatId  ="";
  int otherMessages = 0;


  ChatViewModel(IDataSource iDataSource) : super(iDataSource);

  Future<List<LocalMessage>> getMessages(String chatId) async{
   final messages = await _dataSource?.findMessages(chatId);

  if(messages!.isNotEmpty) _chatId = chatId;
   
   return messages;
  }

 Future<void> sentMessage(Message message) async{

  LocalMessage localMessage = LocalMessage(message.to, message, ReceiptStatus.sent);
  
  if(_chatId.isNotEmpty) return await _dataSource?.addMessage(localMessage);

_chatId = localMessage.chatId!;

await addMessage(localMessage);
 }


Future<void> receivedMessage(Message message) async{
  LocalMessage localMessage =
   LocalMessage(message.from,
    message, ReceiptStatus.deliverred);

  if(localMessage.chatId != _chatId) otherMessages++;
 
 await addMessage(localMessage);

}







}