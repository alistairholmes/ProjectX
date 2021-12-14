import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RatesApiClient {
  // Create storage
  final storage = FlutterSecureStorage();
  var savedCurrency;

  // Default Currency to be loaded
  var defaultCurrencies = 'ZAR,' + 'GBP,' + 'EUR,' + 'BWP,';

  // Read database for added currencies to be monitored
  readCurrencyFromDB() async {
    savedCurrency = await storage.read(key: 'currency');
  }

  // API call to get a list of latest rates
  Future<Map<dynamic, dynamic>> getLatestRates() async {
    // Check for saved currency
    readCurrencyFromDB();

    // Build request
    var url;
    if (savedCurrency != null) {
      url = Uri.parse(
          'https://openexchangerates.org/api/latest.json?app_id=4995ae7b6a7a4e1dbeb42140db2a8303&symbols=' +
              defaultCurrencies +
              savedCurrency);
    } else {
      url = Uri.parse(
          'https://openexchangerates.org/api/latest.json?app_id=4995ae7b6a7a4e1dbeb42140db2a8303&symbols=' +
              defaultCurrencies);
    }
    final response = await http.get(url);
    final decoded = jsonDecode(response.body) as Map;
    final data = decoded['rates'] as Map;

    return data;
  }

  // API call to get a list of all currencies

  Future<Map<dynamic, dynamic>> getCurrencies() async {
    var url = Uri.parse('https://openexchangerates.org/api/currencies.json');
    final response = await http.get(url);
    final data = jsonDecode(response.body) as Map;

    return data;
  }

  // API call to convert a USD value into another currency
  Future<double> getConversion(
      double amountToBeConverted, String currencyToConvert) async {
    var url = Uri.parse(
        'https://openexchangerates.org/api/latest.json?app_id=4995ae7b6a7a4e1dbeb42140db2a8303&symbols=' +
            currencyToConvert);
    final response = await http.get(url);
    final decoded = jsonDecode(response.body) as Map;
    final data = decoded['rates'] as Map;

    double? convertedAmount;

    for (final name in data.keys) {
      final value = data[name];
      print('$value'); // prints entries like "3.672940"
      convertedAmount = value * amountToBeConverted; // multiply rate by amount
      print(convertedAmount);
    }

    if (amountToBeConverted > 200) {
      var add4Percent = convertedAmount! * 0.04;
      convertedAmount = convertedAmount + add4Percent;
      print(convertedAmount);
    } else {
      var add7Percent = convertedAmount! * 0.07;
      convertedAmount = convertedAmount + add7Percent;
      print(convertedAmount);
    }

    return convertedAmount.roundToDouble();
  }
}
