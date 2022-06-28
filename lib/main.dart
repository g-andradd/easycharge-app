import 'package:easycharge_mobile/screens/lista/clientes.dart';
import 'package:flutter/material.dart';

void main() => runApp(EasychargeApp());

class EasychargeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[700],
      ),
      home: ListaDeClientes(),
    );
  }
}
