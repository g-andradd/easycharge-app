import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../models/cliente.dart';
import '../state/cliente_json_state.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('Request');
    debugPrint('url: ${data.url}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('Response');
    debugPrint('status code: ${data.statusCode}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    return data;
  }
}

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = 'http://192.168.1.7:8080/api/listaClientes';

Future<List<ClienteJson>> findAll() async {
  final Response response = await client.get(Uri.parse(baseUrl));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<ClienteJson> clientes = [];
  for (Map<String, dynamic> clienteJson in decodedJson) {
    ClienteJson cliente = ClienteJson(
      clienteJson['id'],
      clienteJson['nome'],
      clienteJson['cpf'],
      clienteJson['telefone'],
      clienteJson['local'],
      clienteJson['renda'],
      clienteJson['status'],
    );
    clientes.add(cliente);
  }
  return clientes;
}

void save(Cliente cliente) {
  final Map<String, dynamic> clienteMap = {
    'value' : cliente.
  };
  jsonEncode(object)

  client.post(Uri.parse(baseUrl), headers: {
    'Content-type': 'application/json',
    'password': '1000',
  }, body: );
}
