// dao/stock_dao.dart

import 'package:floor/floor.dart';
import 'package:tickertape/database/all_stocks_entity.dart';

@dao
abstract class StocksDao {
  @Query('SELECT * FROM Stocks')
  Future<List<Stocks>> fetchAllStock();

  @Query('SELECT * FROM Stocks WHERE sid = :sid')
  Stream<Stocks> findStocksById(int sid);

  @insert
  Future<void> insertStock(Stocks stock);
}
