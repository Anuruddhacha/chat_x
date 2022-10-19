

import 'package:chatme/data/datasource/localdatasource_contract.dart';
import 'package:chatme/models/local_message.dart';
import 'package:chatme/models/chat.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteDataSource implements IDataSource{

final Database _db;

  SqfLiteDataSource(this._db);



  @override
  Future<void> addChat(Chat chat) async{
      await _db.insert('chats', chat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> addMessage(LocalMessage message) async{
  await _db.insert('messags', message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteChat(String chatId) async{
    final batch = _db.batch();
    batch.delete('messages', where: 'chat_id = ?',
    whereArgs: [chatId]);
    batch.delete('chats', where: 'chat_id = ?',
    whereArgs: [chatId]);
    await batch.commit();

  }

  @override
  Future<List<Chat>> findAllChats() {
   return _db.transaction((txn)  async{

    final chatsWithLatestMessage = await
    txn.rawQuery(
      '''
     SELECT messages.* FROM 
     (
      SELECT chat_id, MAX(created_at) as created_at
      FROM messages
      GROUP BY chat_id
     ) AS latest_messages
     INNER JOIN messages
     ON messages.chat_id = latest_messages.chat_id
     AND messages.created_at = latest_messages.created_at
      '''
    );
    
  if(chatsWithLatestMessage.isEmpty) return [];

    final chatsWithUnreadMessages =
          await txn.rawQuery('''SELECT chat_id, count(*) as unread 
      FROM messages
      WHERE receipt = ?
      GROUP BY chat_id
      ''', ['deliverred']);

  return chatsWithLatestMessage.map((row) {

  var objUnred =   chatsWithUnreadMessages
  .firstWhere((element) => row['chat_id'] == element['chat_id'],
  orElse: () => {'unread': 0})['unread'];


  final int? unread = int.tryParse(objUnred.toString());

  final chat  = Chat.fromMap(row);
  chat.unread = unread!;
  chat.mostRecent = LocalMessage.fromMap(row);

  return chat;

   }).toList();

   });
  }



  @override
  Future<Chat> findChat(String chatId) async{
    return await _db.transaction((txn) async{


   final listOfChatMaps = await txn.query(
    'chats',
    where: 'id = ?',
    whereArgs: [chatId]
   );

   if(listOfChatMaps.isEmpty) return null!;

 final unread = Sqflite.firstIntValue(
  await txn.rawQuery('SELECT COUNT(*) FROM messages WHERE chat_id=? AND receipt = ?',
  [chatId,'deliverred'])
 );

 final mostRecentMessage = await txn.query('messages',
 where: 'chat_id = ?',
 whereArgs: [chatId],
 orderBy: 'created_at DESC',
 limit: 1);
final chat = Chat.fromMap(listOfChatMaps.first);
chat.unread = unread!;

chat.mostRecent = LocalMessage.fromMap(mostRecentMessage.first);

return chat;

    });
  }

  @override
  Future<List<LocalMessage>> findMessages(String chatId) async{
   final listOfMaps = await _db.query('messages',
   where: 'chat_id = ?',
   whereArgs: [chatId]);

   return listOfMaps.map<LocalMessage>((map) => 
   LocalMessage.fromMap(map)
   ).toList();

  }

  @override
  Future<void> updateMessage(LocalMessage message) async{
    
await _db.update('messages', message.toMap(),
  where: 'id = ?',
  whereArgs: [message.message.id],
  conflictAlgorithm: ConflictAlgorithm.replace);

  }



}