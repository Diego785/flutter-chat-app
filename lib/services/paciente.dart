import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/paciente.dart';

class PacienteService with ChangeNotifier {
  Future<List<MyPaciente2>> getUsuarioPaciente() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/pacientes');
      print('$uri');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      print('$resp');
      final pacienteResponse = pacienteFromJson(resp.body);
      print('no sirve');
      // print(pacienteResponse.myPacientes);
      return pacienteResponse.myPaciente;
    } catch (error) {
      // print('error');
      return [];
    }
  }
}
