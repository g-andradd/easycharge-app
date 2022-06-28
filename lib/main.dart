import 'package:easycharge_mobile/screens/autenticacao/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(EasychargeApp());

class EasychargeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.grey[900],
          appBarTheme: AppBarTheme(color: Colors.grey[900]),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.grey[900],
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.blueGrey[700])),
      home: Login(),
    );
  }
}
