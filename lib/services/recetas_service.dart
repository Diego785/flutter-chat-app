import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/receta.dart';
import 'package:realtime_chat/models/pacientes.dart';

class RecetasService with ChangeNotifier {
  Future<List<MyReceta>> getRecetas() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/recetas');
      final resp =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      final recetaResponse = recetaFromJson(resp.body);
      return recetaResponse.myReceta;
    } catch (error) {
      return [];
    }
  }

  Future<List<MyPaciente>> getPacientesName() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/usuarios/rolPaciente');
      final resp = await http.get(uri,
          headers: {'Content-Type': 'application/json'});
      final pacienteResponse = pacientesFromJson(resp.body);
      // print(pacienteResponse.myPacientes);
      return pacienteResponse.myPacientes;
    } catch (error) {
      // print('error');
      return [];
    }
  }
}
