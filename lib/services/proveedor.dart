import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/proveedor.dart';

class ProveedorService with ChangeNotifier {
  Future<List<Proveedor>> getProveedores() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/proveedores');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final proveedorResponse = proveedorResponseFromJson(resp.body);
      return proveedorResponse.myProveedor;
    } catch (error) {
      return [];
    }
  }

  Future createProveedor(
      String nombre, String direccion, String telefono, String email) async {
    final uri = Uri.parse('${Environment.apiUrl}/proveedores/new');
    final data = {
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'email': email,
    };

    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future updateProveedor(
    String proveedorId,
    String name,
    String direccion,
    String telefono,
    String email,
  ) async {
    final uri =
        Uri.parse('${Environment.apiUrl}/proveedores/edit/$proveedorId');
    final data = {
      'nombre': name,
      'direccion': direccion,
      'telefono': telefono,
      'email': email,
    };
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  /* Future deleteProveedor(String proveedorId) async {
    final uri =
        Uri.parse('${Environment.apiUrl}/proveedores/delete/$proveedorId');
  }*/
}
