import 'dart:async';
import 'package:chat/src/models/user.dart';
import 'package:chat/src/models/receipt.dart';
import 'package:chat/src/services/receipt/receipt_service_contract.dart';
import 'package:rethinkdb_dart/rethinkdb_dart.dart';

class ReceiptServie implements IReceiptservice{



    
  final Connection _connection;
  final Rethinkdb r;

  final _controller = StreamController<Receipt>.broadcast();
  StreamSubscription? _changefeed;

  ReceiptServie(this.r,this._connection);
 


  @override
  dispose() {
    _changefeed?.cancel();
    _controller.close();
  }

  @override
  Stream<Receipt> receipts( User? activeUser) {
   _startRecievingRecipts(activeUser);
   return _controller.stream;
  }

  @override
  Future<bool> send(Receipt receipt) async{
       
       var data =  receipt.toJson();
       

      Map record = await r.table('receipts')
      .insert(data).run(_connection);
    
    return record['inserted'] == 1;
   
  }

  void _startRecievingRecipts(User? activeUser) {

  _changefeed = r
  .table('receipts')
  .filter({'recipient': activeUser!.id})
  .changes({'include_initial':true})
  .run(_connection)
  .asStream()
  .cast<Feed>()
  .listen((event) {
    event.forEach((feedData) {
      
    if(feedData['new_val'] == null){
      return ;
    }
    
    final receipt = _receiptFromFeed(feedData);
    _controller.sink.add(receipt);

    }).catchError((err) => print(err))
    .onError((error, stackTrace) => print(error));
  });
  

  }

  Receipt _receiptFromFeed(feedData) {

    var data = feedData['new_val'];
    return Receipt.fromJson(data); 

  }

   


}