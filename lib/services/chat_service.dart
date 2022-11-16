import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/mensajes_response.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:realtime_chat/services/auth_service.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioDestiny;

  Future<List<Mensaje>?> getChat(String usuarioID) async {
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');
    final resp;
    final token = await AuthService.getToken();

    if (token != null) {
      print('TOKEN NO NULL');

      resp = await http.get(uri,
          headers: {'Content-Type': 'application/json', 'x-token': token});
    } else {
      print('TOKEN NULL');

      resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
      });
    }

      final mensajesResp = mensajesResponseFromJson(resp.body);

      
      return mensajesResp.mensajes;
  }
}
