import 'package:easycharge_mobile/http/webclient.dart';
import 'package:easycharge_mobile/state/wizard_cadastro_cliente_state.dart';
import 'package:easycharge_mobile/state/lista_clientes_state.dart';
import 'package:easycharge_mobile/screens/cliente/listagem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListaDeClientesState()),
        ChangeNotifierProvider(
            create: (context) => WizardCadastroDeClienteState()),
      ],
      child: EasychargeApp(),
    ),
  );
  findAll().then((clientes) => debugPrint('Clientes: $clientes'));
}

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
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.blueGrey[700])),
      home: ListagemDeClientes(),
    );
  }
}
