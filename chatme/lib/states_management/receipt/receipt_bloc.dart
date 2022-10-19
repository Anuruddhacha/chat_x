import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat/chat.dart';
import 'package:equatable/equatable.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState>{

final IReceiptservice? _receitpService;
StreamSubscription? _subscription;

  ReceiptBloc(this._receitpService):super(ReceiptState.initial());
 
  @override
  Stream<ReceiptState> mapEventToState(ReceiptEvent event) async*{

  if(event is Subscribed){
    await _subscription!.cancel();

    _subscription = _receitpService!

    .receipts(event.user)
    .listen((receipt) => add(_ReceiptReceive(receipt)));
  }
  if(event is _ReceiptReceive){
    yield ReceiptState.received(event.receipt);
  }

  if(event is ReceiptSent){
    await _receitpService!.send(event.receipt);
    yield ReceiptState.sent(event.receipt);
  }


  }


@override
Future<void> close(){
  _subscription?.cancel();
  _receitpService?.dispose();
return super.close();

}



}

