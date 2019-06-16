import 'conf.dart';
import 'models.dart';

Future<List<StockPrice>> dataset([int limit = 15]) async {
  var prices = <StockPrice>[];
  try {
    List<Map<String, dynamic>> items =
        await db.select(table: "stock", limit: limit);
    items.forEach((item) => prices.add(StockPrice.fromJson(item)));
  } catch (e) {
    throw ("Can not retrieve stock prices $e");
  }
  return prices;
}
