import 'package:tickertape/response/stock_fetch_response.dart';

/// Stock Model -> Model Class for Stock Data
class StockModel {
  String stockName = "";
  double stockPrice = 0.0;
  bool isChangeUp = false;
  double change = 0.0;

  StockModel(this.stockName, this.stockPrice, this.isChangeUp, this.change);

  StockModel.fromJson(Datum json) {
    this.stockName = json.sid ?? "";
    this.stockPrice = json.price ?? 0.0;
    this.change = json.change ?? 0.0;
    this.isChangeUp = json.change.toString().contains("-") ? false : true;
  }
}
