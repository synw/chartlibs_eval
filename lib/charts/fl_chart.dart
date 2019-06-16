import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models.dart';

class _FlChartPageState extends State<FlChartPage> {
  _FlChartPageState({@required this.dataset});

  final List<StockPrice> dataset;

  final _data = <FlSpot>[];
  Map<double, String> labels = <double, String>{};
  bool _ready = false;
  bool points = true;

  @override
  void initState() {
    if (dataset.length > 15) points = false;
    double i = 1;
    dataset.forEach((StockPrice dataPoint) {
      _data.add(FlSpot(i, dataPoint.price));
      String dateStr = "${dataPoint.date.month}/${dataPoint.date.day}";
      labels[i] = dateStr;
      i++;
    });
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
                child: FlChart(
                    chart: LineChart(LineChartData(
                        titlesData: FlTitlesData(getHorizontalTitles: (value) {
                          return labels[value];
                        }),
                        lineBarsData: [
                      LineChartBarData(
                          dotData: FlDotData(show: points),
                          belowBarData: const BelowBarData(show: false),
                          isCurved: true,
                          colors: [
                            Colors.green,
                          ],
                          spots: _data)
                    ]))))
            : const Center(child: CircularProgressIndicator()));
  }
}

class FlChartPage extends StatefulWidget {
  FlChartPage({@required this.dataset});

  final List<StockPrice> dataset;

  @override
  _FlChartPageState createState() => _FlChartPageState(dataset: dataset);
}
