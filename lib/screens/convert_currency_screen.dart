import 'package:flutter/material.dart';
import 'package:project_x/data/api/rates_api_client.dart';
import 'package:project_x/generated/l10n.dart';

class ConvertCurrency extends StatefulWidget {
  @override
  _ConvertCurrencyState createState() => _ConvertCurrencyState();
}

class _ConvertCurrencyState extends State<ConvertCurrency> {
  final RatesApiClient _client = RatesApiClient();

  var _selectedValue; // Used to get value of currency dropdown

  TextEditingController amountController = TextEditingController();

  List<String> currencyCodes = [];
  var convertedText = '0';

  bool? convertBtnTapped = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF18203C),
        title: Text('Convert Currency'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('USD',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )),
        ),
        Text('United States Dollars',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: amountController,
          ),
        ),
        SizedBox(height: 25),
        Center(
          child: Icon(
            Icons.wifi_protected_setup,
            size: 50,
          ),
        ),
        SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<Map<dynamic, dynamic>>(
            future: _client.getCurrencies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<String> currencyCodes = [];
                for (final currency in snapshot.data!.keys) {
                  currencyCodes.add(currency);
                }
                return DropdownButtonFormField(
                  value: _selectedValue,
                  hint: Text(
                    S.of(context).currencyToConvert,
                  ),
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  onSaved: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  items: currencyCodes.map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                        val,
                      ),
                    );
                  }).toList(),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('=    '),
          SizedBox(height: 50),
          convertBtnTapped! != true
              ? Text('0',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ))
              : FutureBuilder<double>(
                  future: _client.getConversion(
                      double.parse(amountController.text), _selectedValue),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ));
                    }
                    return CircularProgressIndicator();
                  })
        ]),
        Expanded(
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              onPressed: () {
                setState(() {
                  convertBtnTapped = true;
                });
              },
              child: Text(
                S.of(context).convert,
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF18203C))),
            ),
          ),
        ),
      ]),
    );
  }
}
