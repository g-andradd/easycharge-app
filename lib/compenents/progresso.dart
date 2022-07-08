import 'package:flutter/material.dart';

class Progresso extends StatelessWidget {

  final String message;

  Progresso({this.message = 'Carregando'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          Text(message)
        ],
      ),
    );
  }
}