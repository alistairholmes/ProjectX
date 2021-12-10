import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x/data/api/rates_api_client.dart';
import 'package:project_x/data/models/rates_model.dart';
import 'package:project_x/screens/add_currency_screen.dart';
import 'package:project_x/widgets/currency_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final RatesApiClient _client = RatesApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project X',
          style: TextStyle(),
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
          Center(
              child: FutureBuilder<Rates?>(
            future: _client.getLatestRates(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Rates? data = snapshot.data;
                return CurrencyCard(
                  currencyRate: data!.gBP,
                );
              }
              return CircularProgressIndicator();
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCurrency()));
        },
        tooltip: 'Add Currency',
        child: Icon(Icons.add),
      ),
    );
  }
}
