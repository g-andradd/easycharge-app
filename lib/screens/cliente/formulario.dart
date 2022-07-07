import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../compenents/formulario_cliente/dados.dart';
import '../../compenents/formulario_cliente/endereco.dart';
import '../../compenents/mensagem.dart';
import '../../models/cliente.dart';
import '../../state/wizard_cadastro_cliente_state.dart';
import '../../state/lista_clientes_state.dart';

const _tituloAppBar = 'Cadastro de Cliente';

class FormularioCliente extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioClienteState();
  }
}

class FormularioClienteState extends State<FormularioCliente> {
  var stepDados = DadosForm();
  var stepEndereco = EnderecoForm();

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
              title: const Text(
                'Dados do Cliente',
                style: TextStyle(fontSize: 20),
              ),
              content: stepDados,
            ),
            Step(
              title: const Text(
                'Endereco',
                style: TextStyle(fontSize: 20),
              ),
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
