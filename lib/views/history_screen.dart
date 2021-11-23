// import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tickertape/models/chart_model.dart';
import 'package:tickertape/models/stock_item_model.dart';
import 'package:tickertape/utils/color_constants.dart';
import 'package:tickertape/utils/string_constants.dart';

class HistoryScreen extends StatefulWidget {
  final StockModel stockItem;
  final List<ChartDataModel> data;
  const HistoryScreen({Key? key, required this.stockItem, required this.data})
      : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWHITE,
      appBar: AppBar(
        backgroundColor: kWHITE,
      ),
      body: Center(
        child: Column(
          children: [
            PriceWidget(
              item: widget.stockItem,
            ),
            ChartWidget(
              items: _createSampleData(),
            ),
          ],
        ),
      ),
    );
  }

  List<charts.Series<ChartDataModel, int>> _createSampleData() {
    return [
      charts.Series<ChartDataModel, int>(
        id: 'Stocks History',
        domainFn: (ChartDataModel sales, _) => sales.time,
        measureFn: (ChartDataModel sales, _) => sales.price,
        data: widget.data,
        colorFn: (ChartDataModel segment, _) =>
            charts.MaterialPalette.blue.shadeDefault,
      ),
    ];
  }
}

class PriceWidget extends StatelessWidget {
  final StockModel item;
  const PriceWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // latest price
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              item.stockPrice.toString(),
              style: TextStyle(
                fontFamily: ROBOTO_MEDIUM,
                fontSize: 24,
              ),
            ),
          ),

          // absolute change
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(
                  item.isChangeUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: item.isChangeUp ? kGREEN_SHADE_ONE : kRED,
                ),
                Text(
                  item.change.toString().replaceFirst("-", ""),
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: ROBOTO_REGULAR,
                      color: item.isChangeUp ? kGREEN_SHADE_ONE : kRED),
                ),
              ],
            ),
          ),

          // percentage change
          Container(
            margin: EdgeInsets.all(5),
            child: Text(
              item.isChangeUp
                  ? "(+${((item.change / item.stockPrice) * 100).toStringAsFixed(2)}%)"
                  : "(${((item.change / item.stockPrice) * 100).toStringAsFixed(2)}%)",
              style: TextStyle(
                fontFamily: ROBOTO_REGULAR,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  final List<charts.Series<ChartDataModel, int>> items;
  const ChartWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.all(10),
      child: new charts.LineChart(
        items,
        animate: true,
        // domainAxis: charts.OrdinalAxisSpec(
        //   renderSpec: charts.SmallTickRendererSpec(
        //     lineStyle: charts.LineStyleSpec(
        //         thickness: 0, color: charts.ColorUtil.fromDartColor(kASH_Colour)),
        //     labelStyle: charts.TextStyleSpec(
        //         fontFamily: 'Roboto-Medium',
        //         fontSize: 14,
        //         color: charts.ColorUtil.fromDartColor(kASH_Colour)),
        //   ),
        // ),
        // defaultRenderer: charts.LineRendererConfig(
        //   groupingType: charts.BarGroupingType.grouped,
        //   cornerStrategy: const charts.ConstCornerStrategy(30),
        // ),
        // primaryMeasureAxis: charts.NumericAxisSpec(
        //   tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
        // ),
        // secondaryMeasureAxis: charts.NumericAxisSpec(
        //     tickProviderSpec:
        //         charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
      ),
    );
  }
}
