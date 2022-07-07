import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/estados.dart';
import '../../state/wizard_cadastro_cliente_state.dart';
import '../input_field.dart';
import '../selection_field.dart';

class EnderecoForm extends StatelessWidget {
  final _formEnderecokey = GlobalKey<FormState>();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formEnderecokey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            InputField(
              controlador: _ruaController,
              rotulo: 'Rua',
              dica: 'Rua A',
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Rua não pode ficar em branco!';
                }
                return null;
              },
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30),
            InputField(
              controlador: _numeroController,
              rotulo: 'Número',
              dica: '00',
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Número não pode ficar em branco!';
                }
                return null;
              },
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            InputField(
              controlador: _complementoController,
              rotulo: 'Complemento',
              dica: 'Bloco A',
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30),
            InputField(
              controlador: _bairroController,
              rotulo: 'Bairro',
              dica: 'Setor A',
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Bairro não pode ficar em branco!';
                }
                return null;
              },
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30),
            InputField(
              controlador: _cidadeController,
              rotulo: 'Cidade',
              dica: 'cidade',
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Cidade não pode ficar em branco!';
                }
                return null;
              },
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30),
            SelectionField(
                titulo: 'Estado',
                itens: Estados.listaEstadosSigla,
                onChangeds: (String? estadoSelecionado) {
                  assert(estadoSelecionado != null);
                  _estadoController.text = estadoSelecionado!;
                },
                valicacao: (value) {
                  if (value == null) {
                    return 'selecione um estado!';
                  }
                  return null;
                }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void armazenaDadosNoWizard(context) {
    var state =
        Provider.of<WizardCadastroDeClienteState>(context, listen: false);
    state.rua = _ruaController.text;
    state.complemento = _complementoController.text;
    state.bairro = _bairroController.text;
    state.cidade = _cidadeController.text;
    state.estado = _estadoController.text;
    state.numero = _numeroController.text;
  }

  bool isValido() {
    var currentState = _formEnderecokey.currentState;
    return currentState != null && currentState.validate();
  }
}
