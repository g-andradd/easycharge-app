import 'package:brasil_fields/brasil_fields.dart';
import 'package:easycharge_mobile/compenents/selection_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../state/wizard_cadastro_cliente_state.dart';
import '../input_field.dart';

class DadosForm extends StatelessWidget {
  final _formDadoskey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _profissaoController = TextEditingController();
  final TextEditingController _rendaController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formDadoskey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            InputField(
              controlador: _nomeController,
              dica: 'Nome Completo',
              rotulo: 'Nome',
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Nome não pode ficar em branco!';
                }
                if (!value.contains(" ")) {
                  return 'Informe o nome completo';
                }
                return null;
              },
              inputType: TextInputType.name,
            ),
            const SizedBox(height: 30),
            InputField(
              dica: '000.000.000-00',
              controlador: _cpfController,
              rotulo: 'CPF',
              tamanhoMaximo: 14,
              formatos: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'CPF não pode ficar em branco!';
                }
                if (value.length < 14) {
                  return 'CPF inválido!';
                }
                return null;
              },
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            InputField(
              controlador: _telefoneController,
              rotulo: 'Telefone',
              dica: '(00) 90000-0000',
              tamanhoMaximo: 15,
              formatos: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Telefone não pode ficar em branco!';
                }
                if (value.length < 14) {
                  return 'Telefone incompleto!';
                }
                return null;
              },
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            InputField(
              controlador: _emailController,
              rotulo: 'Email',
              dica: 'email@email.com',
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Email não pode ficar em branco!';
                }
                if (!value.contains("@") ||
                    !value.contains(".") ||
                    value.contains(" ")) {
                  return 'Email inválido!';
                }
                return null;
              },
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            InputField(
              controlador: _profissaoController,
              rotulo: "Profissão",
              dica: 'profissão',
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Profissão não pode ficar em branco!';
                }
                return null;
              },
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            InputField(
              controlador: _rendaController,
              rotulo: 'Renda',
              dica: '0,00',
              formatos: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(),
              ],
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Renda não pode ficar em branco!';
                }
                if (double.tryParse(value)! < 1) {
                  return 'Renda deve ser maior que 0';
                }
                return null;
              },
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            SelectionField(
              onChangeds: (String? statusSelecionado) {
                _statusController.text = statusSelecionado!;
              },
              valicacao: (value) {
                if (value == null) {
                  return 'Status não pode ficar em branco!';
                }
                return null;
              },
              titulo: 'Status',
              itens: const ['Ativo', 'Suspenso'],
            )
          ],
        ),
      ),
    );
  }

  void armazenaDadosNoWizard(context) {
    var state =
        Provider.of<WizardCadastroDeClienteState>(context, listen: false);
    state.cpf = _cpfController.text;
    state.nome = _nomeController.text;
    state.email = _emailController.text;
    state.profissao = _profissaoController.text;
    state.renda = double.tryParse(_rendaController.text)!;
    state.telefone = _telefoneController.text;
  }

  bool isValido() {
    var currentState = _formDadoskey.currentState;
    return currentState != null && currentState.validate();
  }
}
