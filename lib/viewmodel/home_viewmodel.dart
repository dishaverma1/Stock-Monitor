import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tickertape/database/database.dart';
import 'package:tickertape/models/chart_model.dart';
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

  // to store which stock is most expensive
  late StockModel expensiveStock;

  // getter for most expensive stock
  StockModel get getExpensiveStock => expensiveStock;

  // setter for most expensive stock
  void setExpensiveStock(StockModel val) {
    expensiveStock = val;
    notifyListeners();
  }

  /// method to fetch stocks from API
  Future<void> fetchStockList(List<String> stocks) async {
    debugPrint("calling fetch stock list");
    List<StockModel> stocksList = await StockNAO.getStocks(stocks: stocks);
    // setting default value for expensive stock
    setExpensiveStock(stocksList[0]);

    // setting fetched stock list
    setStockList(stocksList);

    // setting calculated most expensive stock
    setExpensiveStock(getMostExpensiveStock(stocksList));
    debugPrint("Expensive stock - ${expensiveStock.stockName}");

    // timer!.cancel();
  }

  int count = -1;
  int get getCount => count;

  void increaseCount() {
    count = count + 1;
    if (!_timer) fetchStockEveryFiveSec();
    notifyListeners();
  }

  void resetCount() {
    count = 0;
    notifyListeners();
  }

  // timer ON/OFF check bool for polling API every 5 sec
  bool _timer = false;
  bool get isTimerOn => _timer;
  void setTimer(bool val) {
    _timer = val;
    if (val)
      fetchStockEveryFiveSec();
    else
      timer!.cancel();
    notifyListeners();
  }

  // timer for polling API
  Timer? timer;
  void fetchStockEveryFiveSec() {
    debugPrint("count --- $count");
    if (count == 0) {
      fetchStockList(FETCH_STOCKS);
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
        if (count > 0) {
          fetchStockList(FETCH_STOCKS);
          count--;
          _timer = true;
        } else {
          _timer = false;
          timer!.cancel();
        }
      });
    }
  }

  /// fetchStocksByPrice-> function to fetch particular stocks stock
  Future<List<ChartDataModel>> fetchStocksByPrice(String sid) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    List<double>? price = await database.stockdao.getPriceBySid(sid);
    List<int>? time = await database.stockdao.getTimeBySid(sid);

    List<ChartDataModel> chartList = [];

    //showing only latest 10 records
    for (int i = price!.length - 1;
        price.length > 10 ? i > price.length - 10 : i < price.length && i >= 0;
        i--) {
      debugPrint("$i ");
      chartList.add(ChartDataModel(price[i], time![i]));
    }
    return chartList;
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  // method to calculate most expensive stock
  StockModel getMostExpensiveStock(List<StockModel> stocksList) {
    StockModel expensiveStock = stocksList[0];
    stocksList.reduce((a, b) {
      if (a.stockPrice > b.stockPrice)
        return a;
      else
        return b;
    });
    return expensiveStock;
  }
}
