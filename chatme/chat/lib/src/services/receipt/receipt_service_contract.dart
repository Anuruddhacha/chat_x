

import '../../models/receipt.dart';
import '../../models/user.dart';

abstract class IReceiptservice{


Future<bool> send(Receipt receipt);
Stream<Receipt> receipts(User user);
void dispose();



}