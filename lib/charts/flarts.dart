import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flarts/flart.dart';
import 'package:flarts/flart_data.dart';
import 'package:flarts/flart_axis.dart';
import '../models.dart';

class _FlartsPageState extends State<FlartsPage> {
  _FlartsPageState({@required this.dataset});

  final List<StockPrice> dataset;

  final _data = <double>[];
  final _dates = <String>[];
  bool _ready = false;

  @override
  void initState() {
    dataset.forEach((StockPrice dataPoint) {
      _data.add(dataPoint.price);
      _dates.add(dataPoint.date.toString());
    });
    setState(() => _ready = true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget w;
    _ready
        ? w = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Flart(
                Size(MediaQuery.of(context).size.width, 250),
                [
                  FlartData<StockPrice, DateTime, double>(dataset,
                      rangeFn: (dataPoint, i) => dataPoint.price,
                      domainFn: (dataPoint, i) => dataPoint.date,
                      customColor: Colors.green,
                      domainAxis: FlartAxis(
                        Axis.horizontal,
                        dataset.first.date,
                        dataset.last.date,
                        labelConfig: AxisLabelConfig(
                          frequency: AxisLabelFrequency.perGridline,
                          text: AxisLabelTextSource.interpolateFromDataType,
                        ),
                        numGridlines: 8,
                      ),
                      rangeAxis: FlartAxis(
                        Axis.vertical,
                        _data.reduce(min),
                        _data.reduce(max),
                        side: Side.left,
                        labelConfig: AxisLabelConfig(
                          frequency: AxisLabelFrequency.perGridline,
                          text: AxisLabelTextSource.interpolateFromDataType,
                        ),
                        numGridlines: 4,
                      ))
                ],
              ),
            ),
          )
        : w = const Center(child: CircularProgressIndicator());
    return w;
  }
}

class FlartsPage extends StatefulWidget {
  FlartsPage({@required this.dataset});

  final List<StockPrice> dataset;

  @override
  _FlartsPageState createState() => _FlartsPageState(dataset: dataset);
}
