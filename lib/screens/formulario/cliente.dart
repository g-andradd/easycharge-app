import 'package:flutter/material.dart';

import '../../compenents/editor.dart';
import '../../models/cliente.dart';

const _tituloAppBar = 'Cadastro de Cliente';

const _rotuloCampoNome = 'Nome';
const _dicaCampoNome = 'Nome Completo';

const _rotuloCampoId = 'ID';
const _dicaCampoId = '0';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioCliente extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioClienteState();
  }
}

class FormularioClienteState extends State<FormularioCliente> {
  final TextEditingController _controladorCampoNome = TextEditingController();
  final TextEditingController _controladorCampoId = TextEditingController();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoNome,
                dica: _dicaCampoNome,
                rotulo: _rotuloCampoNome,
                icone: Icons.person,
                inputType: TextInputType.name,
              ),
              Editor(
                dica: _dicaCampoId,
                controlador: _controladorCampoId,
                rotulo: _rotuloCampoId,
                icone: Icons.numbers,
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () => _criaCliente(context),
                child: const Text(_textoBotaoConfirmar),
              ),
            ],
          ),
        ));
  }

  void _criaCliente(BuildContext context) {
    final String nome = _controladorCampoNome.text;
    final int? id = int.tryParse(_controladorCampoId.text);
    if (nome.isNotEmpty && id != null) {
      final clienteCriado = Cliente(nome, id);
      Navigator.pop(context, clienteCriado);
    }
  }
}
