import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoForm extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final int? tamanhoMaximo;
  final List<TextInputFormatter>? formatos;
  final String? Function(String?)? validacao;
  final TextInputType inputType;


  CampoForm(
      {required this.controlador, required this.rotulo, required this.dica, this.tamanhoMaximo, this.formatos, this.validacao, required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          controller: controlador,
          style: const TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            labelText: rotulo,
            hintText: dica,
          ),
          maxLength: tamanhoMaximo,
          inputFormatters: formatos,
          validator: validacao,
          keyboardType: inputType,
    );
  }
}
