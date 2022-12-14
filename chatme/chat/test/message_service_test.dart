import 'package:chat/src/encryption/encryption_service.dart';
import 'package:chat/src/models/message.dart';
import 'package:chat/src/models/user.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat/src/services/message/message_service_impl.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

import 'helpers.dart';

void main(){
  Rethinkdb r = Rethinkdb();
  Connection? connection;
  MessageService? sut;


setUp(() async{
    connection = await r.connect(host: "127.0.0.1", port: 28015);
    await createDb(r,connection!);
    final encryption =   EncryptionService(Encrypter(AES(Key.fromLength(32)))); 
    sut = MessageService(r,connection!,encryption );
  });

   tearDown(() async{
     sut!.dispose();
  //  await cleanDb(r, connection!);
  });

final user = User.fromJson(
  {
    'id': '1234',
    'active': true,
    'lastseen': DateTime.now()
  }
);

final user2 = User.fromJson(
  {
    'id': '1111',
    'active': true,
    'lastseen': DateTime.now()
  }
);


/*
test('sent message successfully', () async {
    Message message = Message(
      from: user.id,
      to: '3456',
      timestamp: DateTime.now(),
      contents: 'message from anuceo'
       );
      
       final res = await sut?.send(message);
      
       expect(res, true);
  }); */

/*
  test('sent message successfully', () async {
    Message message = Message(
      from: user.id,
      to: '3456',
      timestamp: DateTime.now(),
      contents: 'this is a message'
       );
      
       final res = await sut?.send(message);
      
       expect(res, true);
  });  */
 






}

