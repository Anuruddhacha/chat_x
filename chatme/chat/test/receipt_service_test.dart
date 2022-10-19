import 'package:chat/src/encryption/encryption_service.dart';
import 'package:chat/src/models/receipt.dart';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/receipt/receipt_service_impl.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

import 'helpers.dart';



void main(){
  Rethinkdb r = Rethinkdb();
  Connection? connection;
  ReceiptServie? sut;


setUp(() async{
    connection = await r.connect(host: "127.0.0.1", port: 28015);
    await createDb(r,connection!);

    sut = ReceiptServie(r, connection!);
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
/*
  test('sent receipt successfully', () async {
//when we get a message we reply a receipt

Receipt receipt = Receipt(
  '4444',
 '1234',
  ReceiptStatus.deliverred,
  DateTime.now());


final res = await sut!.send(receipt);
expect(res, true);
  });



  test('subscribe and receive successfully', () async {

sut!.receipts(user).listen(expectAsync1((receipt){ 
expect(receipt.recipient, user.id);
},count: 2));

Receipt receipt = Receipt(
  user.id!,
 '1234',
  ReceiptStatus.deliverred,
  DateTime.now());

  Receipt anotherReceipt = Receipt(
  user.id!,
 '1234',
  ReceiptStatus.read,
  DateTime.now());


 await sut!.send(receipt);
 await sut!.send(anotherReceipt);
 
  }); */

  
  
  }


