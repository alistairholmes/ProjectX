import 'package:flutter/material.dart';
import 'package:project_x/data/api/rates_api_client.dart';

class ConvertCurrency extends StatelessWidget {
  final RatesApiClient _client = RatesApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert Currency'),
      ),
      body: Column(
        children: [
          Text('USD'),
          Text('United States Dollars'),
          TextFormField(),
          Center(
            child: Icon(
              Icons.wifi_protected_setup,
              size: 50,
            ),
          ),
          Text('GBP'),
          Text('Great British Pounds'),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('='), Text('1.234')],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _client.getConversion();
        },
        tooltip: 'Convert Currency',
        child: Icon(Icons.shuffle),
      ),
    );
  }
}
