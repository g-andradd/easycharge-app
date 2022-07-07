import 'package:flutter/material.dart';

import '../models/cliente.dart';

class WizardCadastroDeClienteState extends ChangeNotifier {
  String _nome = '';
  String _cpf = '';
  String _telefone = '';
  String _email = '';
  String _rua = '';
  String _numero = '';
  String _complemento = '';
  String _bairro = '';
  String _cidade = '';
  String _estado = '';
  String _profissao = '';
  double _renda = 0;
  String _status = '';

  int _passoAtual = 0;
  int _quantidadeDeEtapas = 2;

  int get passoAtual => _passoAtual;

  void avanca() {
    _passoAtual += 1;
    notifyListeners();
  }

  void volta() {
    if (_passoAtual > 0) {
      _passoAtual -= 1;
      notifyListeners();
    }
  }

  int get quantidadeDeEtapas => _quantidadeDeEtapas;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get rua => _rua;

  set rua(String value) {
    _rua = value;
  }

  String get numero => _numero;

  set numero(String value) {
    _numero = value;
  }

  String get complemento => _complemento;

  set complemento(String value) {
    _complemento = value;
  }

  String get bairro => _bairro;

  set bairro(String value) {
    _bairro = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get profissao => _profissao;

  set profissao(String value) {
    _profissao = value;
  }

  double get renda => _renda;

  set renda(double value) {
    _renda = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  Cliente criaCliente() {
    Cliente cliente = Cliente(_nome, _cpf, _telefone, _email, _rua,
      _numero, _bairro, _cidade, _estado, _profissao, _renda, _status,);
    if(_complemento.isNotEmpty){
      cliente.complemento = _complemento;
    }

    _cpf = '';
    _nome = '';
    _telefone = '';
    _email = '';
    _rua = '';
    _numero = '';
    _complemento = '';
    _bairro = '';
    _cidade = '';
    _estado = '';
    _profissao = '';
    _renda = 0;
    _status = '';

    return cliente;
  }
}