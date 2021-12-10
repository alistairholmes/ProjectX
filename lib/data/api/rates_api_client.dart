import 'package:dio/dio.dart';
import 'package:project_x/data/models/rates_model.dart';

class RatesApiClient {
  final Dio _dio = Dio();

  //Gets latest rates for 5 default currencies
  final _ratesUrl =
      'https://openexchangerates.org/api/latest.json?app_id=4995ae7b6a7a4e1dbeb42140db2a8303&symbols=GBP,EUR,AED,CAD';

  Future<Rates> getLatestRates() async {
    Response ratesData = await _dio.get(_ratesUrl);

    // Print data from api
    print('Rates Data: ${ratesData.data}');

    Rates rates = Rates.fromJson(ratesData.data);

    return rates;
  }
}
