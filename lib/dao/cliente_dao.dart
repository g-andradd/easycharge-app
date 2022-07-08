// import 'package:easycharge_mobile/models/cliente.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../app_database.dart';
//
// class ClienteDao {
//
//   static const String tableSql = 'CREATE TABLE $_tableName('
//       '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
//       '$_nome TEXT, '
//       '$_cpf TEXT, '
//       '$_telefone TEXT, '
//       '$_email TEXT, '
//       '$_rua TEXT, '
//       '$_numero TEXT, '
//       '$_complemento TEXT, '
//       '$_bairro TEXT, '
//       '$_cidade TEXT, '
//       '$_estado TEXT, '
//       '$_profissao TEXT, '
//       '$_renda REAL, '
//       '$_status TEXT)';
//   static const String _tableName = 'clientes';
//   static const String _id = 'id';
//   static const String _nome = 'nome';
//   static const String _cpf = 'cpf';
//   static const String _telefone = 'telefone';
//   static const String _email = 'email';
//   static const String _rua = 'rua';
//   static const String _numero = 'numero';
//   static const String _complemento = 'complemento';
//   static const String _bairro = 'bairro';
//   static const String _cidade = 'cidade';
//   static const String _estado = 'estado';
//   static const String _profissao = 'profissao';
//   static const String _renda = 'renda';
//   static const String _status = 'status';
//
//   Future<int> save(Cliente cliente) async {
//     final Database db = await getDatabase();
//     Map<String, dynamic> contactMap = _toMap(cliente);
//     return db.insert(_tableName, contactMap);
//   }
//
//   Future<List<Cliente>> findAll() async {
//     final Database db = await getDatabase();
//     final List<Map<String, dynamic>> result = await db.query(_tableName);
//     List<Cliente> clientes = _toList(result);
//     return clientes;
//   }
//
//   Map<String, dynamic> _toMap(Cliente cliente) {
//     final Map<String, dynamic> contactMap = {};
//     contactMap[_nome] = cliente.nome;
//     contactMap[_cpf] = cliente.cpf;
//     return contactMap;
//   }
//
//   List<Cliente> _toList(List<Map<String, dynamic>> result) {
//     final List<Cliente> contacts = [];
//     for (Map<String, dynamic> row in result) {
//       final Cliente cliente = Cliente(
//         row[_id],
//         row[_nome],
//         row[_cpf],
//         row[_telefone],
//         row[_email],
//         row[_rua],
//         row[_numero],
//         row[_bairro],
//         row[_cidade],
//         row[_estado],
//         row[_profissao],
//         row[_renda],
//         row[_status],
//       );
//       contacts.add(cliente);
//     }
//     return contacts;
//   }
// }