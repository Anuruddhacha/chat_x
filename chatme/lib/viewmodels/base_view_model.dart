
import 'package:chatme/data/datasource/localdatasource_contract.dart';
import 'package:chatme/models/chat.dart';
import 'package:chatme/models/local_message.dart';

abstract class BaseViewModel{
  IDataSource _iDataSource;

  BaseViewModel(this._iDataSource);


Future<void> addMessage(LocalMessage localMessage)async{

if(!await _isExistingChat(localMessage.chatId)) {
  await _createNewChat(localMessage.chatId);
}
await _iDataSource.addMessage(localMessage);


}

 Future<void> _createNewChat(String? chatId) async{


final chat = Chat(chatId!);
await _iDataSource.addChat(chat);


 }

  Future<bool> _isExistingChat(String? chatId) async{

 return await _iDataSource.findChat(chatId!) != null;

  } 




}