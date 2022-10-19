import 'package:chat/src/encryption/encryption_service.dart';
import 'package:chat/src/models/receipt.dart';
import 'package:chat/src/models/typing_event.dart';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/receipt/receipt_service_impl.dart';
import 'package:chat/src/services/typing/typing_notification.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

import 'helpers.dart';



void main(){
  Rethinkdb r = Rethinkdb();
  Connection? connection;
  TypingNotification? sut;


setUp(() async{
    connection = await r.connect(host: "127.0.0.1", port: 28015);
    await createDb(r,connection!);

    sut = TypingNotification(connection!,r);
  });

   tearDown(() async{
     sut!.dispose();
     await cleanDb(r, connection!);
  });

  final user  = User.fromJson({
    'id':'1234',
    'active':true,
    'lastSeen':DateTime.now(),
  });

  final user2  = User.fromJson({
    'id':'1111',
    'active':true,
    'lastSeen':DateTime.now(),
  });

   test('sent typing noti successfully', () async {

   TypingEvent typingEvent = 

   TypingEvent(from: user2.id!, to: user.id!, event: Typing.start);

   final res = await sut!.send(typingEvent);
   expect(res, true);


  });
  
  
  }