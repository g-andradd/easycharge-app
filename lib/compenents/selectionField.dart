import 'package:flutter/material.dart';

class SelectionField extends StatelessWidget {

  final String titulo;
  final List<String> itens;
  final void Function(String?) onChangeds;
  final String? Function(String?) valicacao;


  SelectionField({required this.titulo, required this.itens, required this.onChangeds,
    required this.valicacao});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DropdownButtonFormField(
        isExpanded: true,
        style: const TextStyle(fontSize: 20.0, color: Colors.black),
        decoration: InputDecoration(
          labelText: titulo,
          labelStyle: const TextStyle(fontSize: 20.0),
        ),
        items: itens.map((String valor) {
          return DropdownMenuItem(
            value: valor,
            child: Text(valor),
          );
        }).toList(),
        onChanged: onChangeds,
        validator: valicacao,
      ),
    );
  }
}
