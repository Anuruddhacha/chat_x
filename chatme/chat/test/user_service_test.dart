import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/user/user_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

import 'helpers.dart';

void main(){
   
  Rethinkdb r = Rethinkdb(); 
  Connection? connection;
  UserService? sut;

  setUp(() async{
    connection = await r.connect(host: "127.0.0.1", port: 28015);
    await createDb(r,connection!);
    sut = UserService(r,connection!);
  });

  tearDown(() async{
    await cleanDb(r, connection!);
  });

 /* test('creates a new user doc in database', () async {
    final user = User(
      username: 'test',
      photoUrl: 'photoUrl',
      active: true,
      lastseen: DateTime.now()
       );
      
       final userWithId = await sut?.connect(user);
       expect(userWithId!.id, isNotEmpty);
  });  */

  /* test('get online users', () async {
    final user = User(
      username: 'test',
      photoUrl: 'photoUrl',
      active: true,
      lastseen: DateTime.now()
       );
      
        await sut?.connect(user);
       final users = await sut?.online();
       expect(users?.length, 1);
  }); */


}  