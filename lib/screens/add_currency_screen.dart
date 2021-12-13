import 'package:flutter/material.dart';
import 'package:project_x/data/api/rates_api_client.dart';
import 'package:project_x/widgets/currency_card.dart';

class AddCurrency extends StatelessWidget {
  final RatesApiClient _client = RatesApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Currency',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: FutureBuilder<Map<dynamic, dynamic>>(
              future: _client.getCurrencies(),
              builder: (context, snapshot) {
                List? currencies = [];
                List? currentRates = [];
                if (snapshot.hasData) {
                  for (final currency in snapshot.data!.keys) {
                    final value = snapshot.data![currency];
                    //print('$currency'); //
                    //print('$value'); // prints entries like "AED,3.672940"
                    currencies.add(currency);
                    currentRates.add(value);
                  }
                  return ListView.builder(
                      shrinkWrap: false,
                      itemCount: currencies!.length,
                      itemBuilder: (context, index) {
                        return CurrencyCard(
                          currencyCode: currencies![index],
                          currencyName: currentRates![index],
                        );
                      });
                }
                return CircularProgressIndicator();
              },
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Save Currency',
        child: Icon(Icons.check),
      ),
    );
  }
}
