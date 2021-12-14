import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'package:project_x/screens/home_screen.dart';

import 'generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF18203C),
        fontFamily: 'Montserrat',
      ),
      home: HomeScreen(),
    );
  }
}
