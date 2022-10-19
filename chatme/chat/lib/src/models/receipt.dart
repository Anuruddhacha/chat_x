

enum ReceiptStatus{
  sent,
  deliverred,
  read
}

extension EnumParsing on ReceiptStatus{
  String value(){
    return this.toString().split('.').last;
  }

  static ReceiptStatus fromString(String status){
  return ReceiptStatus.values.firstWhere(
    (element) => element.value() == status);

  }
}

class Receipt {
  final String recipient;
  final String messageId;
  final ReceiptStatus status;
  final DateTime timestamp;
  late String _id;
  String get id => _id; 

  Receipt(
    this.recipient,
    this.messageId,
    this.status,
    this.timestamp
    );

    toJson() => {
      'recipient':this.recipient,
      'message_id':this.messageId,
      'status':status.value(),
      'timestamp':timestamp
    };

    factory Receipt.fromJson(Map<String,dynamic> json){
      var receipt = Receipt(
        json['recipient'],
         json['message_id'],
          EnumParsing.fromString(json['status']),
           json['timestamp']);

           receipt._id = json['id'];
      return receipt;     
    }
  
  
}