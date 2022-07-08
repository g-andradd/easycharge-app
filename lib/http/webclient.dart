import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

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

Future<List<ClienteJson>> findAll() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response =
      await client.get(Uri.parse('http://192.168.1.7:8080/api/listaClientes'));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<ClienteJson> clientes = [];
  for (Map<String, dynamic> clienteJson in decodedJson) {
    ClienteJson(
      clienteJson['id'],
      clienteJson['nome'],
      clienteJson['cpf'],
      clienteJson['telefone'],
      clienteJson['local'],
      clienteJson['renda'],
      clienteJson['status'],
    );
  }
  return clientes;
}
