import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bezier_chart/bezier_chart.dart';
import '../models.dart';

class _BezierPageState extends State<BezierPage> {
  _BezierPageState({@required this.dataset});

  final List<StockPrice> dataset;

  final _data = <DataPoint<String>>[];
  final _dataTime = <DataPoint<DateTime>>[];
  final _xVals = <double>[];
  bool _ready = false;
  BezierChart chart;

  @override
  void initState() {
    if (dataset.length > 15)
      chart = biggerDataset();
    else
      chart = smallDataset();
    double i = 0;
    dataset.forEach((datapoint) {
      if (dataset.length > 15) {
        _dataTime.add(
            DataPoint<DateTime>(value: datapoint.price, xAxis: datapoint.date));
      } else {
        _xVals.add(i);
        _data.add(DataPoint<String>(value: datapoint.price, xAxis: "$i"));
      }
      i++;
    });
    setState(() => _ready = true);
    super.initState();
  }

  BezierChart smallDataset() {
    return BezierChart(
      bezierChartScale: BezierChartScale.CUSTOM,
      xAxisCustomValues: _xVals,
      series: [
        BezierLine(data: _data),
      ],
      config: BezierChartConfig(backgroundColor: Colors.grey),
    );
  }

  BezierChart biggerDataset() {
    return BezierChart(
      bezierChartScale: BezierChartScale.MONTHLY,
      fromDate: dataset.first.date,
      toDate: dataset.last.date,
      series: [
        BezierLine(data: _dataTime),
      ],
      config: BezierChartConfig(backgroundColor: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width / 0.2,
      child: _ready
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: chart)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class BezierPage extends StatefulWidget {
  BezierPage({@required this.dataset});

  final List<StockPrice> dataset;

  @override
  _BezierPageState createState() => _BezierPageState(dataset: dataset);
}
