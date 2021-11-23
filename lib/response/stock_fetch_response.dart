// To parse this JSON data, do
//
//     final stockFetchResponse = stockFetchResponseFromMap(jsonString);

import 'dart:convert';

StockFetchResponse stockFetchResponseFromMap(String str) =>
    StockFetchResponse.fromMap(json.decode(str));

String stockFetchResponseToMap(StockFetchResponse data) =>
    json.encode(data.toMap());

class StockFetchResponse {
  StockFetchResponse({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory StockFetchResponse.fromMap(Map<String, dynamic> json) =>
      StockFetchResponse(
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    this.sid,
    this.price,
    this.close,
    this.change,
    this.high,
    this.low,
    this.volume,
    this.date,
  });

  String? sid;
  double? price;
  double? close;
  double? change;
  double? high;
  double? low;
  int? volume;
  DateTime? date;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        sid: json["sid"] == null ? null : json["sid"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        close: json["close"] == null ? null : json["close"].toDouble(),
        change: json["change"] == null ? null : json["change"].toDouble(),
        high: json["high"] == null ? null : json["high"].toDouble(),
        low: json["low"] == null ? null : json["low"].toDouble(),
        volume: json["volume"] == null ? null : json["volume"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "sid": sid == null ? null : sid,
        "price": price == null ? null : price,
        "close": close == null ? null : close,
        "change": change == null ? null : change,
        "high": high == null ? null : high,
        "low": low == null ? null : low,
        "volume": volume == null ? null : volume,
        "date": date == null ? null : date,
      };
}
