import 'package:flutter/material.dart';
import 'package:project_x/data/models/rates_model.dart';

class CurrencyCard extends StatelessWidget {
  CurrencyCard({this.currencyCode, @required this.currencyRate});
  final String? currencyCode;
  final double? currencyRate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(currencyCode.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(currencyRate.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
