import 'package:flutter/material.dart';

import 'cliente.dart';

class ListaDeClientes extends ChangeNotifier{
  final List<Cliente> _clientes = [];

  List<Cliente> getClientes() => _clientes;

  void adicionaCliente(Cliente novoCliente) {
    _clientes.add(novoCliente);
    notifyListeners();
  }
}