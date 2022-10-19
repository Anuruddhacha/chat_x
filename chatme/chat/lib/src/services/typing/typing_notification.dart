

import 'dart:async';

import 'package:chat/src/models/user.dart';
import 'package:chat/src/models/typing_event.dart';
import 'package:chat/src/services/typing/typing_notification_service_contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

class TypingNotification implements ITypingNotification{


final Connection _connection;
final Rethinkdb _r;

final _controller = StreamController<TypingEvent>.broadcast();
StreamSubscription? _changeFeeed;



  TypingNotification(this._connection, this._r);


  @override
  Future<bool> send(TypingEvent event,{User? to}) async{
    

  if(!to!.active!) return false;

  Map record = await _r
  .table('typing_events')
  .insert(event.toJson(),{'conflict':'update'})
  .run(_connection);
  return record['inserted'] == 1;
  }  

  @override
  Stream<TypingEvent> subscribe(User user, List<String> userIds) {
    _startReceivingTypingEvents(user,userIds);

    return _controller.stream;


  }

  @override
  void dispose() {
    _changeFeeed?.cancel();
    _controller.close();
  }

  void _startReceivingTypingEvents(User user, List<String> userIds) {

  _changeFeeed = _r
   .table('typing_evevts')
   .filter((event){

    return event('to').eq(user.id).
    and(_r.expr(userIds).contains(event('from')));

   }).changes(
     {'include_initil':true}
   ).run(
     _connection
   )
   .asStream()
   .cast<Feed>()
   .listen((event) {

    event.forEach((feedData) {
        if (feedData['new_val'] == null) return ;
        final typing = _eventFromFeed(feedData);
        _controller.sink.add(typing);
        _removeEvent(typing);
     }).catchError((err) => print(err))
     .onError((error, stackTrace) => print(error));

    });
   

  }

  _eventFromFeed(feedData) {
    return TypingEvent.fromJson(feedData['new_val']);
  }

  void _removeEvent(TypingEvent event) {
    _r.table('typing_events')
    .get(event.id)
    .delete({'return_changes':false})
    .run(_connection);
  }

  



}