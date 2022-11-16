import 'package:http/http.dart' as http;

import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:realtime_chat/models/usuarios_response.dart';
import 'package:realtime_chat/services/auth_service.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');
      final resp;

      final token = await AuthService.getToken();
      if (token != null) {
        resp = await http.get(uri, headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        });
      } else {
        resp = await http.get(uri, headers: {
          'Content-Type': 'application/json',
        });
      }

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
