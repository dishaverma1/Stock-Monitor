import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tickertape/models/stock_item_model.dart';
import 'package:tickertape/utils/color_constants.dart';
import 'package:tickertape/utils/string_constants.dart';

/// StockItem -> View class for each stock Item
class StockItem extends StatefulWidget {
  final int index;
  final StockModel stockModel;

  const StockItem({Key? key, required this.index, required this.stockModel})
      : super(key: key);

  @override
  _StockItemState createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.stockModel.stockName,
            style: TextStyle(fontFamily: ROBOTO_REGULAR),
          ),
          Row(
            children: [
              Text(
                Rs +
                    widget.stockModel.stockPrice
                        .toString()
                        .replaceFirst("-", ""),
                style: TextStyle(fontFamily: ROBOTO_REGULAR),
              ),
              Icon(
                widget.stockModel.isChangeUp
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color: widget.stockModel.isChangeUp ? kGREEN_SHADE_ONE : kRED,
              )
            ],
          )
        ],
      ),
    );
  }
}
