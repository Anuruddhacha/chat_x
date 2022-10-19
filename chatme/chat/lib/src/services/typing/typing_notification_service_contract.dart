

import 'package:chat/src/models/typing_event.dart';
import 'package:flutter/cupertino.dart';

import '../../models/user.dart';

abstract class ITypingNotification{
  Future<bool> send(TypingEvent event,{User to});
  Stream<TypingEvent> subscribe(User user, List<String> userIds);
  void dispose();

}