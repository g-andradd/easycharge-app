import 'package:brasil_fields/brasil_fields.dart';
import 'package:easycharge_mobile/compenents/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../compenents/camposForm.dart';
import '../../models/cliente.dart';

const _tituloAppBar = 'Cadastro de Cliente';

const _rotuloCampoNome = 'Nome';
const _dicaCampoNome = 'Nome Completo';

const _rotuloCampoCpf = 'CPF';
const _dicaCampoCpf = '000.000.000-00';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioCliente extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioClienteState();
  }
}

class FormularioClienteState extends State<FormularioCliente> {
  final TextEditingController _controladorCampoNome = TextEditingController();
  final TextEditingController _controladorCampoCpf = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: _construirFormulario(context),
      ),
      backgroundColor: Theme
          .of(context)
          .secondaryHeaderColor,
    );
  }

  void _criaCliente(BuildContext context) {

    final String nome = _controladorCampoNome.text;
    final String cpf = _controladorCampoCpf.text;
    if (_formkey.currentState!.validate()) {
      final clienteCriado = Cliente(nome, cpf);
      Navigator.pop(context, clienteCriado);
    }
    else {
      exibirAlerta(context: context, titulo: 'Alerta!', content: 'Erro ao cadastrar o cliente.');
    }
  }

  Widget _construirFormulario(context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          CampoForm(
            controlador: _controladorCampoNome,
            dica: _dicaCampoNome,
            rotulo: _rotuloCampoNome,
            validacao: (value) {
              if(value!.isEmpty) {
                return 'Informe o nome';
              }
            },
            inputType: TextInputType.name,
          ),

          const SizedBox(height: 15),

          CampoForm(
            dica: _dicaCampoCpf,
            controlador: _controladorCampoCpf,
            rotulo: _rotuloCampoCpf,
            tamanhoMaximo: 14,
            formatos: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validacao: (value) {
              if(value!.isEmpty) {
                return 'Informe o CPF';
              }
              if(value.length < 14) {
                return 'CPF inválido';
              }
            },
            inputType: TextInputType.number,
          ),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _criaCliente(context),
                child: const Text(
                  _textoBotaoConfirmar, style: TextStyle(fontSize: 18.0),),
              ),
            ),
          )
        ],
      ),
    );
  }
}