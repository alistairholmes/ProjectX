import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_x/data/api/rates_api_client.dart';
import 'package:project_x/generated/l10n.dart';
import 'package:project_x/screens/home_screen.dart';
import 'package:project_x/widgets/currency_card.dart';

class AddCurrency extends StatefulWidget {
  @override
  _AddCurrencyState createState() => _AddCurrencyState();
}

class _AddCurrencyState extends State<AddCurrency> {
  final RatesApiClient _client = RatesApiClient();
  var currencyCodeSelected;

  bool _isSelected = false;

  // Create storage
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF18203C),
        title: Text(S.of(context).selectCurrency,
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
                      itemCount: currencies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            currencyCodeSelected = currencies[index];
                            setState(() {
                              _isSelected = true;
                            });
                          },
                          child: Container(
                            color: _isSelected != true
                                ? Colors.white
                                : Color(0xFF18203C),
                            child: CurrencyCard(
                              currencyCode: currencies[index],
                              currencyName: currentRates[index],
                            ),
                          ),
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
        backgroundColor: Color(0xFF18203C),
        onPressed: () {
          // Save selected currency to database
          saveCurrency(currencyCodeSelected);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).selectedCurrencyHasBeenSaved),
          ));
        },
        tooltip: 'Save Currency',
        child: Icon(Icons.check),
      ),
    );
  }

  saveCurrency(currencyCode) async {
    // Save value
    await storage.write(key: 'currency', value: currencyCode);
  }
}
