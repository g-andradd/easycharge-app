import 'package:flutter/material.dart';

class Cliente extends ChangeNotifier {
  late String _nome;
  late String _cpf;
  late String _telefone;
  late String _email;
  late String _rua;
  late String _numero;
  late String _complemento;
  late String _bairro;
  late String _cidade;
  late String _estado;
  late String _profissao;
  late double _renda;
  late String _status;

  Cliente(
    this._nome,
    this._cpf,
    this._telefone,
    this._email,
    this._rua,
    this._numero,
    this._bairro,
    this._cidade,
    this._estado,
    this._profissao,
    this._renda,
    this._status,
  );

  Cliente.vazio();

  String get status => _status;

  set status(String value) {
    _status = value;

    notifyListeners();
  }

  double get renda => _renda;

  set renda(double value) {
    _renda = value;

    notifyListeners();
  }

  String get profissao => _profissao;

  set profissao(String value) {
    _profissao = value;

    notifyListeners();
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;

    notifyListeners();
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;

    notifyListeners();
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;

    notifyListeners();
  }

  String get complemento => _complemento;

  setComplemento(String value) {
    _complemento = value;

    notifyListeners();
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;

    notifyListeners();
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;

    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;

    notifyListeners();
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;

    notifyListeners();
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;

    notifyListeners();
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;

    notifyListeners();
  }

  //tela de cadastro de clientes
  int _stepAtual = 0;

  int get stepAtual => _stepAtual;

  set stepAtual(int value) {
    _stepAtual = value;

    notifyListeners();
  }
}
