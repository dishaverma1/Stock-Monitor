// entity/allStock.dart

import 'package:floor/floor.dart';

@entity
class Stocks {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String? sid;
  final double? price;
  final double? change;
  final bool? isChangeUp;
  final int? time;

  Stocks(
      {this.id, this.sid, this.price, this.change, this.isChangeUp, this.time});
}
