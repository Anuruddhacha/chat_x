

import 'dart:async';

import 'package:chat/src/encryption/encryption_contract.dart';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/models/message.dart';
import 'package:chat/src/services/message/message_service_contract.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

class MessageService implements IMessageService{
   
  final Connection _connection;
  final Rethinkdb r;
  final IEncryption _encryption;

  final _controller = StreamController<Message>.broadcast();
  StreamSubscription? _changefeed;

  MessageService(this.r,this._connection, this._encryption);
 


  @override
  dispose() {
    _changefeed?.cancel();
    _controller.close();
  }

  @override
  Stream<Message> messages({ User? activeUser}) {
   _startRecievingMesages(activeUser);
   return _controller.stream;
  }

  @override
  Future<bool> send(Message message) async{
       
       var data =  message.toJson();
       data['contents'] = _encryption.encrypt(message.contents!);



      Map record = await r.table('messages')
      .insert(data).run(_connection);
    
    return record['inserted'] == 1;
   
  }

  void _startRecievingMesages(User? activeUser) {

  _changefeed = r
  .table('messages')
  .filter({'to': activeUser!.id})
  .changes({'include_initial':true})
  .run(_connection)
  .asStream()
  .cast<Feed>()
  .listen((event) {
    event.forEach((feedData) {
      
    if(feedData['new_val'] == null){
      return ;
    }
    
    final message = _messageFromFeed(feedData);
    _controller.sink.add(message);
    _removeDeliverredMesage(message);

    }).catchError((err) => print(err))
    .onError((error, stackTrace) => print(error));
  });
  

  }

  Message _messageFromFeed(feedData) {

    var data = feedData['new_val'];
    data['contents'] = _encryption.decrypt(data['contents']);
    return Message.fromJson(data); 

  }

  void _removeDeliverredMesage(Message message) {
   r.table('messages').get(message.id)
   .delete({'return_changes':false})
   .run(_connection);
      
  }



}