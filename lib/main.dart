import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/Credit-Cart/Classlar/Flutter_Credit_Card_NFC.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Colors.transparent,
              elevation: 4,
              
              titleTextStyle: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: Color.fromARGB(255, 69, 121, 146),
                  fontWeight: FontWeight.bold))),
      home: FlutterCreditCardNfc(),
    );
  }
}
