import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tickertape/models/chart_model.dart';
import 'package:tickertape/models/stock_item_model.dart';
import 'package:tickertape/utils/color_constants.dart';
import 'package:tickertape/utils/string_constants.dart';

/// HistoryScreen -> another screen to show best performing stock or history of the selected stock
class HistoryScreen extends StatefulWidget {
  final StockModel stockItem;
  final List<ChartDataModel> data;
  const HistoryScreen({Key? key, required this.stockItem, required this.data})
      : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
              items: widget.data,
              title: widget.stockItem.stockName,
            ),
          ],
        ),
      ),
    );
  }
}

/// PriceWidget -> Widget to show basic details about the stock
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

/// ChartWidget -> chart to show stock analysis
class ChartWidget extends StatefulWidget {
  final List<ChartDataModel> items;
  final String title;
  const ChartWidget({Key? key, required this.items, required this.title})
      : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.all(10),
      child: new SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: widget.title),
          // Enable tooltip
          tooltipBehavior: _tooltipBehavior,
          series: <LineSeries<ChartDataModel, int>>[
            LineSeries<ChartDataModel, int>(
                dataSource: widget.items,
                xValueMapper: (ChartDataModel sales, _) => sales.time,
                yValueMapper: (ChartDataModel sales, _) => sales.price,
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ]),
    );
  }
}
