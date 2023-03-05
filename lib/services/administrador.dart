import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/administrador.dart';
import 'package:realtime_chat/services/System/auth_service.dart';

class AdministradorService with ChangeNotifier {
  Future<MyAdministrador?> getAdministrador() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/administradores');
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

      final administradorResponse = administradorFromJson(resp.body);
      return administradorResponse.myAdministrador;
    } catch (error) {
      return null;
    }
  }
}
