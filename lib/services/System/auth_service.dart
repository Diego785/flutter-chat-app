import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/login_response.dart';
import 'package:realtime_chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  // Create Storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estática
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final uri = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {

    print('entering to the register page');

    this.autenticando = true;

    final data = {'nombre': name, 'email': email, 'password': password};

    print(data);

    final uri = Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    print(resp.statusCode);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    print('Token retrieved: $token'); // Log token value

    final uri = Uri.parse('${Environment.apiUrl}/login/renew');
    print('API URI: $uri');
    final resp;

    if (token != null) {
      resp = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );
      print(
          'Response with token: ${resp.statusCode}, ${resp.body}'); // Log response
    } else {
      print('entering');
      resp = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(
          'Response without token: ${resp.statusCode}, ${resp.body}'); // Log response
    }

    print('Response: ${resp.statusCode}, ${resp.body}'); // Log response

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._saveToken(loginResponse.token);

      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
