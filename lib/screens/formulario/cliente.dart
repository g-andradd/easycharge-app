import 'package:flutter/material.dart';

import '../../compenents/editor.dart';
import '../../models/cliente.dart';

const _tituloAppBar = 'Cadastro de Cliente';

const _rotuloCampoNome = 'Nome';
const _dicaCampoNome = 'Nome Completo';

const _rotuloCampoId = 'CPF';
const _dicaCampoId = '000.000.000-00';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Editor(
                  controlador: _controladorCampoNome,
                  dica: _dicaCampoNome,
                  rotulo: _rotuloCampoNome,
                  inputType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Editor(
                  dica: _dicaCampoId,
                  controlador: _controladorCampoId,
                  rotulo: _rotuloCampoId,
                  inputType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () => _criaCliente(context),
                  child: const Text(_textoBotaoConfirmar),
                ),
              ),
            ],
          ),
        ));
  }

  void _criaCliente(BuildContext context) {
    final String nome = _controladorCampoNome.text;
    final String cpf = _controladorCampoId.text;
    if (nome.isNotEmpty && cpf.isNotEmpty) {
      final clienteCriado = Cliente(nome, cpf);
      Navigator.pop(context, clienteCriado);
    }
  }
}
