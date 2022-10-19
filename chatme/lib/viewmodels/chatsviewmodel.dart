
import 'package:chat/chat.dart';
import 'package:chatme/data/datasource/localdatasource_contract.dart';
import 'package:chatme/models/local_message.dart';
import 'package:chatme/viewmodels/base_view_model.dart';

import '../models/chat.dart';

class ChatsViewModel extends BaseViewModel{

  IDataSource? _dataSource;

  ChatsViewModel(IDataSource iDataSource) : super(iDataSource);


Future<List<Chat>> getChats() async => 
await _dataSource!.findAllChats();



//WHEN get a message from server
  Future<void> receivedMessage(Message message) async{
  

 LocalMessage localMessage = LocalMessage(message.from, message, ReceiptStatus.deliverred);
  await addMessage(localMessage);

  }


}