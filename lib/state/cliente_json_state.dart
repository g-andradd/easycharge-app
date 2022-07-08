class ClienteJson {

  final int _id;
  String _nome;
  String _cpf;
  String _telefone;
  String _local;
  double _renda;
  String _status;

  ClienteJson(this._id, this._nome, this._cpf, this._telefone, this._local,
      this._renda, this._status);

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  double get renda => _renda;

  set renda(double value) {
    _renda = value;
  }

  String get local => _local;

  set local(String value) {
    _local = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get id => _id;
}