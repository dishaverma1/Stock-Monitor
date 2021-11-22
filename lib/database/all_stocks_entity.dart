// entity/allStock.dart

import 'package:floor/floor.dart';

@entity
class Stocks {
  @primaryKey
  final String sid;
  final double price;
  final double change;
  final bool isChangeUp;

  Stocks(this.sid, this.price, this.change, this.isChangeUp);
}
