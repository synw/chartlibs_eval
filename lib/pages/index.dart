import 'package:flutter/material.dart';
import 'drawer.dart';
import '../models.dart';
import '../conf.dart';

class _IndexPageState extends State<IndexPage> {
  bool ready = false;

  @override
  void initState() {
    onConfReady.then((_) => setState(() => ready = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ready
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
              RaisedButton(
                child: const Text("Small dataset"),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<Page>(builder: (BuildContext context) {
                  return Page(library: Library.sparkline);
                })),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20.0)),
              RaisedButton(
                child: const Text("Medium dataset"),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<Page>(builder: (BuildContext context) {
                  return Page(
                      library: Library.sparkline, dataSize: DataSize.medium);
                })),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20.0)),
              RaisedButton(
                child: const Text("Big dataset"),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<Page>(builder: (BuildContext context) {
                  return Page(
                      library: Library.sparkline, dataSize: DataSize.big);
                })),
              ),
            ])
          : const CircularProgressIndicator(),
    ));
  }
}

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}
