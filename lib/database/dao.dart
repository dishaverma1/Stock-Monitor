// dao/stock_dao.dart

import 'package:floor/floor.dart';
import 'package:tickertape/database/all_stocks_entity.dart';

@dao
abstract class StocksDao {
  @Query('SELECT * FROM Stocks')
  Future<List<Stocks>> fetchAllStock();

  @Query('SELECT * FROM Stocks WHERE id = :id')
  Stream<Stocks?> findPersonById(int id);

  @Query('SELECT price FROM Stocks WHERE sid = :sid')
  Future<List<double>?> getPriceBySid(String sid);

  @Query('SELECT time FROM Stocks WHERE sid = :sid')
  Future<List<int>?> getTimeBySid(String sid);

  @insert
  Future<void> insertStock(Stocks stock);
}
