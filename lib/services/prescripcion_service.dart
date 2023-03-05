import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/prescripcion.dart';
import 'package:realtime_chat/services/System/auth_service.dart';


class PrescripcionsService with ChangeNotifier {
  Future<List<PrescripcionElement>> getPrescripcion(String recetaID) async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/prescripciones/get-Prescripcion/$recetaID');
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

      final prescripcionResponse = prescripcionFromJson(resp.body);
      return prescripcionResponse.prescripcion;
    } catch (error) {
      return [];
    }
  }
}