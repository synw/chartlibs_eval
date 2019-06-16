import 'package:chartlibs_eval/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models.dart';
import '../charts/sparkline.dart';
import '../charts/bezier.dart';
import '../charts/flarts.dart';
import '../charts/fl_chart.dart';
import '../charts/charts_flutter.dart';

class _PageState extends State<Page> {
  _PageState({@required this.library, this.dataSize = DataSize.small});

  Library library;
  final DataSize dataSize;

  List<StockPrice> _dataset;
  bool _ready = false;
  String _title;

  @override
  void initState() {
    switch (dataSize) {
      case DataSize.medium:
        _title = "500 datapoints";
        dataset(500).then((List<StockPrice> data) {
          _dataset = data;
          setState(() => _ready = true);
        });
        break;
      case DataSize.big:
        _title = "3000 datapoints";
        dataset(3000).then((List<StockPrice> data) {
          _dataset = data;
          setState(() => _ready = true);
        });
        break;
      default:
        _title = "15 datapoints";
        dataset().then((List<StockPrice> data) {
          _dataset = data;
          setState(() => _ready = true);
        });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget w = const Text("");
    String title = "";
    if (_ready)
      switch (library) {
        case Library.sparkline:
          title = "Sparkline";
          w = SparklinePage(dataset: _dataset);
          break;
        case Library.bezier:
          title = "Bezier";
          w = BezierPage(dataset: _dataset);
          break;
        case Library.flarts:
          title = "FlartsPage";
          w = FlartsPage(dataset: _dataset);
          break;
        case Library.flChart:
          title = "Fl chart";
          w = FlChartPage(dataset: _dataset);
          break;
        case Library.chartsFlutter:
          title = "Charts Flutter";
          w = ChartsFlutterPage(dataset: _dataset);
          break;
        default:
          w = const Text("");
      }
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(title, textScaleFactor: 2.0)),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), child: w),
          if (library != Library.sparkline)
            Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(children: <Widget>[
                  RaisedButton(
                    child: const Text("Sparkline"),
                    onPressed: () =>
                        setState(() => library = Library.sparkline),
                  )
                ])),
          if (library != Library.bezier)
            Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(children: <Widget>[
                  RaisedButton(
                    child: const Text("Bezier"),
                    onPressed: () => setState(() => library = Library.bezier),
                  )
                ])),
          if (library != Library.flarts)
            Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(children: <Widget>[
                  RaisedButton(
                    child: const Text("Flarts"),
                    onPressed: () => setState(() => library = Library.flarts),
                  )
                ])),
          if (library != Library.flChart)
            Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(children: <Widget>[
                  RaisedButton(
                    child: const Text("Fl chart"),
                    onPressed: () => setState(() => library = Library.flChart),
                  )
                ])),
          if (library != Library.chartsFlutter)
            Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(children: <Widget>[
                  RaisedButton(
                    child: const Text("Charts Flutter"),
                    onPressed: () =>
                        setState(() => library = Library.chartsFlutter),
                  )
                ])),
        ]));
  }
}

class Page extends StatefulWidget {
  Page({@required this.library, this.dataSize = DataSize.small});

  final Library library;
  final DataSize dataSize;

  @override
  _PageState createState() => _PageState(library: library, dataSize: dataSize);
}
