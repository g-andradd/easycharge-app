import 'package:easycharge_mobile/models/cliente.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() {
  getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'easycharge.db');
    openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE clientes('
          'id INTEGER PRIMARY KEY, '
          'nome TEXT, '
          'cpf TEXT, '
          'telefone TEXT, '
          'email TEXT, '
          'rua TEXT, '
          'numero TEXT, '
          'bairro TEXT, '
          'cidade TEXT, '
          'estado TEXT, '
          'profissao TEXT, '
          'renda REAL, '
          'status TEXT)');
    }, version: 1);
  });
}

void save(Cliente cliente) {
  
}