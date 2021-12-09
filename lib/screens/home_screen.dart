import 'package:flutter/material.dart';
import 'package:project_x/screens/add_currency_screen.dart';
import 'package:project_x/widgets/currency_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project X'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Todays Rates'),
          ),
          CurrencyCard(),
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
