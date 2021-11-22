import 'package:flutter/cupertino.dart';
import 'package:tickertape/database/all_stocks_entity.dart';
import 'package:tickertape/database/database.dart';
import 'package:tickertape/models/stock_item_model.dart';
import 'package:tickertape/network/network_utils.dart';
import 'package:tickertape/response/stock_fetch_response.dart';
import 'package:tickertape/utils/string_constants.dart';

/// Stock Network Access Object Class -> Network Access Object class for handling network requests of fetching Stock
class StockNAO {
  /// STATIC Is Authentic Stock Method -> Future<StockModel>
  /// @param -> @required stockName -> String
  ///        -> @required stockPrice -> double
  /// @usage -> Makes a HTTP-GET request to REST api on server.
  static Future<List<StockModel>> getStocks({@required List<String> stocks}) =>
      NetworkUtil()
          .get(
        // HTTP-GET request
        url: STOCK_BASE_API +
            STOCK_API_ENDPOINT +
            stocks.join(","), // REST api URL
      )
          .then((dynamic response) {
        // On response received
        StockFetchResponse stockFetchResponse =
            StockFetchResponse.fromMap(response);
        debugPrint("response -----> " + stockFetchResponse.data.toString());

        List<StockModel> stockList = [];

        for (int i = 0; i < stockFetchResponse.data.length; i++) {
          stockList.add(StockModel.fromJson(stockFetchResponse.data[i]));
        }

        storeInLocalDatabase(stockList);

        return stockList; // Map json response to UserModel object
      });

  /// method to store in local database
  static Future<void> storeInLocalDatabase(List<StockModel> stockList) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    stockList.forEach((element) {
      database.stockdao.insertStock(Stocks(element.stockName,
          element.stockPrice, element.change, !element.change.isNegative));
    });
  }
}
