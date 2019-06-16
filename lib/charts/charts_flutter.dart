import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models.dart';

class _ChartsFlutterPageState extends State<ChartsFlutterPage> {
  _ChartsFlutterPageState({@required this.dataset});

  final List<StockPrice> dataset;

  List<charts.Series<StockPrice, DateTime>> seriesList;
  bool _ready = false;
  bool points = true;

  @override
  void initState() {
    if (dataset.length > 15) points = false;
    seriesList = [
      charts.Series<StockPrice, DateTime>(
        id: 'Stock',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (StockPrice dataPoint, _) => dataPoint.date,
        measureFn: (StockPrice dataPoint, _) => dataPoint.price,
        data: dataset,
      )
    ];
    setState(() => _ready = true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 0.4,
        height: 250.0,
        child: _ready
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: charts.TimeSeriesChart(
                  seriesList,
                  animate: true,
                  primaryMeasureAxis: const charts.NumericAxisSpec(
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(
                          zeroBound: false)),
                  defaultRenderer: charts.LineRendererConfig(
                      includePoints: points, includeArea: true),
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                ))
            : const Center(child: CircularProgressIndicator()));
  }
}

class ChartsFlutterPage extends StatefulWidget {
  ChartsFlutterPage({@required this.dataset});

  final List<StockPrice> dataset;

  @override
  _ChartsFlutterPageState createState() =>
      _ChartsFlutterPageState(dataset: dataset);
}
