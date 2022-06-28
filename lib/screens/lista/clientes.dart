import 'package:flutter/material.dart';

import '../../models/cliente.dart';
import '../formulario/cliente.dart';

const _tituloAppBar = 'Lista de Clientes';

class ListaDeClientes extends StatefulWidget {
  final List<Cliente> _clientes = [];

  @override
  State<StatefulWidget> createState() {
    return ListaDeClientesState();
  }
}

class ListaDeClientesState extends State<ListaDeClientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._clientes.length,
        itemBuilder: (context, indice) {
          final cliente = widget._clientes[indice];
          return ItemCliente(cliente);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioCliente();
          })).then(
                (clienteRecebido) => _atualiza(clienteRecebido),
          );
        },
      ),
    );
  }

  void _atualiza(Cliente clienteRecebido) {
    if (clienteRecebido != null) {
      setState(() {
        widget._clientes.add(clienteRecebido);
      });
    }
  }
}

class ItemCliente extends StatelessWidget {
  final Cliente _cliente;

  ItemCliente(this._cliente);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(Icons.people),
          title: Text(_cliente.nome),
          subtitle: Text(_cliente.id.toString()),
        ));
  }
}