import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tickertape/models/chart_model.dart';
import 'package:tickertape/models/stock_item_model.dart';
import 'package:tickertape/utils/baseview.dart';
import 'package:tickertape/utils/color_constants.dart';
import 'package:tickertape/utils/navigator.dart';
import 'package:tickertape/utils/string_constants.dart';
import 'package:tickertape/viewmodel/home_viewmodel.dart';
import 'package:tickertape/views/history_screen.dart';
import 'package:tickertape/views/stock_item.dart';

/// Home Screen -> View class for Home Screen to display fetched stocks
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext buildContext) {
    return BaseView<HomeViewModel>(
      instanceModel: HomeViewModel(),
      onModelReady: (model) async {
        // fetching all stocks on landing on home screen
        await model.fetchStockList(FETCH_STOCKS);
      },
      builder: (context, HomeViewModel model, child) => MaterialApp(
        home: Scaffold(
          backgroundColor: kWHITE,
          appBar: AppBar(
            backgroundColor: kWHITE,
            centerTitle: false,
            title: Text(
              STOCKS,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: ROBOTO_MEDIUM,
                color: kBLACK,
                fontSize: 16,
              ),
            ),
            actions: [
              Builder(
                builder: (BuildContext context) => Container(
                  margin: EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () async {
                      StockModel topStock = model.getExpensiveStock;
                      List<ChartDataModel> list =
                          await model.fetchStocksByPrice(topStock.stockName);

                      // navigating to history screen of most expensive stock
                      navigateTo(
                          HistoryScreen(
                            stockItem: topStock,
                            data: list,
                            // list: list,
                          ),
                          context);
                    },
                    child: Icon(
                      Icons.insert_chart_rounded,
                      color: kBLACK,
                      size: 26,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () async {
                    //checking if timer is on
                    // if timer OFF, setting it to ON & then polling API every 5 second
                    // if timer is ON, setting it to OFF & stop API call
                    if (model.isTimerOn)
                      model.setTimer(false);
                    else
                      model.setTimer(true);
                  },
                  child: Icon(
                    model.isTimerOn
                        ? Icons.stop_circle_outlined
                        : Icons.play_circle_fill,
                    color: kBlack,
                    size: 26,
                  ),
                ),
              )
            ],
          ),
          body: Container(
            color: k_DIVIDER_COLOR,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        List<ChartDataModel> list =
                            await model.fetchStocksByPrice(
                                model.getStockList[index].stockName);

                        // navigating to history screen of particular stock
                        navigateTo(
                            HistoryScreen(
                              stockItem: model.getStockList[index],
                              data: list,
                              // list: list,
                            ),
                            context);
                      },
                      child: StockItem(
                        index: index,
                        stockModel: model.getStockList[index],
                      ),
                    ),
                separatorBuilder: (context, index) => Divider(
                      height: 1,
                      endIndent: 20,
                      indent: 20,
                    ),
                itemCount: model.getStockList.length),
          ),
        ),
      ),
    );
  }
}
