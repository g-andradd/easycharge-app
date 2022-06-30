import 'package:easycharge_mobile/models/listaDeClientes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cliente.dart';
import 'formulario.dart';

const _tituloAppBar = 'Listagem de Clientes';

class ListagemDeClientes extends StatefulWidget {
  final List<Cliente> _clientes = [];

  @override
  State<StatefulWidget> createState() {
    return ListagemDeClientesState();
  }
}

class ListagemDeClientesState extends State<ListagemDeClientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Consumer<ListaDeClientes>(
            builder: (context, listaDeClientes, child) {
          List<Cliente> todosOsClientes = listaDeClientes.getClientes();
          return ListView.separated(
            shrinkWrap: true,
            itemCount: todosOsClientes.length,
            itemBuilder: (contextListView, indice) {
              return ItemCliente(todosOsClientes[indice]);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => FormularioCliente()))
              .then(
                (clienteRecebido) => _atualiza(clienteRecebido),
              );
        },
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }

  void _atualiza(Cliente clienteRecebido) {
    setState(() {
      widget._clientes.add(clienteRecebido);
    });
  }
}

class ItemCliente extends StatelessWidget {
  final Cliente _cliente;

  ItemCliente(this._cliente);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.people),
      title: Text(_cliente.nome),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text('CPF: ${_cliente.cpf}'),
      ),
    ));
  }
}
