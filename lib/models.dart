import 'package:flutter/foundation.dart';

class StockPrice {
  StockPrice({@required this.date, @required this.price});

  final DateTime date;
  final double price;

  StockPrice.fromJson(Map<String, dynamic> data)
      : this.date = DateTime.parse(data["Date"].toString()),
        this.price = double.parse(data["Price"].toString());
}

enum DataSize { small, medium, big }

enum Library { sparkline, bezier, flarts, flChart, chartsFlutter }
