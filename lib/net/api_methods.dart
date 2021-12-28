//https://api.coingecko.com/api/v3/coins/

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async {
  try {
    var url = Uri.parse("https://api.coingecko.com/api/v3/coins/${id}");
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    String price = json["market_data"]["current_price"]["usd"].toString();
    print(price);
    return double.parse(price);
  } catch (e) {
    print("Kand ho gaya ${e.toString()}");
    return 0;
  }
}
