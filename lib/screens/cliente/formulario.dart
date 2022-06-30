import 'package:brasil_fields/brasil_fields.dart';
import 'package:easycharge_mobile/compenents/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../compenents/inputField.dart';
import '../../models/cliente.dart';
import '../../models/listaDeClientes.dart';

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
      backgroundColor: Theme
          .of(context)
          .secondaryHeaderColor,
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
    final double? renda = double.tryParse(_rendaController.text);
    final String status = _cpfController.text;

    if (_formkey.currentState!.validate()) {
      Cliente clienteCriado = Cliente(
        nome,
        cpf,
        telefone,
        email,
        rua,
        numero,
        bairro,
        cidade,
        estado,
        profissao,
        renda!,
        status,
      );
      if (complemento.isNotEmpty) {
        clienteCriado.setComplemento(complemento);
      }
      ListaDeClientes listaClientes = Provider.of<ListaDeClientes>(
          context, listen: false);
      listaClientes.adicionaCliente(clienteCriado);

      Navigator.pop(context);
    } else {
      exibirAlerta(
          context: context,
          titulo: 'Alerta!',
          content: 'Erro ao cadastrar o cliente.');
    }
  }

  Widget _construirFormulario(context) {
    return Consumer<Cliente>(builder: (context, cliente, child) {
      return Stepper(
        currentStep: cliente.stepAtual,
        onStepContinue: () {
          final functions = [
            _salvarStep1,
            _salvarStep2,
            _salvarStep3,
          ];

          return functions[cliente.stepAtual](context);
        },

        onStepCancel: () {
          cliente.stepAtual > 0 ? cliente.stepAtual - 1 : 0;
        },

        steps: _construirSteps(context, cliente),
      );
    });
    // return Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Form(
    //     key: _formkey,
    //     child: Column(
    //       children: <Widget>[
    //         const SizedBox(height: 20),
    //         const Text(
    //           'Cliente: ',
    //           style: TextStyle(fontSize: 20),
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           controlador: _nomeController,
    //           dica: _dicaCampoNome,
    //           rotulo: _rotuloCampoNome,
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Nome não pode ficar em branco!';
    //             }
    //             if (!value.contains(" ")) {
    //               return 'Informe o nome completo';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.name,
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           dica: _dicaCampoCpf,
    //           controlador: _cpfController,
    //           rotulo: _rotuloCampoCpf,
    //           tamanhoMaximo: 14,
    //           formatos: [
    //             FilteringTextInputFormatter.digitsOnly,
    //             CpfInputFormatter(),
    //           ],
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'CPF não pode ficar em branco!';
    //             }
    //             if (value.length < 14) {
    //               return 'CPF inválido!';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.number,
    //         ),
    //         const SizedBox(height: 10),
    //         InputField(
    //           controlador: _telefoneController,
    //           rotulo: 'Telefone',
    //           dica: '(00) 90000-0000',
    //           tamanhoMaximo: 15,
    //           formatos: [
    //             FilteringTextInputFormatter.digitsOnly,
    //             TelefoneInputFormatter(),
    //           ],
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Telefone não pode ficar em branco!';
    //             }
    //             if (value.length < 14) {
    //               return 'Telefone incompleto!';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.phone,
    //         ),
    //         const SizedBox(height: 10),
    //         InputField(
    //           controlador: _emailController,
    //           rotulo: 'Email',
    //           dica: 'email@email.com',
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Email não pode ficar em branco!';
    //             }
    //             if (!value.contains("@") ||
    //                 !value.contains(".") ||
    //                 value.contains(" ")) {
    //               return 'Email inválido!';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.emailAddress,
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           controlador: _profissaoController,
    //           rotulo: "Profissão",
    //           dica: 'profissão',
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Profissão não pode ficar em branco!';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.text,
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           controlador: _rendaController,
    //           rotulo: 'Renda',
    //           dica: '0,00',
    //           formatos: [
    //             FilteringTextInputFormatter.digitsOnly,
    //             RealInputFormatter(),
    //           ],
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Renda não pode ficar em branco!';
    //             }
    //             if (double.tryParse(value)! < 1) {
    //               return 'Renda deve ser maior que 0';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.number,
    //         ),
    //         const SizedBox(height: 30),
    //         DropdownButtonFormField(
    //           isExpanded: true,
    //           style: const TextStyle(fontSize: 20.0),
    //           decoration: const InputDecoration(
    //             labelText: 'Status',
    //             labelStyle: TextStyle(fontSize: 20.0),
    //           ),
    //           items: ['Ativo', 'Suspenso'].map((String status) {
    //             return DropdownMenuItem(
    //               value: status,
    //               child: Text(status),
    //             );
    //           }).toList(),
    //           onChanged: (String? statusSelecionado) {
    //             _statusController.text = statusSelecionado!;
    //           },
    //           validator: (value) {
    //             if (value == null) {
    //               return 'Status não pode ficar em branco!';
    //             }
    //             return null;
    //           },
    //         ),
    //         const SizedBox(height: 50),
    //         const Text(
    //           'Endereço: ',
    //           style: TextStyle(fontSize: 20),
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           controlador: _ruaController,
    //           rotulo: 'Rua',
    //           dica: 'Rua A',
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Rua não pode ficar em branco!';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.none,
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           controlador: _numeroController,
    //           rotulo: 'Número',
    //           dica: '00',
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Número não pode ficar em branco!';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.text,
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           controlador: _complementoController,
    //           rotulo: 'Complemento',
    //           dica: 'Bloco A',
    //           inputType: TextInputType.streetAddress,
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           controlador: _bairroController,
    //           rotulo: 'Bairro',
    //           dica: 'Setor A',
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Bairro não pode ficar em branco!';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.streetAddress,
    //         ),
    //         const SizedBox(height: 30),
    //         InputField(
    //           controlador: _cidadeController,
    //           rotulo: 'Cidade',
    //           dica: 'cidade',
    //           validacao: (value) {
    //             if (value!.isEmpty) {
    //               return 'Cidade não pode ficar em branco!';
    //             }
    //             return null;
    //           },
    //           inputType: TextInputType.streetAddress,
    //         ),
    //         const SizedBox(height: 30),
    //         DropdownButtonFormField(
    //           isExpanded: true,
    //           style: const TextStyle(fontSize: 20.0),
    //           decoration: const InputDecoration(
    //             labelText: 'Estado',
    //             labelStyle: TextStyle(fontSize: 20.0),
    //           ),
    //           items: Estados.listaEstadosSigla.map((String estado) {
    //             return DropdownMenuItem(
    //               value: estado,
    //               child: Text(estado),
    //             );
    //           }).toList(),
    //           onChanged: (String? estadoSelecionado) {
    //             assert(estadoSelecionado != null);
    //             _estadoController.text = estadoSelecionado!;
    //           },
    //           validator: (value) {
    //             if (value == null) {
    //               return 'selecione um estado!';
    //             }
    //             return null;
    //           },
    //         ),
    //         const SizedBox(height: 30),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
    //           child: SizedBox(
    //             width: double.infinity,
    //             child: ElevatedButton(
    //               onPressed: () => _criaCliente(context),
    //               child: const Text(
    //                 _textoBotaoConfirmar,
    //                 style: TextStyle(fontSize: 18.0),
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  _salvarStep1(context) {

  }

  _salvarStep2(context) {

  }

  _salvarStep3(context) {

  }

  _construirSteps(context) {

  }

  _proximostep(context) {
    Cliente cliente = Provider<Cliente>.of(context, listen: false)
  }
}
