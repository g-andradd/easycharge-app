import 'package:easycharge_mobile/compenents/centered_message.dart';
import 'package:easycharge_mobile/compenents/progresso.dart';
import 'package:easycharge_mobile/state/cliente_json_state.dart';
import 'package:flutter/material.dart';

import '../../http/webclient.dart';
import 'formulario.dart';

const _tituloAppBar = 'Listagem de Clientes';

class ListagemDeClientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: FutureBuilder<List<ClienteJson>>(
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progresso();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.hasData){
                final List<ClienteJson> clientes = snapshot.requireData;
                debugPrint('Passou por aqui $clientes');
                if (clientes.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: clientes.length,
                      itemBuilder: (contextListView, indice) {
                        return ItemCliente(clientes[indice]);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                    ),
                  );
                }
              }
              return CenteredMessage('Não encontramos nenhum cliente!', icon: Icons.warning,);
          }
          return CenteredMessage('Erro desconhecido!');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return FormularioCliente();
          }));
        },
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}

class ItemCliente extends StatelessWidget {
  final ClienteJson _cliente;

  ItemCliente(this._cliente);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.people),
        title: Text(
          _cliente.nome,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            'CPF: ${_cliente.cpf}',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
