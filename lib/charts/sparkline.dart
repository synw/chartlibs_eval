import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import '../models.dart';

class _SparklinePageState extends State<SparklinePage> {
  _SparklinePageState({@required this.dataset});

  final List<StockPrice> dataset;

  final _data = <double>[];
  bool _ready = false;
  PointsMode pointsMode = PointsMode.all;

  @override
  void initState() {
    if (dataset.length > 15) pointsMode = PointsMode.none;
    dataset.forEach((StockPrice dataPoint) => _data.add(dataPoint.price));
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
                child: Sparkline(
                    data: _data,
                    pointsMode: pointsMode,
                    pointSize: 8.0,
                    pointColor: Colors.amber))
            : const Center(child: CircularProgressIndicator()));
  }
}

class SparklinePage extends StatefulWidget {
  SparklinePage({@required this.dataset});

  final List<StockPrice> dataset;

  @override
  _SparklinePageState createState() => _SparklinePageState(dataset: dataset);
}
