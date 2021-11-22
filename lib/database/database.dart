// database.dart
@JsonSerializable()
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tickertape/database/all_stocks_entity.dart';
import 'package:tickertape/database/dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Stocks])
abstract class AppDatabase extends FloorDatabase {
  StocksDao get stockdao;
}
