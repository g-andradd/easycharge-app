import 'package:flutter/material.dart';

import '../models/cliente.dart';

class ListaDeClientesState extends ChangeNotifier{
  final List<Cliente> _clientes = [];

  List<Cliente> getClientes() => _clientes;

  void adicionaCliente(Cliente novoCliente) {
    _clientes.add(novoCliente);
    notifyListeners();
  }
}