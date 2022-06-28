import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final TextInputType inputType;

  Editor(
      {required this.controlador, required this.rotulo, required this.dica, required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: inputType,
    );
  }
}
