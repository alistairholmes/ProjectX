import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x/data/api/rates_api_client.dart';
import 'package:project_x/screens/add_currency_screen.dart';
import 'package:project_x/screens/convert_currency_screen.dart';
import 'package:project_x/widgets/currency_card.dart';
import 'package:project_x/widgets/rates_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final RatesApiClient _client = RatesApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project X',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Today\'s Rates',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Center(
            child: FutureBuilder<Map<dynamic, dynamic>>(
              future: _client.getLatestRates(),
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
                      itemCount: currencies.length,
                      itemBuilder: (context, index) {
                        return RatesCard(
                          currencyCode: currencies[index],
                          currencyRate: currentRates[index],
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
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ConvertCurrency()));
        },
        tooltip: 'Add Currency',
        child: Icon(Icons.add),
      ),
    );
  }
}
