import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tickertape/models/stock_item_model.dart';
import 'package:tickertape/network/stock_nao.dart';
import 'package:tickertape/utils/string_constants.dart';

/// Home ViewModel -> ViewModel class for Home Screen
class HomeViewModel extends ChangeNotifier {
  // stock list private variable
  List<StockModel> _stockList = [];

  // stock list getter method
  List<StockModel> get getStockList => _stockList;

  // stock list setter method
  void setStockList(List<StockModel> val) {
    _stockList = val;
    notifyListeners();
  }

  /// method to fetch stocks from API
  Future<void> fetchStockList(List<String> stocks) async {
    debugPrint("calling fetch stock list");
    List<StockModel> stocksList = await StockNAO.getStocks(stocks: stocks);
    setStockList(stocksList);
  }

  // timer for polling API every 5 sec
  bool _timer = false;
  bool get isTimerOn => _timer;
  void setTimer(bool val) {
    _timer = val;
    if (val)
      fetchStockEveryFiveSec();
    else
      timer.cancel();
    notifyListeners();
  }

  Timer timer;

  void fetchStockEveryFiveSec() {
    timer = Timer.periodic(
        Duration(seconds: 5), (Timer t) => fetchStockList(FETCH_STOCKS));
  }

  // Future<List<StockModel>> fetchStocksBySid(String sid) async {
  //   final database =
  //       await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //
  //   return await database.stockdao.findStocksById(sid);
  // }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
