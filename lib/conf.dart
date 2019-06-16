import 'dart:async';
import 'package:sqlcool/sqlcool.dart';

Db db = Db();

final Completer _readyCompleter = Completer<void>();

Future<void> get onConfReady => _readyCompleter.future;

Future<void> initConf() async {
  String dbpath = "stocks.sqlite";
  try {
    await db.init(path: dbpath, fromAsset: "assets/stocks.db", verbose: true);
  } catch (e) {
    throw ("Error initializing the database; $e");
  }
  _readyCompleter.complete();
  print("Configuration completed");
}
