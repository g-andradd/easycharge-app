import 'package:easycharge_mobile/models/cliente.dart';
import 'package:easycharge_mobile/state/WizardCadastroDeClienteState.dart';
import 'package:easycharge_mobile/state/listaDeClientesState.dart';
import 'package:easycharge_mobile/screens/cliente/listagem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
        create: (context) => ListaDeClientesState()
    ),
    ChangeNotifierProvider(
        create: (context) => WizardCadastroDeClienteState()
    ),
  ],
  child: EasychargeApp(),
));

class EasychargeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Open Sans',
          primaryColor: Colors.grey[900],
          appBarTheme: AppBarTheme(color: Colors.grey[900]),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.grey[900],
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.blueGrey[700])),
      home: ListagemDeClientes(),
    );
  }
}
