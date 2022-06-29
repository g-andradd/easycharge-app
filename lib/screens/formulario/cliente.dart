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
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _profissaoController = TextEditingController();
  final TextEditingController _rendaController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: _construirFormulario(context),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }

  void _criaCliente(BuildContext context) {
    final String nome = _nomeController.text;
    final String cpf = _cpfController.text;
    final String telefone = _telefoneController.text;
    final String email = _emailController.text;
    final String rua = _ruaController.text;
    final String numero = _numeroController.text;
    final String complemento = _complementoController.text;
    final String bairro = _bairroController.text;
    final String cidade = _cidadeController.text;
    final String estado = _estadoController.text;
    final String profissao = _profissaoController.text;
    final double renda = double.parse(_rendaController.text);
    final String status = _cpfController.text;

    if (_formkey.currentState!.validate()) {
      final clienteCriado = Cliente(nome, cpf, telefone, email, rua, numero,
          complemento, bairro, cidade, estado, profissao, renda, status);
      Navigator.pop(context, clienteCriado);
    } else {
      exibirAlerta(
          context: context,
          titulo: 'Alerta!',
          content: 'Erro ao cadastrar o cliente.');
    }
  }

  Widget _construirFormulario(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            CampoForm(
              controlador: _nomeController,
              dica: _dicaCampoNome,
              rotulo: _rotuloCampoNome,
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
            CampoForm(
              dica: _dicaCampoCpf,
              controlador: _cpfController,
              rotulo: _rotuloCampoCpf,
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
            const SizedBox(height: 30),
            CampoForm(
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
                if (value.length < 15) {
                  return 'Telefone incompleto!';
                }
                return null;
              },
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _emailController,
              rotulo: 'Email',
              dica: 'email@email.com',
              validacao: (value) {
                if (value!.isEmpty) {
                  return 'Email não pode ficar em branco!';
                }
                if (!value.contains("@") || !value.contains(".")) {
                  return 'Email inválido!';
                }
                return null;
              },
              inputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _profissaoController,
              rotulo: "Profissão",
              dica: 'profissão',
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _rendaController,
              rotulo: 'Renda',
              dica: '00,00',
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _statusController,
              rotulo: 'Status',
              dica: 'Selecione...',
              inputType: TextInputType.none,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _ruaController,
              rotulo: 'Rua',
              dica: 'Rua A',
              inputType: TextInputType.none,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _numeroController,
              rotulo: 'Número',
              dica: '00',
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _complementoController,
              rotulo: 'Complemento',
              dica: 'Bloco A',
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _bairroController,
              rotulo: 'Bairro',
              dica: 'Setor A',
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _cidadeController,
              rotulo: 'Cidade',
              dica: 'cidade',
              inputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 30),
            CampoForm(
              controlador: _estadoController,
              rotulo: 'Estado',
              dica: 'Selecione...',
              inputType: TextInputType.none,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _criaCliente(context),
                  child: const Text(
                    _textoBotaoConfirmar,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
