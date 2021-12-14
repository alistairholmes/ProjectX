import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_x/data/api/rates_api_client.dart';
import 'package:project_x/generated/l10n.dart';
import 'package:project_x/screens/add_currency_screen.dart';
import 'package:project_x/screens/convert_currency_screen.dart';
import 'package:project_x/widgets/currency_card.dart';
import 'package:project_x/widgets/rates_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RatesApiClient _client = RatesApiClient();

  @override
  void initState() {
    _client.getLatestRates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF18203C),
        title: Text(
          'Project X',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ConvertCurrency()));
              },
              icon: Icon(Icons.wifi_protected_setup))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              S.of(context).todaysRates,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Base Currency: USD',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
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
        backgroundColor: Color(0xFF18203C),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCurrency()));
        },
        tooltip: 'Add Currency',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
