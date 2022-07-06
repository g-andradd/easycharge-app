import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../compenents/inputField.dart';
import '../../compenents/mensagem.dart';
import '../../compenents/selectionField.dart';
import '../../models/cliente.dart';
import '../../state/WizardCadastroDeClienteState.dart';
import '../../state/listaDeClientesState.dart';

const _tituloAppBar = 'Cadastro de Cliente';

const _rotuloCampoNome = 'Nome';
const _dicaCampoNome = 'Nome Completo';

const _rotuloCampoCpf = 'CPF';
const _dicaCampoCpf = '000.000.000-00';

class FormularioCliente extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioClienteState();
  }
}

class FormularioClienteState extends State<FormularioCliente> {
  var stepDados = _DadosForm();
  var stepEndereco = _EnderecoForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: _construirFormulario(context),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }

  // void _criaCliente(BuildContext context) {
  //   final String nome = _nomeController.text;
  //   final String cpf = _cpfController.text;
  //   final String telefone = _telefoneController.text;
  //   final String email = _emailController.text;
  //   final String rua = _ruaController.text;
  //   final String numero = _numeroController.text;
  //   final String complemento = _complementoController.text;
  //   final String bairro = _bairroController.text;
  //   final String cidade = _cidadeController.text;
  //   final String estado = _estadoController.text;
  //   final String profissao = _profissaoController.text;
  //   final double? renda =
  //   final String status = _statusController.text;
  //
  //   if (_formDadoskey.currentState!.validate()) {
  //     Cliente clienteCriado = Cliente(
  //       nome,
  //       cpf,
  //       telefone,
  //       email,
  //       rua,
  //       numero,
  //       bairro,
  //       cidade,
  //       estado,
  //       profissao,
  //       renda!,
  //       status,
  //     );
  //     if (complemento.isNotEmpty) {
  //       clienteCriado.complemento = complemento;
  //     }
  //     ListaDeClientesState listaClientes =
  //     Provider.of<ListaDeClientesState>(context, listen: false);
  //     listaClientes.adicionaCliente(clienteCriado);
  //
  //     Navigator.pop(context);
  //   } else {
  //     exibirAlerta(
  //         context: context,
  //         titulo: 'Alerta!',
  //         content: 'Erro ao cadastrar o cliente.');
  //   }
  // }

  Widget _construirFormulario(context) {
    return Consumer<WizardCadastroDeClienteState>(
      builder: (context, wizardState, child) {
        return Stepper(
          currentStep: wizardState.passoAtual,
          onStepContinue: () {
            var funcoes = [_salvarStep1, _salvarStep2];

            funcoes[wizardState.passoAtual](context);
          },
          onStepCancel: () {
            if (wizardState.passoAtual > 0) {
              wizardState.volta();
            }
            // if (wizardState.passoAtual == 0) {
            // print(wizardState.passoAtual);
            //   Navigator.of(context).pop();
            // }
          },
          steps: [
            Step(
              title: const Text('Dados do Cliente'),
              content: stepDados,
            ),
            Step(
              title: const Text('Endereco'),
              content: stepEndereco,
            ),
          ],
        );
      },
    );
  }

  void _salvarStep1(BuildContext context) {
    if (stepDados.isValido()) {
      WizardCadastroDeClienteState state =
          Provider.of<WizardCadastroDeClienteState>(context, listen: false);
      stepDados.armazenaDadosNoWizard(context);

      state.avanca();
    } else {
      exibirAlerta(
          context: context,
          titulo: 'Alerta!',
          content: 'Erro na validação dos dados.\n'
              'Por favor verifique os campos dos dados novamente');
    }
  }

  void _salvarStep2(BuildContext context) {
    if (stepEndereco.isValido()) {
      WizardCadastroDeClienteState state =
          Provider.of<WizardCadastroDeClienteState>(context, listen: false);
      Cliente cliente = state.criaCliente();

      var listaDeClientes =
          Provider.of<ListaDeClientesState>(context, listen: false);
      listaDeClientes.adicionaCliente(cliente);

      state.volta();
      Navigator.of(context).pop();
    } else {
      exibirAlerta(
          context: context,
          titulo: 'Alerta!',
          content: 'Erro na validação do Endereço.\n'
              'Por favor verifique os campos do endereço novamente');
    }
  }
}

class _DadosForm extends StatelessWidget {
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
            InputField(
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

class _EnderecoForm extends StatelessWidget {
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
