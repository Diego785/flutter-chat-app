import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:realtime_chat/global/environment.dart';
// import 'package:realtime_chat/models/Inventary/category.dart';
import 'package:realtime_chat/models/Inventary/lote.dart';

class LoteService with ChangeNotifier {
  Future<List<Lote>> getLotes() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/lotes');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final loteResponse = loteResponseFromJson(resp.body);
      print(loteResponse.lote);
      print("Hola mundo desde el servicio de lotes");
      return loteResponse.lote;
    } catch (error) {
      print("Hola mundo desde el servicio de lotes error");
      print(error);

      return [];
    }
  }

  Future createLote(DateTime fechaCreacion, DateTime fechaVencimiento,
      DateTime fechaEntrega, String productoId, int cantidad) async {
    final uri = Uri.parse('${Environment.apiUrl}/lotes/new');
    final data = {
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaVencimiento': fechaVencimiento.toIso8601String(),
      'fechaEntrega': fechaEntrega.toIso8601String(),
      'producto': productoId,
      'cantidad': cantidad
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

  Future editLote(
      String loteId,
      DateTime fechaCreacion,
      DateTime fechaVencimiento,
      DateTime fechaEntrega,
      String productoId,
      int cantidad) async {
    final uri = Uri.parse('${Environment.apiUrl}/lotes/edit/$loteId');
    final data = {
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaVencimiento': fechaVencimiento.toIso8601String(),
      'fechaEntrega': fechaEntrega.toIso8601String(),
      'producto': productoId,
      'cantidad': cantidad
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
}
