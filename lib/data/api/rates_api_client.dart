import 'dart:convert';

import 'package:http/http.dart' as http;

class RatesApiClient {
  Future<Map<dynamic, dynamic>> getLatestRates() async {
    var url = Uri.parse(
        'https://openexchangerates.org/api/latest.json?app_id=4995ae7b6a7a4e1dbeb42140db2a8303&symbols=GBP,EUR,AED,CAD');
    final response = await http.get(url);
    final decoded = jsonDecode(response.body) as Map;
    final data = decoded['rates'] as Map;

    return data;
  }
}
